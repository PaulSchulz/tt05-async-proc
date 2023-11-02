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

    output wire       proc,
    output wire       rdy,

    input  wire       clk,
    input  wire       rst_n
    );

    reg [3:0] buf_in1;
    reg [3:0] buf_in2;
    reg [3:0] buf_in3;
    reg [3:0] buf_in4;
    reg [3:0] buf_out;

    reg node_proc;
    reg node_rdy;

    assign out  = buf_out;
    assign proc = node_proc;
    assign rdy  = node_rdy;

    always @(posedge clk) begin
        if (!rst_n) begin
            buf_in1 <= 0;
            buf_in2 <= 0;
            buf_in3 <= 0;
            buf_in4 <= 0;
            node_proc <= 0;
            node_rdy  <= 0;
        end else begin
            buf_in1 <= in1;
            buf_in2 <= in2;
            buf_in3 <= in3;
            buf_in4 <= in4;
            node_proc <= 1;
            node_rdy  <= 0;
        end
    end

    always @(negedge clk) begin
        if (!rst_n) begin
            buf_in1 <= 0;
            buf_in2 <= 0;
            buf_in3 <= 0;
            buf_in4 <= 0;
            node_proc <= 0;
            node_rdy  <= 0;
        end else begin
            node_proc <= 0;
            node_rdy  <= 1;
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
