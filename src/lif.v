`ifndef LIF_V
`define LIF_V

`include "lfsr.v"

module lif (
    input  wire [3:0] in1,
    input  wire [3:0] in2,
    input  wire [3:0] in3,
    input  wire [3:0] in4,
    output wire [3:0] out,

    input  wire       clk,
    input  wire       rst_n
    );

    reg  [3:0] state;
    // reg [15:0] rnd;
    wire [15:0] rnd;

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

    lfsr lfsr1(.clk(clk), .reset(1'b0), .enable(1'b1), .lfsr(rnd));

    // Added to remove 'unused input' warnings.
    // See: https://verilator.org/guide/latest/warnings.html#cmdoption-arg-UNUSEDSIGNAL
    wire _unused_ok = &{1'b0,
                    in1[0],     // Part of algorithm
                    in2[1],
                    in3[2],
                    in4[3],
                    rnd[14:0], // Only top-most bit used
                    1'b0};

endmodule


`endif
