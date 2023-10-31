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

    // instantiate node
    lif node1 (.in1(in1),
               .in2(in2),
               .in3(in3),
               .in4(in4),
               .out(out),

               .clk(clk),
               .rst_n(rst_n));

endmodule

`endif
