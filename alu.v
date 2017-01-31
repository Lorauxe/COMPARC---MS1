module alu(
opA, opB,
sel, res, z, c, v
);


input wire [2:0] sel;
input wire signed [31:0] opA;
input wire signed [31:0] opB;

output reg signed [31:0] res;
output reg z, c, v;
	
always @(opA,opB,sel)			
	begin: OPERATIONS	
	if(sel == 3'b000) begin: ADD

		 	res = opA + opB;
			if (res == 32'h00000000)
				z = 1'b1;
			else
				z = 1'b0;
			
			//the only time 2's complement has carryout is if one of its operands is negative
			if (((opA[31]!=opB[31])&&res[31]==0)||((opA[31]==1&&opB[31]==1)&&res[31]==1)||((opA[31]==1&&opB[31]==1)&&res[31]==0))
				begin
				c = 1'b1;
			end

			else begin
				c = 1'b0;
			end
			
			if ((opA[31]==opB[31])&&(opA[31]!=res[31])&&(opB[31]!=res[31])) //sign of operands and result do not match
				v = 1'b1;
			else
				v = 1'b0;

	end 

	else if(sel == 3'b001) begin: SUBTRACT	//subtraction
			reg [32:0] temp_res; //local var
			reg [31:0] temp_opB; //local var
			reg [32:0] tempB;

			
			temp_opB = opB;
			$display("%X",opB);
			temp_opB = ~(temp_opB); //bitwise negate
			temp_opB = temp_opB + 1'b1; //2's complement
			temp_res = opA + temp_opB;
			$display("%X",temp_opB);
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

			res = temp_res[31:0];

			
			if(opB[31] == 1) begin
				tempB = 0 - opB;
			end
			else begin
				tempB = opB;
			end

			//if (temp_res[31] == temp_opB[31]) //overflow (if sign of opB is same as sign of temp_res there is overflow)
			//if((opA[31]==opB[31])&&(opA[31]!=temp_res[31])&&(opB[31]!=temp_res[31]))
			if( ((temp_opB[31] == 1)&&(opA[31] == 1)&&(res[31] == 0)) || ((temp_opB[31] == 0)&&(opA[31]==0)&&(res == 1)) ||
				((opA[31]==1)&&(tempB > opA)&&(res[31] != opB[31])))

	
				begin					
				v = 1'b1;
				end
			else
				begin
				v = 1'b0;
				end

			$display("carry: %d", c);
			$display("zerof: %d", z);
			$display("overf: %d", v);
						

	end

	else if(sel == 3'b010) begin	//AND
			res = opA & opB;
			if (res != 32'd0)
				begin
				z = 1'b0;
				$display("IWASNOTZERO");
			end			
			else 
				begin
				z = 1'b1;
				$display("IWASZERO");
			end
			c = 1'b0;
			v = 1'b0;
			$display("opA: %d | opB: %d", opA, opB);
			$display("AND RES: %b:",res);
			$display("carryf: %d",c);
			$display("zerof: %d",z);
			$display("overf: %d",v);
	end

	else if(sel == 3'b011) begin	//OR
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
			$display("IWASHERE");
	end

	else if(sel == 3'b100)	begin		//NOT
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

end

endmodule