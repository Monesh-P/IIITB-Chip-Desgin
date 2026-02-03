module systolic_2x2_sparse (
    input  logic clk,
    input  logic rst,
    input  logic [7:0] a0, a1,
    input  logic [7:0] b0, b1,
    output logic [15:0] c00, c01, c10, c11
);

    logic en00, en01, en10, en11;

    zero_detect z00(a0, b0, en00);
    zero_detect z01(a0, b1, en01);
    zero_detect z10(a1, b0, en10);
    zero_detect z11(a1, b1, en11);

    pe_mac pe00(clk, rst, en00, a0, b0, c00);
    pe_mac pe01(clk, rst, en01, a0, b1, c01);
    pe_mac pe10(clk, rst, en10, a1, b0, c10);
    pe_mac pe11(clk, rst, en11, a1, b1, c11);

endmodule
