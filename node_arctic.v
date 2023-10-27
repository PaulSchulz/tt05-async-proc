// Node logic for running the 'Arctic Circle' calculation
module node_arctic (A,B,C,D,rnd,out,clk,rst_n);

  parameter N = 3;	// default width = 4 bits
  input  [N:0] A;	// A input
  input  [N:0] B;	// B input
  input  [N:0] C;	// C input
  input  [N:0] D;	// D input
  output reg [N:0] out;	// 

  input rnd;        // Random bit
  input clk;
  input rst_n;

  always @(posedge clk) begin
    if(!rst_n) begin
      out = {4'b0000};
    end else begin
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
  end
endmodule
