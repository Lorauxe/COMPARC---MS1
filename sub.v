module subtraction(
elk,
opA, opB,
sel, res, z, c, v
);

input wire elk;
input wire [2:0] sel;
input wire [31:0] opA, opB;
output reg [31:0] res;
output reg z, c, v;

always @(posedge elk)
	begin: subtraction
	
		case (sel)
		
			3'b001:
				begin: subtraction
					reg [32:0] temp_res; //local var
					reg [31:0] temp_opB; //local var
					temp_opB = opB;
					
					temp_opB = ~(temp_opB); //bitwise negate
					temp_opB = temp_opB + 1'b1; //2's complement
					temp_res = opA + temp_opB;
					
					//check for flags
					if (temp_res != 32'd0) //zero
						begin
						z = 1'b0;
						end
					else 
						begin
						z = 1'b1;
						end
					if (temp_res[32] == 1'b1) //carry out
						begin
						c = 1'b1;
						end
					else
						begin
						c = 1'b0;
						end
					if (temp_res[31] == temp_opB[31]) //overflow (if sign of opB is same as sign of temp_res there is overflow)
						begin					 // Reference: Overflow rule of subtraction found in http://www.doc.ic.ac.uk/~eedwards/compsys/arithmetic/
						v = 1'b1;
						end
					else
						begin
						 v = 1'b0;
						 end
				res = temp_res[31:0];
				end
		endcase
	end
endmodule