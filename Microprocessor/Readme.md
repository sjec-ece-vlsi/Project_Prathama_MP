Based on the opcodes change the machine codes in rom.v in the following format


ROM[even address]= {10'd0, first 6 bits of machine code}

ROM[odd address]=last 16 bits of machine code

machine codes are available in "machinecodes.xlsx"

Run the cu_tb.v with sufficient delay after reset=0;

Check GPR for registers A to H

and 

RAM[address] for Memory operations.

Verify your output with state flow
cu.v    Contains cu2, decoder, biu, eu and fcu
cu2.v  Main controller with Fetch and decode controls
fcu.v Fetch control unit, controls the fetching operation, coordinates with biu to fetch codes from ROM to IR
      Works in two modes
      0- Branch and Jump Operations
      1- Regular Fetch cycle;

