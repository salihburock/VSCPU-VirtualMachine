#!/usr/bin/python3

# CAUTION: run 'dos2unix assembler.py' if you get bad interpreter error
# CAUTION: compiler must guarantee that floating-point operations take place on operands which are stored as float (IEEE754) type.

# notes:
# 1. Supported instructions:
#
#    ISA v1:
#    ============================================================================================
#    Arithmetic & Logic Instructions  | Data Transfer Instructions | Program Control Instructions
#    ============================================================================================
#                    ADD              |             CP             |            BZJ
#                    ADDi             |             CPi            |            BZJi
#                    NAND             |             CPI            |
#                    NANDi            |             CPIi           |
#                    SRL              |                            |
#                    SRLi             |                            |
#                    LT               |                            |
#                    LTi              |                            |
#                    MUL              |                            |
#                    MULi             |                            |
#
#    ISA v2:
#    ============================================================================================
#    Arithmetic & Logic Instructions  | Data Transfer Instructions | Program Control Instructions
#    ============================================================================================
#                    NAND             |             CP             |            BZ
#                    ADD              |             CPi            |            JMP
#                    ADDF             |             CPI            |
#                    ADDi             |             CPIr           |
#                    LT               |                            |
#                    LTF              |                            |
#                    SRL              |                            |
#                    SRLi             |                            |
#                    MUL              |                            |
#                    MULF             |                            |
# 2. -x option only generates .coe, .mif, .bin, .hex, and .v files (other memory initialization files will be supported later).
# 3. Default MEM_SIZE is 16384. That is, 16384x32-bit.
# 4. Interrupt support within the simulator will be supported later.
# 5. Catching undefined instructions will be supported later.
# 6. Issues that are caused by storing numbers that exceed 2^32 will be supported later. 


from __future__ import print_function

import re
import sys, getopt
import linecache
import struct
import platform
import time


VM=True
if VM:
    import cv2
    import numpy as np

    def show_grid(matrix):
        # Convert list to numpy, scale 1s to 255 (white), and resize to 480x480 pixels
        img = cv2.resize(np.array(matrix, dtype=np.uint8) * 255, (480, 480), interpolation=cv2.INTER_NEAREST)
        cv2.imshow("Grid", img)
        cv2.waitKey(1)  # Refreshes the window instantly without blocking

    key_data = [("KEY_W",16024),("KEY_A",16025),("KEY_S",16026),("KEY_D",16027)]
    from evdev import InputDevice, categorize, ecodes
    device_path = '/dev/input/event3'
    keyboard = InputDevice(device_path)
    print(f"Listening on {keyboard.name}...")

    def check_for_keys():
        try:
            for event in keyboard.read():
                if event.type == ecodes.EV_KEY:
                    key_event = categorize(event)
                    if key_event.keystate == 1:   # pressed
                        return ("down", key_event.keycode)
                    elif key_event.keystate == 0:  # released
                        return ("up", key_event.keycode)
        except BlockingIOError:
            pass
        return None
        
def print_blank_line(line_count):
    for i in range(line_count):
        print("")

def print_header(char, count):
    print("")
    for i in range(count):
        print(char, end="")
    print("")

def print_footer(char, count):
    for i in range(count):
        print(char, end="")
    print("")
        
def print_usage(option=1):
    if option == 0:
        print_blank_line(1)
        print("Invalid syntax. Please run the script as follows:")
    print_blank_line(1)
    print("BASIC USAGE")
    print("###########")
    print_blank_line(1)
    print("Step-by-step Mode:")
    print('VerySimpleCPU.py example.asm r')
    print_blank_line(1)
    print("Simulate All Mode:")
    print('VerySimpleCPU.py example.asm q')
    print_blank_line(2)

# used a small trick posted on stackoverflow to find out if a string should be float or integer (see https://stackoverflow.com/questions/15357422)
def is_float(x):
    try:
        a = float(x)
    except ValueError:
        return False
    else:
        return True

def is_int(x):
    try:
        a = float(x)
        b = int(a)
    except ValueError:
        return False
    else:
        return a == b

class VerySimpleCPUSim:

    def __init__(self, inputfile="", architecture=1, mem_size=1024, sim_type=0, verbose=False):
        self.inputfile = inputfile
        self.architecture = architecture
        if mem_size != 0:
            self.MEM_SIZE = mem_size
        else:
            self.MEM_SIZE = 16384
        self.sim_type = sim_type
        self.verbose = verbose
        
        if self.verbose:
            print("Class instance is created with following parameters:")
            print(self.inputfile)
            print(self.architecture)
            print(self.MEM_SIZE)
            print(self.sim_type)
            print(self.verbose)

        # memory arrays
        self.mem_array_sim = [0] * self.MEM_SIZE
        self.mem_array_coe = ["0"] * self.MEM_SIZE
        self.mem_array_mif = ["00000000000000000000000000000000"] * self.MEM_SIZE
        self.mem_array_init = ["garbage"] * self.MEM_SIZE # mark unused memory locations as "garbage"
        self.mem_array_bin = [0] * self.MEM_SIZE
        
        # file names
        self.outputfile_coe = "instr_data_memory.coe"
        self.outputfile_mif = "instr_data_memory.mif"
        self.outputfile_init = "instr_data_memory.v"
        self.outputfile_bin = "instr_data_memory.bin"
        self.outputfile_hex_addr = "memout.A"
        self.outputfile_hex_data = "memout.D"
        self.outputfile_sim_output = "memoutd_py.txt"
        self.outputfile_sim_init = "memind_py.txt"
        
        self.program_counter = 0
        self.program_counter_prev = 0
    
        # opcode dictionaries
        self.opcodes_v1 = {"ADD" : 0, "ADDi" : 1, "NAND" : 2, "NANDi" : 3, "SRL" : 4, "SRLi" : 5, "LT" : 6, "LTi" : 7, "CP" : 8, "CPi" : 9, "CPI" : 10, "CPIi" : 11, "BZJ" : 12, "BZJi" : 13, "MUL" : 14, "MULi" : 15}

        self.opcodes_v1_r = {0 : "ADD", 1 : "ADDi", 2 : "NAND", 3 : "NANDi", 4 : "SRL", 5 : "SRLi", 6 : "LT",
                             7 : "LTi", 8 : "CP", 9 : "CPi", 10 : "CPI", 11 : "CPIi", 12 : "BZJ", 13 : "BZJi", 14 : "MUL", 15 : "MULi"}

        self.opcodes_v2 = {"NAND" : 0, "ADD" : 1, "ADDF" : 2, "ADDi" : 3, "LT" : 4, "LTF" : 5, "SRL" : 6, "SRLi" : 7, "MUL" : 8, "MULF" : 9, "CP" : 10, "CPi" : 11, "CPI" : 12, "CPIr" : 13, "BZ" : 14, "JMP" : 15}

        self.opcodes_v2_r = {0 : "NAND", 1 : "ADD", 2 : "ADDF", 3 : "ADDi", 4 : "LT", 5 : "LTF", 6 : "SRL", 7 : "SRLi", 8 : "MUL", 9 : "MULF", 10 : "CP", 11 : "CPi", 12 : "CPI", 13 : "CPIr", 14 : "BZ", 15 : "JMP"}

    def print_error(self, linenum, *operand_index):
        print_header("!", 25)
        print("Error at line", (linenum + 1), ":"),
        if len(operand_index) == 2:
            print("operand", operand_index[0], "and operand", operand_index[1], "must be nonnegative integers")
        else:
            print("operand", operand_index[0], "must be nonnegative integer")
        
        line = linecache.getline(self.inputfile, (linenum + 1)).rstrip()
        print(line)
        print_footer("!", 25)
        sys.exit(1)
    
    def is_instruction_or_data(self, instruction_or_data):
        if self.architecture == 1:
            if instruction_or_data in self.opcodes_v1:
                return 1
            else:
                return 0
        elif self.architecture == 2:
            if instruction_or_data in self.opcodes_v2:
                return 1
            else:
                return 0
        else:
            return 0
    
    def extract_memory_init_file(self):
        fo_sim_init = open(self.outputfile_sim_init, "w")
            
        for i in range(self.MEM_SIZE):
            if self.mem_array_init[i] != "garbage":
                sim_output_line = str(i)
                sim_output_line += ": "
                sim_output_line += str(self.mem_array_sim[i])
                fo_sim_init.write(sim_output_line) 
                if i != (self.MEM_SIZE-1):
                    fo_sim_init.write("\n")
            
        fo_sim_init.close()

    def extract_memory_files(self, school_mode):
        if school_mode:
            fo_sim_output = open(self.outputfile_sim_output, "w")
            
            for i in range(self.MEM_SIZE):
                if self.mem_array_init[i] != "garbage":
                    sim_output_line = str(i)
                    sim_output_line += ": "
                    sim_output_line += str(self.mem_array_sim[i])
                    fo_sim_output.write(sim_output_line) 
                    if i != (self.MEM_SIZE-1):
                        fo_sim_output.write("\n")
            
            fo_sim_output.close()
        else: 
            fo_sim_output.write(sim_output_line)
            fo_coe = open(self.outputfile_coe, "w")
            fo_mif = open(self.outputfile_mif, "w")
            fo_init = open(self.outputfile_init, "w")
            fo_bin = open(self.outputfile_bin, "wb")
            fo_hex_addr = open(self.outputfile_hex_addr, "w")
            fo_hex_data = open(self.outputfile_hex_data, "w")
            fo_coe.write("memory_initialization_radix=16;\n")
            fo_coe.write("memory_initialization_vector=\n")
            for i in range(self.MEM_SIZE):
                fo_coe.write(self.mem_array_coe[i])
                fo_mif.write(self.mem_array_mif[i])
                fo_bin.write(struct.pack('1B', ((self.mem_array_bin[i] & int('0xFF000000', 16)) >> 24)))
                fo_bin.write(struct.pack('1B', ((self.mem_array_bin[i] & int('0x00FF0000', 16)) >> 16)))
                fo_bin.write(struct.pack('1B', ((self.mem_array_bin[i] & int('0x0000FF00', 16)) >> 8)))
                fo_bin.write(struct.pack('1B', ((self.mem_array_bin[i] & int('0x000000FF', 16)) >> 0)))

                if i == (self.MEM_SIZE-1):
                    fo_coe.write(";")
                else:
                    fo_coe.write(",\n")
                    fo_mif.write("\n")

                if self.mem_array_init[i] != "garbage":
                    mem_init_line = "memory"
                    mem_init_line += "["
                    mem_init_line += str(i)
                    mem_init_line += "]"
                    mem_init_line += " "
                    mem_init_line += "="
                    mem_init_line += " "
                    mem_init_line += "32'h"
                    mem_init_line += self.mem_array_init[i]
                    mem_init_line += ";"
                    fo_init.write(mem_init_line)
                    hex_addr = format(i, "08x")
                    if hex_addr == "00000000":
                        fo_hex_addr.write("0")
                    else:
                        fo_hex_addr.write(hex_addr.lstrip("0"))
                    fo_hex_data.write(self.mem_array_init[i])


                    if i != (self.MEM_SIZE-1):
                        fo_init.write("\n")
                        fo_hex_addr.write("\n")
                        fo_hex_data.write("\n")
                        fo_sim_output.write("\n")

            fo_coe.close()
            fo_mif.close()
            fo_init.close()
            fo_bin.close()

    def parse_and_create_memory_image(self):
        linenum = 0

        # if platform.system() == "Darwin":
        #     lineendregex = "\r\n"
        # elif platform.system() == "Linux":
        #     lineendregex = "\n"
        # else:
        #     lineendregex = "\r\n"

        lineendregex = "\n"

        with open(self.inputfile) as fi:
            for line in fi:
            
                # new_line_removed = re.sub(r"\n", "", line)
                new_line_removed = re.sub(r"%s" % lineendregex, "", line)
                new_line_removed = re.sub(r"%s" % "\r\n", "", new_line_removed)
                new_line_removed = re.sub(r"%s" % "\r", "", new_line_removed)
            
                comment_removed = re.sub(r"//.*$", "", new_line_removed)

                if comment_removed == "":
                    continue
                
                #print((comment_removed))
                index = (re.search(r"(\d+)", comment_removed)).group(0)
                                
                instruction_or_data = re.sub(r"(\d+):", "", comment_removed)
                if self.verbose: print(instruction_or_data)

                regex = r"(\w+|\d*\.\d+|\d+)(\ +)([\-]?\w+)(\ +)([\-]?\w+)"

                if self.is_instruction_or_data(re.search(r"(\w+|\d*\.\d+|\d+)", instruction_or_data).group(0)):
                    if self.architecture == 1:
                        opcode = self.opcodes_v1[re.search(regex, instruction_or_data).group(1)]
                    else:
                        opcode = self.opcodes_v2[re.search(regex, instruction_or_data).group(1)]
                    
                    operand_1 = re.search(regex, instruction_or_data).group(3)
                    if(re.search(r"\b0x[0-9A-F]+\b", operand_1)):
                        print(int(operand_1, 0))
                        operand_1 = int(operand_1, 0)
                    operand_2 = re.search(regex, instruction_or_data).group(5)
                    if(re.search(r"\b0x[0-9A-F]+\b", operand_2)):
                        print(int(operand_2, 0))
                        operand_2 = int(operand_2, 0)
                    
                    if self.architecture == 1 and int(operand_2) < 0:
                        if int(operand_1) < 0:
                            self.print_error(int(linenum), 1, 2)
                        self.print_error(int(linenum), 2)
                    
                    elif int(operand_2) < 0 and \
                       ( opcode == self.opcodes_v2["NAND"] or \
                         opcode == self.opcodes_v2["ADD"]  or \
                         opcode == self.opcodes_v2["ADDF"] or \
                         opcode == self.opcodes_v2["LT"]   or \
                         opcode == self.opcodes_v2["LTF"]  or \
                         opcode == self.opcodes_v2["SRL"]  or \
                         opcode == self.opcodes_v2["SRLi"]  or \
                         opcode == self.opcodes_v2["MUL"]  or \
                         opcode == self.opcodes_v2["MULF"] or \
                         opcode == self.opcodes_v2["CP"] or \
                         opcode == self.opcodes_v2["CPI"] or \
                         opcode == self.opcodes_v2["CPIr"] or \
                         opcode == self.opcodes_v2["BZ"]):
                        if int(operand_1) < 0:
                            self.print_error(int(linenum), 1, 2)
                        self.print_error(int(linenum), 2)

                    if int(operand_1) < 0:
                        self.print_error(int(linenum), 1)
                    
                    # used a small trick posted on stackoverflow to generate hex representation of data in .coe and .mif files (see https://stackoverflow.com/questions/7822956)
                    operand_2 = (int(operand_2) + (1 << 32)) % (1 << 32)
                    operand_2 = 0x3FFF & operand_2
                                       
                    instruction_dec = (opcode << 28) | (int(operand_1) << 14) | int(operand_2)
                    
                    
                    instruction_hex = format(instruction_dec, "08x")
                    instruction_hex = instruction_hex.lstrip("0")
                    
                    self.mem_array_sim[int(index)] = instruction_dec
                    self.mem_array_coe[int(index)] = instruction_hex
                    self.mem_array_mif[int(index)] = format(instruction_dec, "032b")
                    self.mem_array_init[int(index)] = instruction_hex
                    self.mem_array_bin[int(index)] = instruction_dec
                else:

                    # print(instruction_or_data, " is data")
                    if(re.search(r"\b0x[0-9A-F]+\b", instruction_or_data)):
                            #print(int(instruction_or_data, 0))
                            instruction_or_data = int(instruction_or_data, 0)

                    instruction_or_data = str(instruction_or_data)


                    # find if data includes a period (.) to understand whether the number is float
                    if is_int(instruction_or_data) and instruction_or_data.find('.') == -1:
                        
                        if self.architecture == 1 and int(instruction_or_data) < 0:
                            self.print_error(int(linenum), 1)

                        

                        # used a small trick posted on stackoverflow to convert a string to int representation of data (see https://stackoverflow.com/questions/379906/)
                        instruction_or_data = float(instruction_or_data)
                        data = int(instruction_or_data)
                        
                        # used a small trick posted on stackoverflow to generate hex representation of data in .coe and .mif files (see https://stackoverflow.com/questions/7822956)
                        data_hex = (int(instruction_or_data) + (1 << 32)) % (1 << 32)
                        data_bin = data_hex
                        data_hex = format(data_hex, "08x")
                        if data_hex == "00000000":
                            data_hex  = "0"
                            self.mem_array_init[int(index)] = data_hex
                        else:
                            data_hex = data_hex.lstrip("0")
                            self.mem_array_sim[int(index)] = data
                            self.mem_array_coe[int(index)] = data_hex
                            self.mem_array_mif[int(index)] = format(data_bin, "032b")
                            self.mem_array_init[int(index)] = data_hex
                            self.mem_array_bin[int(index)] = data
                    elif is_float(instruction_or_data):
                        if self.architecture == 1:
                            self.print_error(int(linenum), 1)
                        
                        # used a method posted on stackoverflow to generate hex representation of float data in .coe and .mif files (see https://stackoverflow.com/questions/23624212)
                        data_hex = hex(struct.unpack('<I', struct.pack('<f', float(instruction_or_data)))[0])
                        data_hex = re.sub(r"(0x)", "", data_hex)
                        # used a method posted on stackoverflow to generate binary representation of float data in .coe and .mif files (see https://stackoverflow.com/questions/16444726)
                        data_bin = ''.join(bin(ord(c)).replace('0b', '').rjust(8, '0') for c in struct.pack('!f', float(instruction_or_data)))
                        if data_hex == "00000000":
                            data_hex  = "0"
                        else:
                            data_hex = data_hex.lstrip("0")
                        self.mem_array_sim[int(index)] = float(instruction_or_data)
                        self.mem_array_coe[int(index)] = data_hex
                        self.mem_array_mif[int(index)] = data_bin
                        self.mem_array_init[int(index)] = data_hex
                        self.mem_array_bin[int(index)] = int(data_hex,16)

                linenum = linenum + 1

    def print_memory_cell(self, opcode, operand_1, operand_2):
        if self.architecture == 1:
            if opcode == self.opcodes_v1["ADD"] or \
               opcode == self.opcodes_v1["NAND"] or \
               opcode == self.opcodes_v1["SRL"] or \
               opcode == self.opcodes_v1["LT"] or \
               opcode == self.opcodes_v1["MUL"] or \
               opcode == self.opcodes_v1["CP"] or \
               opcode == self.opcodes_v1["BZJ"]:
                print("\tmem[", operand_1, "]\t: ", self.mem_array_sim[operand_1])
                print("\tmem[", operand_2, "]\t: ", self.mem_array_sim[operand_2])
            elif opcode == self.opcodes_v1["CPI"]:
                print("\tmem[", operand_1, "]\t: ", self.mem_array_sim[operand_1])
                print("\tmem[", operand_2, "]\t: ", self.mem_array_sim[operand_2])
                print("\tmem[", self.mem_array_sim[operand_2], "]\t: ", self.mem_array_sim[self.mem_array_sim[operand_2]])
            elif opcode == self.opcodes_v1["CPIi"]:
                print("\tmem[", operand_1, "]\t: ", self.mem_array_sim[operand_1])
                print("\tmem[", operand_2, "]\t: ", self.mem_array_sim[operand_2])
                print("\tmem[", self.mem_array_sim[operand_1], "]\t: ", self.mem_array_sim[self.mem_array_sim[operand_1]])
            elif opcode == self.opcodes_v1["ADDi"] or \
                 opcode == self.opcodes_v1["NANDi"] or \
                 opcode == self.opcodes_v1["SRLi"] or \
                 opcode == self.opcodes_v1["LTi"] or \
                 opcode == self.opcodes_v1["MULi"] or \
                 opcode == self.opcodes_v1["CPi"] or \
                 opcode == self.opcodes_v1["BZJi"]:
                print("\tmem[", operand_1, "]          : ", self.mem_array_sim[operand_1])
            
        elif self.architecture == 2:
            if opcode == self.opcodes_v2["NAND"] or \
               opcode == self.opcodes_v2["ADD"]  or \
               opcode == self.opcodes_v2["ADDF"] or \
               opcode == self.opcodes_v2["LT"]   or \
               opcode == self.opcodes_v2["LTF"]  or \
               opcode == self.opcodes_v2["SRL"]  or \
               opcode == self.opcodes_v2["MUL"]  or \
               opcode == self.opcodes_v2["MULF"] or \
               opcode == self.opcodes_v2["CP"] or \
               opcode == self.opcodes_v2["BZ"]:
                print("\tmem[", operand_1, "]\t: ", self.mem_array_sim[operand_1])
                print("\tmem[", operand_2, "]\t: ", self.mem_array_sim[operand_2])
            elif opcode == self.opcodes_v2["CPI"]:
                print("\tmem[", operand_1, "]\t: ", self.mem_array_sim[operand_1])
                print("\tmem[", operand_2, "]\t: ", self.mem_array_sim[operand_2])
                print("\tmem[", self.mem_array_sim[operand_2], "]\t: ", self.mem_array_sim[self.mem_array_sim[operand_2]])
            elif opcode == self.opcodes_v2["CPIr"]:
                print("\tmem[", operand_1, "]\t: ", self.mem_array_sim[operand_1])
                print("\tmem[", operand_2, "]\t: ", self.mem_array_sim[operand_2])
                print("\tmem[", self.mem_array_sim[operand_1], "]\t: ", self.mem_array_sim[self.mem_array_sim[operand_1]])
            elif opcode == self.opcodes_v2["ADDi"] or \
                 opcode == self.opcodes_v2["SRLi"] or \
                 opcode == self.opcodes_v2["CPi"] or \
                 opcode == self.opcodes_v2["JMP"]:
                print("\tmem[", operand_1, "]          : ", self.mem_array_sim[operand_1])
            
    def run_instruction(self, opcode, operand_1, operand_2):

        #print(opcode, operand_1, operand_2)
        if self.architecture == 1:
            if (opcode >= 0 and opcode <= 11) or (opcode >= 14 and opcode <= 15):
                print("\tMemory content before executing instruction")
                self.print_memory_cell(opcode, operand_1, operand_2)
                if self.mem_array_init[operand_1] == "garbage":
                    self.mem_array_init[operand_1] = 0
                                
                if opcode == self.opcodes_v1["ADD"]:
                    # used a small trick posted on stackoverflow to generate 2's complement representation of data for ISA v1 if needed (see https://stackoverflow.com/questions/1604464)
                    if (self.mem_array_sim[operand_1] & (1 << (32 - 1))) != 0:
                        temp_1 = self.mem_array_sim[operand_1] - (1 << 32)
                    else:
                        temp_1 = self.mem_array_sim[operand_1]

                    if (self.mem_array_sim[operand_2] & (1 << (32 - 1))) != 0:
                        temp_2 = self.mem_array_sim[operand_2] - (1 << 32)
                    else:
                        temp_2 = self.mem_array_sim[operand_2]
                    self.mem_array_sim[operand_1] = (temp_1 + temp_2) & 0xFFFFFFFF
                    print((temp_1 + temp_2) & 0xFFFFFFFF)
                elif opcode == self.opcodes_v1["ADDi"]:
                    # used a small trick posted on stackoverflow to generate 2's complement representation of data for ISA v1 if needed (see https://stackoverflow.com/questions/1604464)
                    if (self.mem_array_sim[operand_1] & (1 << (32 - 1))) != 0:
                        temp_1 = self.mem_array_sim[operand_1] - (1 << 32)
                    else:
                        temp_1 = self.mem_array_sim[operand_1]
                    self.mem_array_sim[operand_1] = (temp_1 + operand_2) & 0xFFFFFFFF
                elif opcode == self.opcodes_v1["NAND"]:
                    temp_1 = self.mem_array_sim[operand_1]
                    temp_2 = self.mem_array_sim[operand_2]
                    self.mem_array_sim[operand_1] = (~(temp_1 & temp_2)) & 0xFFFFFFFF
                elif opcode == self.opcodes_v1["NANDi"]:
                    temp_1 = self.mem_array_sim[operand_1]
                    self.mem_array_sim[operand_1] = (~(temp_1 & operand_2) & 0xFFFFFFFF) 
                elif opcode == self.opcodes_v1["SRL"]: # CAUTION: it does not handle negative shift values
                    if self.mem_array_sim[operand_2] < 32:
                        # used a method posted on stackoverflow to get logical shift (see https://stackoverflow.com/questions/5832982)
                        self.mem_array_sim[operand_1] =  (self.mem_array_sim[operand_1] % 0x100000000) >> self.mem_array_sim[operand_2]
                    else:
                        temp_shift_amount = self.mem_array_sim[operand_2]
                        if temp_shift_amount > 64:
                            temp_shift_amount = 64
                        self.mem_array_sim[operand_1] = (self.mem_array_sim[operand_1] % 0x100000000) << (temp_shift_amount - 32)
                    self.mem_array_sim[operand_1] = self.mem_array_sim[operand_1] & 0xFFFFFFFF
                elif opcode == self.opcodes_v1["SRLi"]:
                    if operand_2 < 32:
                        self.mem_array_sim[operand_1] =  (self.mem_array_sim[operand_1] % 0x100000000) >> operand_2
                    else:
                        temp_shift_amount = operand_2
                        if temp_shift_amount > 64:
                            temp_shift_amount = 64
                        self.mem_array_sim[operand_1] =  (self.mem_array_sim[operand_1] % 0x100000000) << (temp_shift_amount - 32)
                    self.mem_array_sim[operand_1] = self.mem_array_sim[operand_1] & 0xFFFFFFFF
                elif opcode == self.opcodes_v1["LT"]:
                    if self.mem_array_sim[operand_1] < self.mem_array_sim[operand_2]:
                        self.mem_array_sim[operand_1] = 1
                    else:
                        self.mem_array_sim[operand_1] = 0
                elif opcode == self.opcodes_v1["LTi"]:
                    if self.mem_array_sim[operand_1] < operand_2:
                        self.mem_array_sim[operand_1] = 1
                    else:
                        self.mem_array_sim[operand_1] = 0
                elif opcode == self.opcodes_v1["MUL"]:
                    # used a small trick posted on stackoverflow to generate 2's complement representation of data for ISA v1 if needed (see https://stackoverflow.com/questions/1604464)
                    if (self.mem_array_sim[operand_1] & (1 << (32 - 1))) != 0:
                        temp_1 = self.mem_array_sim[operand_1] - (1 << 32)
                    else:
                        temp_1 = self.mem_array_sim[operand_1]

                    if (self.mem_array_sim[operand_2] & (1 << (32 - 1))) != 0:
                        temp_2 = self.mem_array_sim[operand_2] - (1 << 32)
                    else:
                        temp_2 = self.mem_array_sim[operand_2]
                    self.mem_array_sim[operand_1] = (temp_1 * temp_2) & 0xFFFFFFFF
                elif opcode == self.opcodes_v1["MULi"]:
                    self.mem_array_sim[operand_1] = self.mem_array_sim[operand_1] * operand_2
                elif opcode == self.opcodes_v1["CP"]:
                    self.mem_array_sim[operand_1] = self.mem_array_sim[operand_2]
                elif opcode == self.opcodes_v1["CPi"]:
                    self.mem_array_sim[operand_1] = operand_2
                elif opcode == self.opcodes_v1["CPI"]:
                    temp = self.mem_array_sim[operand_2]
                    self.mem_array_sim[operand_1] = self.mem_array_sim[temp]
                elif opcode == self.opcodes_v1["CPIi"]:
                    temp_1 = self.mem_array_sim[operand_1]
                    temp_2 = self.mem_array_sim[operand_2]
                    self.mem_array_sim[temp_1] = temp_2
                
                self.program_counter = self.program_counter + 1
            
                print("\tMemory content after executing instruction")
                self.print_memory_cell(opcode, operand_1, operand_2)
            elif opcode == self.opcodes_v1["BZJ"]:
                self.print_memory_cell(opcode, operand_1, operand_2)
                if self.mem_array_sim[operand_2] == 0:
                    self.program_counter = self.mem_array_sim[operand_1]
                else:
                    self.program_counter = self.program_counter + 1
            elif opcode == self.opcodes_v1["BZJi"]:
                self.print_memory_cell(opcode, operand_1, operand_2)
                self.program_counter = self.mem_array_sim[operand_1] + operand_2
            else:
                print("UNDEFINED INSTRUCTION")
                sys.exit(1)
        elif self.architecture == 2:
            if opcode >= 0 and opcode <= 13:
                print("\tMemory content before executing instruction")
                self.print_memory_cell(opcode, operand_1, operand_2)

                if opcode == self.opcodes_v2["NAND"]:
                    self.mem_array_sim[operand_1] = ~(self.mem_array_sim[operand_1] & self.mem_array_sim[operand_2])
                elif opcode == self.opcodes_v2["ADD"]:
                    self.mem_array_sim[operand_1] = self.mem_array_sim[operand_1] + self.mem_array_sim[operand_2]
                elif opcode == self.opcodes_v2["ADDF"]:
                    self.mem_array_sim[operand_1] = float(self.mem_array_sim[operand_1]) + float(self.mem_array_sim[operand_2])
                elif opcode == self.opcodes_v2["ADDi"]:
                    self.mem_array_sim[operand_1] = self.mem_array_sim[operand_1] + operand_2
                elif opcode == self.opcodes_v2["LT"]:
                    if self.mem_array_sim[operand_1] < self.mem_array_sim[operand_2]:
                        self.mem_array_sim[operand_1] = 1
                    else:
                        self.mem_array_sim[operand_1] = 0
                elif opcode == self.opcodes_v2["LTF"]:
                    if float(self.mem_array_sim[operand_1]) < float(self.mem_array_sim[operand_2]):
                        self.mem_array_sim[operand_1] = 1
                    else:
                        self.mem_array_sim[operand_1] = 0
                elif opcode == self.opcodes_v2["SRL"]: # CAUTION: it does not handle negative shift values
                    if self.mem_array_sim[operand_2] < 32:
                        self.mem_array_sim[operand_1] = self.mem_array_sim[operand_1] >> self.mem_array_sim[operand_2]
                    else:
                        self.mem_array_sim[operand_1] = self.mem_array_sim[operand_1] << (self.mem_array_sim[operand_2] - 32)
                elif opcode == self.opcodes_v2["SRLi"]:
                    if operand_2 < 32:
                        self.mem_array_sim[operand_1] = self.mem_array_sim[operand_1] >> operand_2
                    else:
                        self.mem_array_sim[operand_1] = self.mem_array_sim[operand_1] << (operand_2 - 32)
                elif opcode == self.opcodes_v2["MUL"]:
                    self.mem_array_sim[operand_1] = self.mem_array_sim[operand_1] * self.mem_array_sim[operand_2]
                elif opcode == self.opcodes_v2["MULF"]:
                    self.mem_array_sim[operand_1] = float(self.mem_array_sim[operand_1]) * float(self.mem_array_sim[operand_2])
                elif opcode == self.opcodes_v2["CP"]:
                    self.mem_array_sim[operand_1] = self.mem_array_sim[operand_2]
                elif opcode == self.opcodes_v2["CPi"]:
                    self.mem_array_sim[operand_1] = operand_2
                elif opcode == self.opcodes_v2["CPI"]:
                    temp = self.mem_array_sim[operand_2]
                    self.mem_array_sim[operand_1] = self.mem_array_sim[temp]
                elif opcode == self.opcodes_v2["CPIr"]:
                    temp_1 = self.mem_array_sim[operand_1]
                    temp_2 = self.mem_array_sim[operand_2]
                    self.mem_array_sim[temp_1] = temp_2
                
                self.program_counter = self.program_counter + 1
            
                print("\tMemory content after executing instruction")
                self.print_memory_cell(opcode, operand_1, operand_2)
            elif opcode == self.opcodes_v2["BZ"]:
                self.print_memory_cell(opcode, operand_1, operand_2)
                if self.mem_array_sim[operand_2] == 0:
                    self.program_counter = self.mem_array_sim[operand_1]
                else:
                    self.program_counter = self.program_counter + 1
            elif opcode == self.opcodes_v2["JMP"]:
                self.print_memory_cell(opcode, operand_1, operand_2)
                self.program_counter = self.mem_array_sim[operand_1] + operand_2
            else:
                print("UNDEFINED INSTRUCTION")
                sys.exit(1)            

    def run_simulation(self):

        print_blank_line(1)
        print("Starting simulation")
        print_blank_line(1)
        
        if self.sim_type == 0:
            print("run all mode selected")
        else:
            print("step-by-step mode selected")

        print_blank_line(1)      

        # CAUTION: it is assumed that instructions are always placed starting from very beginning of memory, i.e., address zero
        # parsing bits [31-28] to catch an instruction

        sim_finished = False
        
        while(sim_finished == False):

            if self.sim_type == 1:
                if sys.version_info[0] == 2:
                    raw_input("\nPress any key to continue ")
                else:
                    input("\nPress any key to continue ")


            self.cycle_count = 0 

            # ... inside your main VM loop ...
            if VM:
                self.cycle_count += 1
                
                # Check for keys and update memory
                pressed = check_for_keys()
                for i in key_data:
                    if pressed == ("down", i[0]):
                        self.mem_array_sim[i[1]] = 0   
                    elif pressed == ("up", i[0]):
                        self.mem_array_sim[i[1]] = 1   

                # Execute your CPU instruction here
                instruction_or_data = self.mem_array_sim[self.program_counter]
                # ... (rest of your CPU execution logic) ...

                # ONLY update the screen every 1000 CPU cycles
                if self.cycle_count % 1000 == 0:
                    screen = np.zeros((32, 32))
                    for ptr in range(15000, 16024):
                        # Using the fixed modulo math here!
                        screen[(ptr-15000)//32][(ptr-15000)%32] = self.mem_array_sim[ptr]
                    show_grid(screen)


            if not VM:
                instruction_or_data = self.mem_array_sim[self.program_counter]

            opcode = instruction_or_data >> 28
            operand_1 = (instruction_or_data >> 14) & 0x3FFF
            operand_2 = instruction_or_data & 0x3FFF

            print_header("*", 25)
            if self.architecture == 1:
                print("\tcurrent_instruction: ", self.opcodes_v1_r[opcode], operand_1, operand_2)
            elif self.architecture == 2:
                print("\tcurrent_instruction: ", self.opcodes_v2_r[opcode], operand_1, operand_2)
            print("\tprogram counter    : ", self.program_counter)
            self.program_counter_prev = self.program_counter
            self.run_instruction(opcode, operand_1, operand_2)
            print_footer("*", 25)

            if self.program_counter_prev == self.program_counter:
                print("Finishing simulation. Instruction called itself.")
                sim_finished = True
                
def main(argv):
   
    try:
        opts, args = getopt.getopt(argv,"hi:s:a:m:xv",["ifile=", "sim=", "arch=", "mem_size=", "extract_memory_files"])
    except getopt.GetoptError:
        print_usage()
        sys.exit(1)

    inputfile = ""
    extract = False
    verbose = False
    simulate = False
    sim_type = 0
    architecture = 0
    mem_size = 0
    school_mode = False

    if len(argv) == 2 and re.search("\.asm", argv[0]) and argv[1] == 'q':
        inputfile = argv[0]
        architecture = 1
        simulate = True
        sim_type = 0
        extract = True
        school_mode = True
    elif len(argv) == 2 and re.search("\.asm", argv[0]) and argv[1] == 'r':
        inputfile = argv[0]
        architecture = 1
        simulate = True
        sim_type = 1
        extract = True
        school_mode = True
    else: 
        print_usage()
        sys.exit(1)


    if inputfile == "" or architecture == 0 or mem_size < 0:
        print_usage(0)
        sys.exit(1)

    MyVerySimpleCPUSim = VerySimpleCPUSim(inputfile=inputfile, architecture=architecture, mem_size=mem_size, sim_type=sim_type, verbose=verbose)
    
    MyVerySimpleCPUSim.parse_and_create_memory_image()

    if school_mode:
        MyVerySimpleCPUSim.extract_memory_init_file()

    if simulate == True:
        MyVerySimpleCPUSim.run_simulation()

    if extract == True:
        print("Extracting memory initialization files")
        MyVerySimpleCPUSim.extract_memory_files(school_mode)

if __name__ == "__main__":
    main(sys.argv[1:])
