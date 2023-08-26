// sample top level design
module top_level(
  input        clk, reset, 
  output logic done);
  parameter D = 12,             // program counter width
   //changing A from 3 to 5 for 00000 opcode test
    A = 3;             		  // ALU command bit width 
  wire[D-1:0] target, 			  // jump 
              prog_ctr;
  wire RegWrite = 'b1;
  wire [1:0] regDst;
  wire li = 'b0,sb = 'b0;



   wire m ;

  //wire ALUSrc = 'b0;
  wire[7:0]   datA,datB, dat_in, datA_out, datB_out,		  // from RegFile
              muxB, 
			  rslt;               // alu output
       wire[6:0]       immed;
  logic sc_in,   				  // shift/carry out from/to ALU
   		pariQ,              	  // registered parity flag from ALU
		zeroQ;                    // registered zero flag from ALU 
  wire  relj;                     // from control to PC; relative jump enable
  wire  pari,
        zero,
		sc_clr,
		sc_en;
       wire MemWrite = 'b1;
  wire ALUSrc;
        	              // immediate switch
  wire[7:0] i,val;
  
  wire reg_file = 'b1;
  //alu cmd  changing was A - 1
  wire[7-1:0] alu_cmd;
  wire[8:0]   mach_code;          // machine code
  //wire[8:0]   mach_code2;          // machine code
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
		//.//mach_code2);
  //$display("Machine Code in Top Level = %b", mach_code);


assign alu_cmd  = mach_code[8:2];

// control decoder
  Control ctl1(.instr(alu_cmd), 
  .Branch  (relj)  , 
  .MemWrite ,
  .RegWrite   , 
  .li, .sb,   
   .ALUSrc,
  .MemtoReg(),
  .ALUOp(),
   .regDst);
  



//for add instruction
/*addrC = addrA + addrB
wr_en = 1
write_address = addrC
what is datA,datB, regfile_dat

*/
assign rd_addrA = mach_code[1:0]; //2bit   //addr
  assign rd_addrB = mach_code[3:2];  //2bit 
  assign rd_addrC = mach_code[5:4];  //2bit
  assign immed = mach_code[6:0];
 // assign alu_cmd  = mach_code[8:6];  //3bit
  //wr_en regwrite 1 bit




  reg_file #(.pw(4)) rf1(
              .dat_in(rslt),
	      .regDst,	   // loads, most ops //regfile_dat doesnt exist
              .clk   ,
              .wr_en   (RegWrite),
		.sb,
	      .wr_addr (rd_addrC),
              .rd_addrA,
              .rd_addrB,
                    // in place operation
            .datA_out(datA),
              .datB_out(datB)); 

  //$display("rd_addrA from Machine Code = %b", rd_addrA);
	//$display("rd_addrB from Machine Code = %b", rd_addrB);





  assign muxB = ALUSrc? immed : datB;

  alu alu1(.alu_cmd(alu_cmd),
         .inA    (datA),
		 .inB    (muxB),
		 .sc_i   (sc),
		 .li,   // output from sc register
		 .ALUSrc,
		 .rslt       ,
		 .sc_o   (sc_o), // input to sc register
		 .pari ,
		.zero  );  


  dat_mem dm1(.dat_in(datB) ,  // from reg_file
             .clk           ,
			 .wr_en  (MemWrite),.sb, // stores
			 .addr(datA),
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

  assign done = prog_ctr == 10; //was 128
 
endmodule