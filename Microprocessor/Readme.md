Based on the opcodes change the machine codes in rom.v in the following format
ROM[even address]= {10'd0, first 6 bits of machine code}
ROM[odd address]=last 16 bits of machine code

machine codes are available in "machinecodes.xlsx"

Run the cu_tb.v with sufficient delay after reset=0;

Check GPR for registers A to H

and 

RAM[address] for Memory operations.

Verify your output with state flow
