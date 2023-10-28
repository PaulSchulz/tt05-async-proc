module lif (
    input  wire [3:0] A,
    input  wire [3:0] B,
    input  wire [3:0] C,
    input  wire [3:0] D,
    output wire [3:0] out,
    
    input  wire [7:0] current,
    output wire [7:0] next_state,
    output wire       spike,
    input  wire       clk,
    input  wire       rst_n
    
);

    reg [7:0] state, threshold;

    // resting potential and threshold
    assign next_state = current + (state >> 1);
    assign spike = (state >= threshold);

    always @(posedge clk) begin
       out <= {D[0],C[0],B[0],A[0]};
       if (!rst_n) begin
           state <= 0;
           threshold <= 32;
       end else begin
           state <= next_state;
       end 

    end

endmodule
