// cache memory/register file
// default address pointer width = 4, for 16 registers
module reg_file #(parameter pw=4)(
  input [7:0] dat_in,
  input [1:0] regDst,
  input      clk,
  input      wr_en,sb,          // write enable
  input[1:0] wr_addr,		//t01  // write address pointer
  input [1:0]            rd_addrA,	//t00	  // read address pointers
	input [1:0]		  rd_addrB,//tt01

  output logic[7:0] datA_out, // read data
                    datB_out);

  logic[7:0] core[2**pw];    // 2-dim array  8 wide  16 deep

// reads are combinational

  assign datA_out = core[rd_addrA];
  assign datB_out =  core[wr_addr];

always @(wr_addr) begin
    $write(" wr_addr %b", wr_addr);
   // $write(" addrA %b", datA_out);
  //  $write(" addrB %b", datB_out);
end

// writes are sequential (clocked)
  always_ff @(posedge clk)
    if(wr_en)				   // anything but stores or no ops
	begin
      if (regDst[1:0] == 'b00) begin
      core[wr_addr] <= dat_in; 
      $display(" dat_in  %d   T (wr_addr)%b\n", dat_in,wr_addr[1:0]);
      end else begin
	core[regDst] <= dat_in; 
	$display(" dat_in  db   T (regDst)%b\n", dat_in,regDst[1:0]);
	//wr_addr = regDst;
	end
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