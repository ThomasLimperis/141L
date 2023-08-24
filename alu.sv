// combinational -- no clock
// sample -- change as desired
module alu(
  input[4:0] alu_cmd,    // ALU instructions
  input[7:0] inA, inB,	 // 8-bit wide data path
  input      sc_i,       // shift_carry in
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
$write(" alu_cmd = %b", alu_cmd[4:2]);

  case(alu_cmd[4:2])
	'b000:
		if (alu_cmd[1:0] == 'b00) begin
			rslt = inB;
			$write(" the integer to add is   %b or %d", inB, inB);
		end
		else
			rslt = inA + inB;

  endcase
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