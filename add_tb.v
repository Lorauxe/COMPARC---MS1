`include "add.v"

module add_tb();

reg elk;
reg [2:0] sel;
reg signed [31:0] opA, opB;
wire signed [31:0] res;
wire z, c, v;

initial begin
  //POSITION OF DELAYS CHANGED FOR DISPLAYING OUTPUT [DEBUGGING]
  $dumpfile("add.vcd"); 
  $dumpvars(elk, sel, opA, opB, res, z, c, v);
  elk = 1;
  sel = 3'b000; //adding positive to zero
  opA = 32'd10;
  opB = 32'd0; 
  #5
  $display("%d", res);
  $display("%b", z);
  $display("%b", c);
  $display("%b", v);
  
  sel = 3'b000; //adding positive to negative
  opA = 32'd7;
  opB = -32'd2;
  #10
  $display("%d", res);
  $display("%b", z);
  $display("%b", c);
  $display("%b", v);
  
  sel = 3'b000; //adding positive to positive
  opA = 32'd15;
  opB = 32'd7; 
  #10
  $display("%d", res);
  $display("%b", z);
  $display("%b", c);
  $display("%b", v);
  
  sel = 3'b000; //adding negative to negative, carry flag testing
  opA = -32'd5;
  opB = -32'd3;
  #10
  $display("%d", res);
  $display("%b", z);
  $display("%b", c);
  $display("%b", v);
  
  sel = 3'b000; //adding negative to positive, carry flag testing
  opA = -32'd1;
  opB = 32'd1;
  #10
  $display("%d", res);
  $display("%b", z);
  $display("%b", c);
  $display("%b", v);
  
  //no testing for carryout when adding two positives as it would imply a sum greater than 32 bits (overflow)
  
  sel = 3'b000; //overflow flag testing
  opA = 32'h7FFFFFFF; 
  opB = 32'h00000001; 
  #10
  $display("%d", res);
  $display("%b", z);
  $display("%b", c);
  $display("%b", v);
  
  sel = 3'b000; //negative operands, overflow flag testing
  opA = 32'hF0000000;
  opB = 32'h80000000;
  #10
  $display("%d", res);
  $display("%b", z);
  $display("%b", c);
  $display("%b", v);
  
  sel = 3'b000; //zero flag testing
  opA = 32'd0; 
  opB = 32'd0;
  #10
  $display("%d", res);
  $display("%b", z);
  $display("%b", c); 
  $display("%b", v);
  
  #10
  $finish;
end

// Clock generator
always begin
  #5 elk = ~elk; // Toggle clock every 5 ticks
end

// Connect DUT to test bench
add U_add_tb (
elk,
opA, opB,
sel, res, z, c, v
);

endmodule