module pe_mac_tb;

    logic clk, rst, valid;
    logic [7:0] a, b;
    logic [15:0] acc;

    pe_mac dut (
        .clk(clk),
        .rst(rst),
        .valid(valid),
        .a(a),
        .b(b),
        .acc(acc)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        valid = 0;
        a = 0;
        b = 0;

        #10 rst = 0;

        // MAC operation
        a = 8'd2; b = 8'd3; valid = 1; // acc = 6
        #10 valid = 0;                 // hold

        // Another MAC
        a = 8'd4; b = 8'd5; valid = 1; // acc = 26
        #20 $finish;
    end

endmodule
