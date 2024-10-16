// control decoder
module Control #(parameter opwidth = 3, mcodebits = 3)(
  input [7-1:0] instr,    // subset of machine code (any width you need) //changed from mcodebits
  output logic  Branch, 
     MemtoReg, MemWrite, ALUSrc, RegWrite,li,sb,
  output logic[opwidth-1:0] ALUOp, 
  output logic [1:0]regDst);	//changed from opwidth   // for up to 8 ALU operations
  

always_comb begin
// defaults
  //RegDst 	=   'b00;   // 1: not in place  just leave 0
  Branch 	=   'b0;   // 1: branch (jump)
  MemWrite  =	'b0;   // 1: store to memory
  ALUSrc ='b0;   // 1: immediate  0: second reg file output
  RegWrite  =	'b0;   // 0: for store or no op  1: most other operations 
  MemtoReg  =	'b0;   // 1: load -- route memory instead of ALU to reg_file data in
  ALUOp	    =   'b111; // y = a+0;
 

// sample values only -- use what you need
case(instr[6:4])    // override defaults with exceptions
  'b010:  begin					// store operation
               MemWrite = 'b0;      // write to data mem
               RegWrite = 'b0;      // typically don't also load reg_file
			 end
  //'b0001:  ALUOp      = 'b000;  // add:  y = a+b
  'b111:  begin				  // load
			   MemtoReg = 'b1;    // 
             end
endcase
// ...*/

//Depending on the instructions and registers used, the control values above will be set to either 0 or 1
// in the first case of doing an ADD with R1, R1, R1 everything is set to 0 except regWrite
//$write(" opcode = %b", instr[6:4]);

case(instr[6:4])    // override defaults with exceptions
  'b000:  begin  // add operation
             ALUOp      = 'b000; // No special control signals needed for add
	     RegWrite = 'b1;
           end
  'b001:  begin  // beq operation
             Branch = 'b1; 
    		ALUOp      = 'b001;
           end
  'b010:  begin  // sb operation
             MemWrite = 'b1;      
             RegWrite = 'b0;      // Don't load reg_file
    		ALUOp      = 'b010;
		sb = 'b1;
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
if (li == 'b0 && ALUSrc == 'b1) begin
	ALUSrc = 'b0;
end

if (li =='b0) begin
	ALUSrc      = 'b0;
	if (instr[6:2] == 'b00000 ) begin    // override defaults with exceptions
  //'b00000:  begin  // add operation
	 // No special control signals needed for add
	regDst = instr[1:0];
        Branch = 'b0;
        MemtoReg = 'b0;
       //MemWrite = 'b0;
       RegWrite = 'b0;
       li = 'b1;
	ALUOp = 'b000;
	//$display("\n li = 1,  T%b",regDst[1:0]);
        end
end else begin
 // $display("LI IS ONEEEEEE");
  li = 'b0;
  RegWrite = 'b1;
  ALUOp = 'b000;
  ALUSrc = 'b1;
end

//endcase
  // $write("  ALUOp = %b", ALUOp);
     // $write("  RegDst = %b", RegDst);
   // $write("  Branch = %b", Branch);
   // $write("  MemtoReg = %b", MemtoReg);
   // $write("  MemWrite = %b", MemWrite);
    //$write("  ALUSrc = %b", ALUSrc);
   // $write("  RegWrite = %b", RegWrite);
    //$write("  ALUSrc (li bit) = %b", ALUSrc);
end


  
endmodule