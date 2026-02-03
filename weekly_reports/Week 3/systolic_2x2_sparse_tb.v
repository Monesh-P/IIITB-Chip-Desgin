module systolic_2x2_sparse_tb;

    logic clk, rst;
    logic [7:0] a0, a1, b0, b1;
    logic [15:0] c00, c01, c10, c11;

    systolic_2x2_sparse dut (
        clk, rst,
        a0, a1,
        b0, b1,
        c00, c01, c10, c11
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        a0 = 0; a1 = 0; b0 = 0; b1 = 0;

        #10 rst = 0;

        // Sparse inputs
        a0 = 8'd1; a1 = 8'd0;
        b0 = 8'd5; b1 = 8'd0;

        #20 $finish;
    end

endmodule
