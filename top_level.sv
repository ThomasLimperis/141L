// sample top level design
module top_level(
  input        clk, reset, 
  output logic done);
  parameter D = 12,             // program counter width
    A = 3;             		  // ALU command bit width
  wire[D-1:0] target, 			  // jump 
              prog_ctr;
  wire RegWrite = 'b1;
  wire[7:0]   datA,datB,		  // from RegFile
              muxB, 
			  rslt,               // alu output
              immed;
  logic sc_in,   				  // shift/carry out from/to ALU
   		pariQ,              	  // registered parity flag from ALU
		zeroQ;                    // registered zero flag from ALU 
  wire  relj;                     // from control to PC; relative jump enable
  wire  pari,
        zero,
		sc_clr,
		sc_en,
        MemWrite,
        ALUSrc;		              // immediate switch
  wire reg_file = 'b1;
  wire[A-1:0] alu_cmd;
  wire[8:0]   mach_code;          // machine code
  wire[1:0] rd_addrA, rd_addrB, rd_addrC;    // address pointers to reg_file
// fetch subassembly
  PC #(.D(D)) 					  // D sets program counter width
     pc1 (.reset            ,
         .clk              ,
		 .reljump_en (relj),
		 .absjump_en (absj),
		 .target           ,
		 .prog_ctr          );

  

// contains machine code
  instr_ROM ir1(.prog_ctr,
               .mach_code);
  //$display("Machine Code in Top Level = %b", mach_code);

// control decoder
  Control ctl1(.instr(alu_cmd),
  .RegDst  (), 
  .Branch  (relj)  , 
  .MemWrite , 
  .ALUSrc   , 
  .RegWrite   ,     
  .MemtoReg(),
  .ALUOp());



//for add instruction
/*addrC = addrA + addrB
wr_en = 1
write_address = addrC
what is datA,datB, regfile_dat

*/
  assign rd_addrA = mach_code[1:0]; //2bit
  assign rd_addrB = mach_code[3:2];  //2bit 
  assign rd_addrC = mach_code[5:4];  //2bit
  assign alu_cmd  = mach_code[8:6];  //3bit
  //wr_en regwrite 1 bit


  reg_file #(.pw(4)) rf1(
              .dat_in(RegWrite),	   // loads, most ops //regfile_dat doesnt exist
              .clk         ,
              .wr_en   (RegWrite),
              .rd_addrA(rd_addrA),
              .rd_addrB(rd_addrB),
              .wr_addr (rd_addrC),      // in place operation
              .datA_out(datA),
              .datB_out(datB)); 

  //$display("rd_addrA from Machine Code = %b", rd_addrA);
	//$display("rd_addrB from Machine Code = %b", rd_addrB);





  assign muxB = ALUSrc? immed : datB;

  alu alu1(.alu_cmd(alu_cmd),
         .inA    (datA),
		 .inB    (muxB),
		 .sc_i   (sc),   // output from sc register
		 .rslt       ,
		 .sc_o   (sc_o), // input to sc register
		 .pari ,
		.zero );  

  dat_mem dm1(.dat_in(datB)  ,  // from reg_file
             .clk           ,
			 .wr_en  (MemWrite), // stores
			 .addr   (datA),
             .dat_out());

// registered flags from ALU
  always_ff @(posedge clk) begin
    pariQ <= pari;
	zeroQ <= zero;
    if(sc_clr)
	  sc_in <= 'b0;
    else if(sc_en)
      sc_in <= sc_o;
  end

  assign done = prog_ctr == 5; //was 128
 
endmodule