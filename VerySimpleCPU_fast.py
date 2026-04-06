#!/usr/bin/python3
"""
VerySimpleCPU Simulator - Optimized
Drop-in replacement for VerySimpleCPU.py.

Usage:
  ./VerySimpleCPU_fast.py example.asm q          # max speed, no display
  ./VerySimpleCPU_fast.py example.asm q --vm      # with VM display + keyboard
  ./VerySimpleCPU_fast.py example.asm r           # step-by-step
  --cps 50000   target cycles/sec in VM mode (default: 50000)
  -v            verbose trace
"""

from __future__ import print_function
import re, sys, struct, time, select

# ── VM imports (optional) ────────────────────────────────────────────────
VM_AVAILABLE = False
try:
    import cv2
    import numpy as np
    try:
        from evdev import InputDevice, ecodes
        keyboard_avaliable = True

    except:
        pass
        keyboard_avaliable = False
    VM_AVAILABLE = True
except ImportError:
    pass


MASK32 = 0xFFFFFFFF
SIGN_BIT = 1 << 31
SCREEN_BASE = 15000
SCREEN_SIZE = 1024

# ── Opcodes ──────────────────────────────────────────────────────────────
MNEMONIC_TO_OP = {
    "ADD":0,"ADDi":1,"NAND":2,"NANDi":3,"SRL":4,"SRLi":5,"LT":6,"LTi":7,
    "CP":8,"CPi":9,"CPI":10,"CPIi":11,"BZJ":12,"BZJi":13,"MUL":14,"MULi":15
}
OP_TO_MNEMONIC = {v: k for k, v in MNEMONIC_TO_OP.items()}

key_pressed = ""


def click_event(event, x, y, flags, param):
    global key_pressed
    # Check if the event is a left mouse button click
    if event == cv2.EVENT_LBUTTONDOWN:
        nx=x-512
        ny=512-y
        if ny>nx and ny>-nx:
            key_pressed="w"
        elif ny>nx and ny<-nx:
            key_pressed="a"
        elif ny<nx and ny<-nx:
            key_pressed="s"
        else:
            key_pressed="d"
        # print(f"Click detected at: x={x}, y={y}")
        # print(key_pressed)
# ── Parser ───────────────────────────────────────────────────────────────
def parse_asm(filename, mem_size=16384):
    mem = [0] * mem_size
    instr_re = re.compile(r"(\w+)\s+([\-]?\w+)\s+([\-]?\w+)")
    with open(filename) as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith('//'):
                continue
            ci = line.find('//')
            if ci >= 0:
                line = line[:ci].strip()
            if not line:
                continue
            colon = line.find(':')
            if colon < 0:
                continue
            try:
                addr = int(line[:colon].strip())
            except ValueError:
                continue
            rest = line[colon+1:].strip()
            if not rest:
                continue
            m = instr_re.match(rest)
            if m and m.group(1) in MNEMONIC_TO_OP:
                op = MNEMONIC_TO_OP[m.group(1)]
                o1 = int(m.group(2))
                o2 = int(m.group(3)) & 0x3FFF
                mem[addr] = (op << 28) | ((o1 & 0x3FFF) << 14) | o2
            else:
                parts = rest.split()
                if parts:
                    try:
                        mem[addr] = int(parts[0]) & MASK32
                    except ValueError:
                        try:
                            mem[addr] = struct.unpack('<I', struct.pack('<f', float(parts[0])))[0]
                        except ValueError:
                            pass
    return mem

# ── Key polling (evdev) ──────────────────────────────────────────────────
# Map evdev key codes to VSCPU memory addresses
# W/Up=16024, A/Left=16025, S/Down=16026, D/Right=16027
if keyboard_avaliable:
    KEY_MAP = {}  # filled at runtime after ecodes is available

    def init_key_map():
        global KEY_MAP
        KEY_MAP = {
            ecodes.KEY_W: 16024,     ecodes.KEY_UP: 16024,
            ecodes.KEY_A: 16025,     ecodes.KEY_LEFT: 16025,
            ecodes.KEY_S: 16026,     ecodes.KEY_DOWN: 16026,
            ecodes.KEY_D: 16027,     ecodes.KEY_RIGHT: 16027,
        }

if keyboard_avaliable:
    def poll_keyboard(keyboard, M):
        """Read all pending keyboard events and update memory. Fast, non-blocking."""
        r, _, _ = select.select([keyboard.fd], [], [], 0)
        if not r:
            return
        try:
            for event in keyboard.read():
                if event.type == ecodes.EV_KEY:
                    addr = KEY_MAP.get(event.code)
                    if addr is not None:
                        if event.value == 1:    # press
                            M[addr] = 0
                        elif event.value == 0:  # release
                            M[addr] = 1
                        # value==2 is repeat, ignore
        except (BlockingIOError, OSError):
            pass

# ── Simulation ───────────────────────────────────────────────────────────
def run_fast(mem, max_cycles=0, verbose=False, step_mode=False,
             vm_enabled=False, target_cps=50000):
    global key_pressed
    pc = 0
    cycles = 0
    M = mem

    # VM setup
    keyboard = None
    screen_buf = None
    if vm_enabled:
        if keyboard_avaliable:
            init_key_map()
        screen_buf = np.zeros((32, 32), dtype=np.uint8)
        # Init keys to "not pressed"
        M[16024] = 1; M[16025] = 1; M[16026] = 1; M[16027] = 1
        try:
            if keyboard_avaliable:
                keyboard = InputDevice('/dev/input/event3')
            print(f"Keyboard: {keyboard.name}")
        except Exception as e:
            print(f"Warning: keyboard: {e}")

    # Timing
    screen_interval = max(1, target_cps // 30)  # ~30 FPS
    next_screen = screen_interval
    t_start = time.monotonic()

    while True:
        # ── Fetch + Decode ───────────────────────────────────────────
        iw = M[pc]
        op = iw >> 28
        a = (iw >> 14) & 0x3FFF
        b = iw & 0x3FFF
        old_pc = pc

        if verbose:
            mn = OP_TO_MNEMONIC.get(op, '???')
            print(f"  {cycles}: PC={pc} {mn} {a} {b} | M[{a}]={M[a]}", end="")
            if op not in (9, 1, 3, 5, 7, 15, 13):  # immediate opcodes
                print(f" M[{b}]={M[b]}", end="")
            print()
        if step_mode:
            input("  [Enter] ")

        # ── Execute ──────────────────────────────────────────────────
        if op == 0:  # ADD
            v1 = M[a]; v2 = M[b]
            if v1 & SIGN_BIT: v1 -= 0x100000000
            if v2 & SIGN_BIT: v2 -= 0x100000000
            M[a] = (v1 + v2) & MASK32; pc += 1
        elif op == 1:  # ADDi
            v1 = M[a]
            if v1 & SIGN_BIT: v1 -= 0x100000000
            M[a] = (v1 + b) & MASK32; pc += 1
        elif op == 2:  # NAND
            M[a] = (~(M[a] & M[b])) & MASK32; pc += 1
        elif op == 3:  # NANDi
            M[a] = (~(M[a] & b)) & MASK32; pc += 1
        elif op == 4:  # SRL
            sh = M[b]; val = M[a] & MASK32
            if sh < 32: M[a] = val >> sh
            else: M[a] = (val << (min(sh, 64) - 32)) & MASK32
            pc += 1
        elif op == 5:  # SRLi
            val = M[a] & MASK32
            if b < 32: M[a] = val >> b
            else: M[a] = (val << (min(b, 64) - 32)) & MASK32
            pc += 1
        elif op == 6:  # LT
            M[a] = 1 if M[a] < M[b] else 0; pc += 1
        elif op == 7:  # LTi
            M[a] = 1 if M[a] < b else 0; pc += 1
        elif op == 8:  # CP
            M[a] = M[b]; pc += 1
        elif op == 9:  # CPi
            M[a] = b; pc += 1
        elif op == 10:  # CPI
            M[a] = M[M[b] & 0x3FFF]; pc += 1
        elif op == 11:  # CPIi
            M[M[a] & 0x3FFF] = M[b]; pc += 1
        elif op == 12:  # BZJ
            pc = M[a] if M[b] == 0 else pc + 1
        elif op == 13:  # BZJi
            pc = (M[a] + b) & 0x3FFF
        elif op == 14:  # MUL
            v1 = M[a]; v2 = M[b]
            if v1 & SIGN_BIT: v1 -= 0x100000000
            if v2 & SIGN_BIT: v2 -= 0x100000000
            M[a] = (v1 * v2) & MASK32; pc += 1
        elif op == 15:  # MULi
            M[a] = (M[a] * b) & MASK32; pc += 1

        cycles += 1

        # ── Halt ─────────────────────────────────────────────────────
        if pc == old_pc:
            return cycles, True, M
        if max_cycles > 0 and cycles >= max_cycles:
            return cycles, False, M

        # ── VM: keyboard + screen ────────────────────────────────────
        if vm_enabled:
            # Poll keyboard every cycle (like original)
            if keyboard and keyboard_avaliable:
                poll_keyboard(keyboard, M)

            # Screen refresh throttled
            if cycles >= next_screen:
                next_screen = cycles + screen_interval
                for i in range(SCREEN_SIZE):
                    screen_buf.flat[i] = 255 if M[SCREEN_BASE + i] else 0
                img = cv2.resize(screen_buf, (480, 480), interpolation=cv2.INTER_NEAREST)
                cv2.imshow("Grid", cv2.resize(img, (1000, 1000)))
                cv2.setMouseCallback("Grid", click_event)

                key = cv2.waitKey(1) & 0xFF

                M[16024] = 1
                M[16025] = 1
                M[16026] = 1
                M[16027] = 1

                # cv2 fallback input
                if key == ord('w') or key_pressed == 'w':
                    M[16024] = 0
                else:
                    M[16024] = 1

                if key == ord('a') or key_pressed == 'a':
                    M[16025] = 0
                else:
                    M[16025] = 1

                if key == ord('s') or key_pressed == 's':
                    M[16026] = 0
                else:
                    M[16026] = 1

                if key == ord('d') or key_pressed == 'd':
                    M[16027] = 0
                else:
                    M[16027] = 1
                if key == ord('q') or key == 27:
                    return cycles, False, M
                key_pressed=""
            # Throttle to target_cps
            expected = cycles / target_cps
            elapsed = time.monotonic() - t_start
            if expected > elapsed:
                time.sleep(expected - elapsed)

    return cycles, False, M

# ── Utils ────────────────────────────────────────────────────────────────
def dump_memory(mem, filename, mem_size=16384):
    with open(filename, 'w') as f:
        for i in range(mem_size):
            if mem[i] != 0:
                f.write(f"{i}: {mem[i]}\n")

def main():
    argv = sys.argv[1:]
    if len(argv) < 2:
        print("Usage: ./VerySimpleCPU_fast.py <file.asm> <q|r> [--vm] [--cps N] [-v]")
        sys.exit(1)

    inputfile = argv[0]
    mode = argv[1]
    verbose = '-v' in argv
    step_mode = (mode == 'r')
    vm_enabled = '--vm' in argv

    target_cps = 50000
    for i, arg in enumerate(argv):
        if arg == '--cps' and i + 1 < len(argv):
            target_cps = int(argv[i + 1])

    if vm_enabled and not VM_AVAILABLE:
        print("Error: --vm requires: pip install opencv-python numpy evdev")
        sys.exit(1)

    print(f"Parsing {inputfile}...")
    mem = parse_asm(inputfile)
    dump_memory(mem, "memind_py.txt")

    vm_str = f"VM @ {target_cps:,} cps" if vm_enabled else "max speed"
    print(f"Simulating ({vm_str})...")

    t0 = time.time()
    cycles, halted, mem = run_fast(mem, verbose=verbose, step_mode=step_mode,
                                    vm_enabled=vm_enabled, target_cps=target_cps)
    elapsed = time.time() - t0

    print(f"\n{'='*40}")
    print(f"  Cycles:  {cycles:,}")
    print(f"  Halted:  {halted}")
    print(f"  Time:    {elapsed:.3f}s")
    if elapsed > 0: print(f"  Speed:   {cycles/elapsed:,.0f} cycles/sec")
    print(f"  mem[14] (T1): {mem[14]}")
    print(f"{'='*40}")

    dump_memory(mem, "memoutd_py.txt")
    if vm_enabled and VM_AVAILABLE:
        try: cv2.destroyAllWindows()
        except: pass

if __name__ == "__main__":
    main()
