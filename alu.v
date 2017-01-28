module alu(
elk,
opA, opB,
sel, res, z, c, v
);


input wire elk;
input wire [2:0] sel;
input wire signed [31:0] opA, opB;
output reg signed [31:0] res;
output reg z, c, v;

always @ (posedge elk)
begin
	case (sel)
		3'b000: //addition
			begin
				
				res = opA + opB;
				if (res == 32'h00000000)
					z = 1'b1;
				else
					z = 1'b0;
				
				//the only time 2's complement has carryout is if one of its operands is negative
				if (((opA[31]!=opB[31])&&res[31]==0)||((opA[31]==1&&opB[31]==1)&&res[31]==1))
					c = 1'b1;
				else
					c = 1'b0;
					
				
				if ((opA[31]==opB[31])&&(opA[31]!=res[31])&&(opB[31]!=res[31])) //sign of operands and result do not match
					v = 1'b1;
				else
					v = 1'b0;
					
			end
			
		3'b010: //and
			begin
				res = opA & opB;
				if (res != 32'd0)
					begin
					z = 1'b0;
					end			
				else
					begin
					z = 1'b1;
					end
				c = 1'b0;
				v = 1'b0;
			end 
	
		3'b011: //or
			begin
				res = opA | opB;
				if (res != 32'd0)
					begin
					z = 1'b0;
					end			
				else
					begin
					z = 1'b1;
					end
				c = 1'b0;
				v = 1'b0;
			end
		
		3'b100: //not
			begin
				res = ~opA;
				if (res != 32'd0)
					begin
					z = 1'b0;
					end			
				else
					begin
					z = 1'b1;
					end
				c = 1'b0;
				v = 1'b0;
			end
			
		3'b001: //subtraction
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