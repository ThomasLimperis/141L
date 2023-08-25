// combinational -- no clock
// sample -- change as desired
module alu(
  input[6:0] alu_cmd,    // ALU instructions
  input[7:0] inA, inB,	 // 8-bit wide data path
  input      sc_i, li,  ALUSrc ,    // shift_carry in //if ALUSrc we know we are doing li
  output logic [1:0]regDst,
  output logic[7:0] rslt,
  output logic sc_o,     // shift_carry out
               pari,     // reduction XOR (output)
			   zero      // NOR (output)
);

always_comb begin
  rslt = 'b0;
  sc_o = 'b0;
  zero = !rslt;
  pari = ^rslt;
$write(" alu_cmd = %b", alu_cmd[6:4]);
if (ALUSrc == 'b1) begin
	rslt = inB;
	$write(" the integer to add is   %b or %d into regDst %b", inB, inB,regDst[1:0]);
	//ALUSrc = 'b0;
end else begin
if (li =='b0) begin
  case(alu_cmd[6:4])
	'b000:
		if (alu_cmd[3:2] == 'b00) begin
			rslt = inB;
			//$write(" the integer to add is   %b or %d", inB, inB);
		end
		else
			rslt = inA + inB;

  endcase
end
end
$write (" result = %d", rslt);
$write(" inA = %b", inA);
$write(" inB = %b\n", inB);

 

end

  
endmodule
/*case(alu_cmd)
    3'b000: // add 2 8-bit
      {sc_o,rslt} = inA + inB + sc_i;
    3'b001: // beq (branch if equal)
      rslt = (inA == inB) ? 8'b0000_0001 : 8'b0000_0000;
    3'b010: // sb (store byte) - pass through A for simplicity
      rslt = inA;	//TODO
    3'b011: // lbu (load byte unsigned) - pass through A ensuring it's treated as unsigned
      rslt = inA;   //TODO
    3'b100: // bitwise XOR
      rslt = inA ^ inB;
    3'b101: // bitwise OR
      rslt = inA | inB;
    3'b110: // bitwise AND
      rslt = inA & inB;
    3'b111: // srl (shift right logical)
      {rslt,sc_o} = {sc_i,inA};
    default:
      rslt = 8'b0000_0000;
  endcase*/