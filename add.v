module add(
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
		3'b000:
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
	
	endcase
end

endmodule