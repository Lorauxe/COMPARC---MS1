`include "alu.v"


module alu_tb();

reg elk;
reg [2:0] sel;
reg signed [31:0] opA, opB;
wire signed [31:0] res;
wire z, c, v;

initial begin
  
  $dumpfile("alu.vcd"); 
  $dumpvars(elk, sel, opA, opB, res, z, c, v);
  elk = 1;
  
  
  //LOGICAL OPERATORS
  #5
  sel = 3'b010; //AND
  opA = 32'd10;// 0000 0000 0000 0000 0000 0000 0000 1010
  opB = 32'd0; //  0000 0000 0000 0000 0000 0000 0000 0000
  //res = 0000 0000 0000 0000 0000 0000 0000 0000
  //z=1
  #10
  sel = 3'b011; //OR
  opA = 32'd15;// 0000 0000 0000 0000 0000 0000 0000 1111
  opB = 32'd7; // 0000 0000 0000 0000 0000 0000 0000 0111
  //res = 0000 0000 0000 0000 0000 0000 0000 1111
  //z=0
  #10
  sel = 3'b100; //NOT, ONLY ONE OPERAND
  opA = 32'hFFFFFFFF;
  //z=1
  
  
  //ADDITION
  #10
  sel = 3'b000; //adding positive to zero
  opA = 32'd10;
  opB = 32'd0; 
  //$display("%d", res);
  //$display("%b", z);
  //$display("%b", c);
  //$display("%b", v);
  
  #10
  sel = 3'b000; //adding positive to negative
  opA = 32'd7;
  opB = -32'd2;
  //$display("%d", res);
  //$display("%b", z);
  //$display("%b", c);
  //$display("%b", v);
  
  #10
  sel = 3'b000; //adding positive to positive
  opA = 32'd15;
  opB = 32'd7; 
  //$display("%d", res);
  //$display("%b", z);
  //$display("%b", c);
  //$display("%b", v);
  
  #10
  sel = 3'b000; //adding negative to negative, carry flag testing
  opA = -32'd5;
  opB = -32'd3;
  //$display("%d", res);
  //$display("%b", z);
  //$display("%b", c);
  //$display("%b", v);
  
  #10
  sel = 3'b000; //adding negative to positive, carry flag testing
  opA = -32'd1;
  opB = 32'd1;
  //$display("%d", res);
  //$display("%b", z);
  //$display("%b", c);
  //$display("%b", v);
  
  //no testing for carryout when adding two positives as it would imply a sum greater than 32 bits (overflow)
  
  #10
  sel = 3'b000; //overflow flag testing
  opA = 32'h7FFFFFFF; 
  opB = 32'h00000001; 
  //$display("%d", res);
  //$display("%b", z);
  //$display("%b", c);
  //$display("%b", v);
  
  #10
  sel = 3'b000; //negative operands, overflow flag testing
  opA = 32'hF0000000;
  opB = 32'h80000000;
  //$display("%d", res);
  //$display("%b", z);
  //$display("%b", c);
  //$display("%b", v);
  
  #10
  sel = 3'b000; //zero flag testing
  opA = 32'd0; 
  opB = 32'd0;
  //$display("%d", res);
  //$display("%b", z);
  //$display("%b", c); 
  //$display("%b", v);
  
  
  //SUBTRACTION
  #10
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
alu U_alu_tb (
elk,
opA, opB,
sel, res, z, c, v
);

endmodule