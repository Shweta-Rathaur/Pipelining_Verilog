`timescale 1ns / 1ps

module pipelining_testbench;

  reg clk1, clk2;
  integer k;

  // Instantiate the MIPS32 pipeline module
  pipelining_MIPS32 DUT(clk1, clk2);

  // Clock Generation
  initial begin
    clk1 = 0; clk2 = 0;
    forever begin
      #5 clk1 = ~clk1;
      #5 clk2 = ~clk2;
    end
  end

  // Stimulus
  initial begin
    // Initialize registers
    for (k = 0; k < 32; k = k + 1)
      DUT.Register[k] = k;

    // Data Memory Initialization
    DUT.Memory[100] = 32'd555;  // for LW
    DUT.Memory[104] = 32'd999;  // extra data

    // Instruction Memory Initialization
    k = 0;

    // R1 = R2 + R3
    DUT.Memory[k] = {6'b000000, 5'd2, 5'd3, 5'd1, 11'd0}; k = k + 1;

    // R4 = R1 - R5
    DUT.Memory[k] = {6'b000001, 5'd1, 5'd5, 5'd4, 11'd0}; k = k + 1;

    // R6 = R4 + 10 (ADDI)
    DUT.Memory[k] = {6'b001010, 5'd4, 5'd6, 16'd10}; k = k + 1;

    // R7 = MEM[R6 + 94] (LW)
    DUT.Memory[k] = {6'b001000, 5'd6, 5'd7, 16'd94}; k = k + 1;

    // MEM[R6 + 98] = R7 (SW)
    DUT.Memory[k] = {6'b001001, 5'd6, 5'd7, 16'd98}; k = k + 1;

    // BNEQZ R7, offset=2 (should not branch if R7 ≠ 0)
    DUT.Memory[k] = {6'b001101, 5'd7, 5'd0, 16'd2}; k = k + 1;

    // MUL R8 = R1 * R2
    DUT.Memory[k] = {6'b000101, 5'd1, 5'd2, 5'd8, 11'd0}; k = k + 1;

    // SLT R9 = (R1 < R2)
    DUT.Memory[k] = {6'b000100, 5'd1, 5'd2, 5'd9, 11'd0}; k = k + 1;

    // BEQZ R9, offset = -4
    DUT.Memory[k] = {6'b001110, 5'd9, 5'd0, 16'hFFFC}; k = k + 1;

    // HALT
    DUT.Memory[k] = {6'b111111, 26'd0}; k = k + 1;

    // Initialize PC and HALT
    DUT.PC = 0;
    DUT.HALTED = 0;

    // Run simulation
    #500;

    $display("\n----- FINAL REGISTER VALUES -----");
    for (k = 0; k < 10; k = k + 1)
      $display("R[%0d] = %d", k, DUT.Register[k]);

    $display("\n----- FINAL MEMORY VALUES -----");
    $display("MEM[100] = %d", DUT.Memory[100]);
    $display("MEM[104] = %d", DUT.Memory[104]);
    $display("MEM[112] = %d", DUT.Memory[112]); // ✅ Fixed this line

    $finish;
  end

  // Monitoring pipeline during simulation
  initial begin
    $monitor("Time=%0t | PC=%d | R1=%d R4=%d R6=%d R7=%d | HALTED=%b",
              $time, DUT.PC, DUT.Register[1], DUT.Register[4],
              DUT.Register[6], DUT.Register[7], DUT.HALTED);
  end

endmodule
