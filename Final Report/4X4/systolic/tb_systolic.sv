`timescale 1ns/1ps

module tb_systolic_array;

    parameter int N = 4;
    parameter int DATA_W = 8;
    parameter int ACC_W  = 16;

    logic clk, rst;
    logic [DATA_W-1:0] A_in [0:N-1];
    logic [DATA_W-1:0] B_in [0:N-1];
    logic [ACC_W-1:0]  C    [0:N-1][0:N-1];

    logic [DATA_W-1:0] A [0:N-1][0:N-1];
    logic [DATA_W-1:0] B [0:N-1][0:N-1];

    
    systolic_array #(
    .N(N),
    .DATA_W(DATA_W),
    .ACC_W(ACC_W)
) dut (
    .clk (clk),
    .rst (rst),
    .A_in(A_in),
    .B_in(B_in),
    .C   (C)
);


    always #5 clk = ~clk;

    

    int t, i, j;

    initial begin
        clk = 0;
        rst = 1;

        // A matrix
        A[0] = '{1,0,0,4};
        A[1] = '{0,2,0,8};
        A[2] = '{0,0,5,0};
        A[3] = '{0,0,3,4};

        // Identity B
        B[0] = '{0,7,6,0};
        B[1] = '{8,0,0,0};
        B[2] = '{0,0,6,0};
        B[3] = '{0,9,4,0};

        for (i=0;i<N;i++) begin
            A_in[i]=0;
            B_in[i]=0;
        end

        #20 rst = 0;

        // Correct skewed systolic feed
        for (t = 0; t < (4*N-2); t++) begin
            @(posedge clk);

            for (i = 0; i < N; i++)
                A_in[i] = (t-i>=0 && t-i<N) ? A[i][t-i] : 0;

            for (j = 0; j < N; j++)
                B_in[j] = (t-j>=0 && t-j<N) ? B[t-j][j] : 0;
        end

        repeat (4*N) @(posedge clk);

        $display("\n===== MATRIX C (A x B) =====");
        for (i=0;i<N;i++) begin
            for (j=0;j<N;j++)
                $write("%4d ", C[i][j]);
            $write("\n");
        end
        $display("===========================\n");

        $finish;
    end
endmodule
