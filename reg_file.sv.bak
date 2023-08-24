// cache memory/register file
// default address pointer width = 4, for 16 registers
module reg_file #(parameter pw=4)(
  input dat_in,
  input      clk,
  input      wr_en,           // write enable
  input[1:0] wr_addr,		  // write address pointer
  input [1:0]            rd_addrA,		  // read address pointers
	input [1:0]		  rd_addrB,

  output logic[7:0] datA_out, // read data
                    datB_out);

  logic[7:0] core[2**pw];    // 2-dim array  8 wide  16 deep

// reads are combinational
  assign datA_out = core[rd_addrA];
  assign datB_out = core[rd_addrB];
always @(wr_addr) begin
    $write(" destR %b", wr_addr);
end

// writes are sequential (clocked)
  always_ff @(posedge clk)
    if(wr_en)				   // anything but stores or no ops
	begin
      core[wr_addr] <= dat_in; 
      $display("  reg %b has been changed to %d   \n", wr_addr, dat_in);
	end


endmodule
/*
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
*/