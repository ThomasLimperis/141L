// control decoder
module Control #(parameter opwidth = 3, mcodebits = 3)(
  input [mcodebits-1:0] instr,    // subset of machine code (any width you need)
  output logic RegDst, Branch, 
     MemtoReg, MemWrite, ALUSrc, RegWrite,
  output logic[opwidth-1:0] ALUOp);	   // for up to 8 ALU operations

always_comb begin
// defaults
  RegDst 	=   'b0;   // 1: not in place  just leave 0
  Branch 	=   'b0;   // 1: branch (jump)
  MemWrite  =	'b0;   // 1: store to memory
  ALUSrc 	=	'b0;   // 1: immediate  0: second reg file output
  RegWrite  =	'b1;   // 0: for store or no op  1: most other operations 
  MemtoReg  =	'b0;   // 1: load -- route memory instead of ALU to reg_file data in
  ALUOp	    =   'b111; // y = a+0;

// sample values only -- use what you need
/*case(instr)    // override defaults with exceptions
  'b0000:  begin					// store operation
               MemWrite = 'b1;      // write to data mem
               RegWrite = 'b0;      // typically don't also load reg_file
			 end
  'b00001:  ALUOp      = 'b000;  // add:  y = a+b
  'b00010:  begin				  // load
			   MemtoReg = 'b1;    // 
             end
// ...*/

//Depending on the instructions and registers used, the control values above will be set to either 0 or 1
// in the first case of doing an ADD with R1, R1, R1 everything is set to 0 except regWrite
$write("     opcode = %b", instr);

case(instr)    // override defaults with exceptions
  'b000:  begin  // add operation
             ALUOp      = 'b000; // No special control signals needed for add
           end
  'b001:  begin  // beq operation
             Branch = 'b1; 
    		ALUOp      = 'b001;
           end
  'b010:  begin  // sb operation
             MemWrite = 'b1;      
             RegWrite = 'b0;      // Don't load reg_file
    		ALUOp      = 'b010;
           end
  'b011:  begin  // lbu operation
             MemtoReg = 'b1;      // Route memory instead of ALU to reg_file data in
    		ALUOp      = 'b011;
           end
  'b100:  begin  // xor operation
             ALUOp      = 'b100;
           end
  'b101:  begin  // or operation
             ALUOp      = 'b101;
           end
  'b110:  begin  // and operation
             ALUOp      = 'b110;
           end
  'b111:  begin  // srl operation
             ALUOp      = 'b111;
           end
  default: begin
             
           end
// ...
endcase
   $write("  ALUOp = %b", ALUOp);
     // $write("  RegDst = %b", RegDst);
    $write("  Branch = %b", Branch);
    $write("  MemtoReg = %b", MemtoReg);
    $write("  MemWrite = %b", MemWrite);
    $write("  ALUSrc = %b", ALUSrc);
    $write("  RegWrite = %b", RegWrite);

end


  
endmodule