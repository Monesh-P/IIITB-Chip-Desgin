module pe_mac (
    input  logic        clk,
    input  logic        rst,
    input  logic        valid,
    input  logic [7:0]  a,
    input  logic [7:0]  b,
    output logic [15:0] acc
);

    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            acc <= 16'd0;
        else if (valid)
            acc <= acc + (a * b);
    end

endmodule
