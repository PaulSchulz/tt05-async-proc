`default_nettype none

`include "block.v"

module tt_um_async_proc_paulschulz  (
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
    );

    // use bidirectionals as outputs
    assign uio_oe = 8'b11111111;
    assign uio_out [7:0] = 8'd0;

    assign uo_out [7:4] = 4'd0;

    reg [3:0] bk_in1;
    reg [3:0] bk_in2;
    reg [3:0] bk_in3;
    reg [3:0] bk_in4;
    reg [3:0] bk_out;
  
    assign uo_out[3:0] = bk_out; 

    always @(posedge clk) begin
        if (!rst_n) begin
            bk_in1 <= 0;
            bk_in2 <= 0;
            bk_in3 <= 0;
            bk_in4 <= 0;
        end else begin
            // Toggle inputs into registers
            if (ui_in[4] == 1'b1)
              bk_in1 <= ui_in[3:0];
            if (ui_in[5] == 1'b1)
              bk_in2 <= ui_in[3:0];
            if (ui_in[6] == 1'b1)
              bk_in3 <= ui_in[3:0];
            if (ui_in[7] == 1'b1)
              bk_in4 <= ui_in[3:0];
        end
    end

    // instantiate
    block block1 (.in1(bk_in1),
                  .in2(bk_in2),
                  .in3(bk_in3),
                  .in4(bk_in4),
                  .out(bk_out),

                  .clk(clk),
                  .rst_n(rst_n));

    // Added to remove 'unused input' warnings.
    // See: https://verilator.org/guide/latest/warnings.html#cmdoption-arg-UNUSEDSIGNAL
    wire _unused_ok = &{1'b0,
                    ena,
                    uio_in,
                    1'b0};


endmodule
    
