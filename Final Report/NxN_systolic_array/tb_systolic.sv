`timescale 1ns/1ps

module tb_systolic_array;

    parameter int N = 8;
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
        A[0] = '{1,2,3,4,5,6,7,8};
        A[1] = '{1,2,3,4,5,6,7,8};
        A[2] = '{1,2,3,4,5,6,7,8};
        A[3] = '{1,2,3,4,5,6,7,8};
        A[4] = '{1,2,3,4,5,6,7,8};
        A[5] = '{1,2,3,4,5,6,7,8};
        A[6] = '{1,2,3,4,5,6,7,8};
        A[7] = '{1,2,3,4,5,6,7,8};

        // Identity B
        B[0] = '{8,7,6,5,4,3,2,1};
        B[1] = '{8,7,6,5,4,3,2,1};
        B[2] = '{8,7,6,5,4,3,2,1};
        B[3] = '{8,7,6,5,4,3,2,1};
        B[4] = '{8,7,6,5,4,3,2,1};
        B[5] = '{8,7,6,5,4,3,2,1};
        B[6] = '{8,7,6,5,4,3,2,1};
        B[7] = '{8,7,6,5,4,3,2,1};

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
