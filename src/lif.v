module lif (
    input  wire [3:0] in1,
    input  wire [3:0] in2,
    input  wire [3:0] in3,
    input  wire [3:0] in4,
    output wire [3:0] out,
    
    input  wire       clk,
    input  wire       rst_n
    );

    reg [3:0] state;
    
    assign out = state;

    always @(posedge clk) begin
       if (!rst_n) begin
           state <= 0;
       end else begin
           state <= {in4[0],in3[0],in2[0],in1[0]};
       end 

    end

endmodule
