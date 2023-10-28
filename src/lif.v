// `include "lfsr.v"

module lif (
    input  wire [3:0] in1,
    input  wire [3:0] in2,
    input  wire [3:0] in3,
    input  wire [3:0] in4,
    output wire [3:0] out,

//    input wire 	      rnd,
    input  wire       clk,
    input  wire       rst_n
    );

    reg  [3:0] state;
    reg [15:0] rnd;
    
    assign out = state;

    always @(posedge clk) begin
      if (!rst_n) begin
           state <= 4'b0000;
      end else begin
          state <= 4'b0000;
          if ((in1[2]&&in3[0]) ^^ (in2[3]&&in4[1]))
              state <= 4'b0000;
          else if (in1[2])
              state <= 4'b0100;
          else if(in3[0])
	      state <= 4'b0001;
          else if(in2[3])
              state <= 4'b1000;
          else if(in4[1])
              state <= 4'b0010;
          else if(in1[1] || in1[3]
                || in2[0] || in2[2]
                || in3[1] || in3[3]
                || in4[0] || in4[2])
              if (rnd[15])
                  state <= 4'b1010;
              else
                  state <= 4'b0101;
       end
    end

    lfsr lfsr(.clk(clk), .reset(1'b0), .enable(1'b1), .lfsr(rnd));
endmodule
