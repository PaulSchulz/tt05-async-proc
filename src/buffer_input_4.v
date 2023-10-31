module buffer_input_4 (
    parameter N = 4

    input  wire [N:0] in,
    output wire [N:0] out,

    input wire  store,
    input wire  reset
)

reg [N:0] state;

assign out = state;

always @(posedge store) begin
    if (reset) begin
        state <= 0;
    else
        state <= in;
end

endmodule
