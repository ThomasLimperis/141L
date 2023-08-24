when you work on the project 

git pull
git add "selected file"
git commit -m "did this change or whatever"
git push -u origin main

please have output as neat as you can if you make changes and always test/run code to make sure 
that it does work as intended 


hoping for output like this, but I noticed changing one thing slightly ends up messing it up so just try and make it neat
so the next person can debug without having to change stuff.



# Core[0] = 111000111
# Core[1] = 000100111
# Core[2] = 110011000
# Core[3] = 000011001
#     alu_cmd = xxx  result =   0  inA = xxxxxxxx  inB = xxxxxxxx  alu_cmd = xxx
#      opcode = xxx  ALUOp = 111  Branch = 0  MemtoReg = 0  MemWrite = 0  ALUSrc = 0  RegWrite = 1prog_ctr =    x, Machine Code = xxxxxxxxxprog_ctr =    0, Machine Code = 111000111    destR 00     opcode = 111  ALUOp = 111  Branch = 0  MemtoReg = 0  MemWrite = 0  ALUSrc = 0  RegWrite = 1    alu_cmd = 111  result =   0  inA = xxxxxxxx  inB = xxxxxxxx  alu_cmd = 111
# prog_ctr =    1, Machine Code = 000100111    destR 10     opcode = 000  ALUOp = 000  Branch = 0  MemtoReg = 0  MemWrite = 0  ALUSrc = 0  RegWrite = 1    alu_cmd = 000  result =   x  inA = xxxxxxxx  inB = xxxxxxxx  alu_cmd = 000
# 
# Reset signal in Testbench = 0
# prog_ctr =    2, Machine Code = 110011000    destR 01     opcode = 110  ALUOp = 111  Branch = 0  MemtoReg = 0  MemWrite = 0  ALUSrc = 0  RegWrite = 1    alu_cmd = 110  result =   0  inA = 00000001  inB = 00000001  alu_cmd = 110
# prog_ctr =    3, Machine Code = 000011001     opcode = 000  ALUOp = 000  Branch = 0  MemtoReg = 0  MemWrite = 0  ALUSrc = 0  RegWrite = 1    alu_cmd = 000  result =   2  inA = 00000001  inB = 00000001  alu_cmd = 000
# prog_ctr =    4, Machine Code = 001010101     opcode = 001  ALUOp = 111  Branch = 0  MemtoReg = 0  MemWrite = 0  ALUSrc = 0  RegWrite = 1    alu_cmd = 001  result =   0  inA = 00000001  inB = 00000001  alu_cmd = 001
# prog_ctr =    5, Machine Code = 110101010    destR 10     opcode = 110  ALUOp = 111  Branch = 0  MemtoReg = 0  MemWrite = 0  ALUSrc = 0  RegWrite = 1    alu_cmd = 110  result =   0  inA = 00000001  inB = 00000001  alu_cmd = 110
# prog_ctr =    6, Machine Code = 111000111    destR 00     opcode = 111  ALUOp = 111  Branch = 0  MemtoReg = 0  MemWrite = 0  ALUSrc = 0  RegWrite = 1    alu_cmd = 111  result =   0  inA = xxxxxxxx  inB = 00000001  alu_cmd = 111
# prog_ctr =    7, Machine Code = 110011000    destR 01     opcode = 110  ALUOp = 111  Branch = 0  MemtoReg = 0  MemWrite = 0  ALUSrc = 0  RegWrite = 1    alu_cmd = 110  result =   0  inA = 00000001  inB = 00000001  alu_cmd = 110