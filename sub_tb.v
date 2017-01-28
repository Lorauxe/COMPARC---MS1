`include "sub.v"

module sub_tb();

reg  elk;
reg [2:0] sel;
reg [31:0] opA, opB;
wire [31:0] res;
wire z, c, v;

initial begin
  $dumpfile("sub.vcd"); 
  $dumpvars(elk, sel, opA, opB, res, z, c, v);
  elk = 1;
  #5
  sel = 3'b001;
  opA = 32'd10;// 0000 0000 0000 0000 0000 0000 0000 1010
  opB = 32'd2; //  0000 0000 0000 0000 0000 0000 0000 0010
  //res = 0000 0000 0000 0000 0000 0000 0000 1000
  //z=0, c=1, v=0
  
  #10
  sel = 3'b001;
  opA = 32'd0;// 0000 0000 0000 0000 0000 0000 0000 0000
  opB = 32'd0; // 0000 0000 0000 0000 0000 0000 0000 0000
  //res = 0000 0000 0000 0000 0000 0000 0000 0000
  //z=1, c=0, v=0
  
  #10
  sel = 3'b001;
  opA = 32'd2; // 0000 0000 0000 0000 0000 0000 0000 0010
  opB = 32'd2; // 0000 0000 0000 0000 0000 0000 0000 0010
  // res = 0000 0000 0000 0000 0000 0000 0000 0000
  //z=1, c=1, v=0
  
  #10
  $finish;
end

// Clock generator
always begin
  #5 elk = ~elk; // Toggle clock every 5 ticks
end

// Connect DUT to test bench
subtraction U_subtraction (
elk,
opA, opB,
sel, res, z, c, v
);

endmodule