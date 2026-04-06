# VerySimpleCPU VM Simulator


## Memory-Mapped I/O


| Address         | Description              |
|-----------------|--------------------------|
| `15000–16023`   | Screen (32 × 32 display) |
| `16024`         | `W` key                  |
| `16025`         | `A` key                  |
| `16026`         | `S` key                  |
| `16027`         | `D` key                  |

---

## Usage

Run the simulator with the following command pattern:

```bash
./VerySimpleCPU_fast.py <program.asm> [mode] [options]
