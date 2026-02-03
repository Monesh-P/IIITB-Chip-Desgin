module systolic_2x2 (
    input  logic clk,
    input  logic rst,
    input  logic enable,
    input  logic [7:0] a0, a1,
    input  logic [7:0] b0, b1,
    output logic [15:0] c00, c01, c10, c11
);

    pe_mac pe00(clk, rst, enable, a0, b0, c00);
    pe_mac pe01(clk, rst, enable, a0, b1, c01);
    pe_mac pe10(clk, rst, enable, a1, b0, c10);
    pe_mac pe11(clk, rst, enable, a1, b1, c11);

endmodule
