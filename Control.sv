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

case(instr)
	'b000: begin
	//add instruction
	ALUOp = 'b000;
	
	end
	default: begin
        ALUOp = 'b111; // default to pass A operation
    end

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