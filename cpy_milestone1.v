module cpy_milestone1(
elk,
opA, opB,
sel, res, z, c, v
);


// Variable Declarations

input wire elk;
input wire [2:0] sel;
input wire [31:0] opA, opB;
output reg [31:0] res;
output reg z, c, v;

always @ (posedge elk)
begin: cpy_milestone1
		
	case (sel)
	
	3'b010: 
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
	
	3'b011:
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
		
	3'b100:
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

	endcase
	
end

endmodule
