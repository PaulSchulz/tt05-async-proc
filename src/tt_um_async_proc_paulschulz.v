`default_nettype none

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
    assign uio_out [3:0] = 4'd0;

    assign uo_out [7:0] = 8'd0;

    // instantiate node
    lif node1 (.in1(ui_in[3:0]),
               .in2(ui_in[3:0]),
               .in3(ui_in[3:0]),
               .in4(ui_in[3:0]),
               .out(uio_out[7:4]),

               // .current(ui_in),
               // .next_state(uo_out),
               // .spike(uio_out[0]),

               .clk(clk),
               .rst_n(rst_n));

endmodule
