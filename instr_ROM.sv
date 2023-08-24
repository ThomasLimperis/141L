module instr_ROM #(parameter D=12)(
  input [D-1:0] prog_ctr, // Address pointer
  output logic [8:0] mach_code
);

  logic [8:0] core[2**D];

  initial begin
    // Load the program into core
    $readmemb("mach_code.txt", core);
    $display("Core[0] = %b", core[0]);
    $display("Core[1] = %b", core[1]);
    $display("Core[2] = %b", core[2]);
    $display("Core[3] = %b", core[3]);
  end

  always_comb begin
    mach_code = core[prog_ctr];
    // Display the machine code instruction
    $write("prog_ctr = %d, Machine Code = %b", prog_ctr, mach_code);
  end

endmodule

/*
sample mach_code.txt:

001111110		 // ADD r0 r1 r0
001100110
001111010
111011110
101111110
001101110
001000010
111011110
*/