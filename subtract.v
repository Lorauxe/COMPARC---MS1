module subtraction(
	input [31:0] opA, 
	input [31:0] opB,
	input [2:0] sel,
	output [31:0] res,
	output z, //zero 
	output c, //carry out
	output v //overflow
	);

	always @(*)	
	begin
		case (sel)
			3'b001: 
			begin
				opB <= ~(opB);  //bitwise negate
				opB <= opB + 'b1; //add 1 to make it 2's complement
				res <= opA + opB; //add negative 2's complement to opA
				if (res != 0) //zero flag
					z <= 'b0;
				else
					z <= 'b1;
								//insert determiner for overflow then carry out here
			end
		endcase
	end
endmodule