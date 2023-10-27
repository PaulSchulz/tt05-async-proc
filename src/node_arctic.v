// Node logic for running the 'Arctic Circle' calculation

`ifndef N_ARCTIC_H
`define N_ARCTIC_H

module node_arctic (clk,rnd,A,B,C,D,out);
  input clk;
  input rnd;

  parameter N = 3;	// default width = 4 bits
  input  [N:0] A;	// A input
  input  [N:0] B;	// B input
  input  [N:0] C;	// C input
  input  [N:0] D;	// D input
  output reg [N:0] out;	// 

  always @(*)
  begin
    out = 4'b0000;
      if(A[2]&&C[0] ^^ B[3]&&D[1])
        out = 4'b0000;
      else if(A[2]) 
        out = 4'b0100;
      else if(C[0])
        out = 4'b0001;
      else if(B[3])
        out = 4'b1000;
      else if(D[1])
        out = 4'b0010;
      else if(A[1] || A[3]
        || B[0] || B[2]
        || C[1] || C[3]
        || D[0] || D[2])
        if(rnd)
          out = {4'b1010};
        else
          out = {4'b0101};
  end
endmodule

`endif
