// Wrapper around node to support IO fabric
`ifndef BLOCK_V
`define BLOCK_V

`include "lif.v"

module block (
    input  wire [3:0] in1,
    input  wire [3:0] in2,
    input  wire [3:0] in3,
    input  wire [3:0] in4,
    output wire [3:0] out,

    input  wire       clk,
    input  wire       rst_n
    );

    reg [3:0] buf_in1;
    reg [3:0] buf_in2;
    reg [3:0] buf_in3;
    reg [3:0] buf_in4;
    reg [3:0] buf_out;

    assign out = buf_out;

    always @(posedge clk) begin
        if (reset) begin
            buf_in1 <= 0;
            buf_in2 <= 0;
            buf_in3 <= 0;
            buf_in4 <= 0;
        end else begin
            buf_in1 <= in1;
            buf_in2 <= in2;
            buf_in3 <= in3;
            buf_in4 <= in4;
        end
    end

    // instantiate node
    lif node1 (.in1(buf_in1),
               .in2(buf_in2),
               .in3(buf_in3),
               .in4(buf_in4),
               .out(buf_out),

               .clk(clk),
               .rst_n(rst_n));

endmodule

`endif
