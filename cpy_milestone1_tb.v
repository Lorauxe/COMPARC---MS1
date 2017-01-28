`include "cpy_milestone1.v"

module cpy_milestone1_tb();

reg  elk;
reg [2:0] sel;
reg [31:0] opA, opB;
wire [31:0] res;
wire z, c, v;

initial begin
  $dumpfile("cpy_milestone1.vcd"); 
  $dumpvars(elk, sel, opA, opB, res, z, c, v);
  elk = 1;
  #5
  sel = 3'b010;
  opA = 32'd10;// 0000 0000 0000 0000 0000 0000 0000 1010
  opB = 32'd0; //  0000 0000 0000 0000 0000 0000 0000 0000
  //res = 0000 0000 0000 0000 0000 0000 0000 0000
  //z=1
  #10
  sel = 3'b011;
  opA = 32'd15;// 0000 0000 0000 0000 0000 0000 0000 1111
  opB = 32'd7; // 0000 0000 0000 0000 0000 0000 0000 0111
  //res = 0000 0000 0000 0000 0000 0000 0000 1111
  //z=0
  #10
  sel = 3'b100;
  opA = 32'hFFFFFFFF;
  //z=1
  
  #10
  $finish;
end

// Clock generator
always begin
  #5 elk = ~elk; // Toggle clock every 5 ticks
end

// Connect DUT to test bench
cpy_milestone1 U_cpy_milestone1 (
elk,
opA, opB,
sel, res, z, c, v
);

endmodule