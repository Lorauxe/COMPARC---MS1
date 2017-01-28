module register(
	elk,
	nrst,
	wr_en,
	rd_addrA,
	rd_addrB,
	wr_addr,
	wr_data,
	rd_dataA,
	rd_dataB

);

//--- Input Ports ---//

input wire elk, nrst, wr_en;
input wire [4:0] rd_addrA;
input wire [4:0] rd_addrB;
input wire [4:0] wr_addr;
input wire [31:0] wr_data;

//--- Output Ports ---//

output reg [31:0] rd_dataA;
output reg [31:0] rd_dataB;

reg [31:0] mem [31:0];
integer i;	
always @nrst
begin: RESET
	if(nrst == 0) begin
		for(i = 0; i < 32; i = i + 1) begin
			mem[i] = 0;
//			$display("i: %d", i);
		end
	end
end


always @ (posedge elk)
begin: WRITE_DATA
	if(wr_en == 1) begin
		if(~(wr_addr == 5'b00000)) begin 
			mem [wr_addr] = #1 wr_data;
//			$display ("I am writing: %d", mem[wr_addr]);
		end
	end
end

always @rd_addrA
begin: MEM_READ_A
	if(wr_en == 0 & nrst == 1) begin

		rd_dataA = #1 mem[rd_addrA];

//		$display ("I am reading A: %d", rd_dataA);
	end
end


always @rd_addrB
begin: MEM_READ_B
	if(wr_en == 0 & nrst == 1) begin

		rd_dataB = #1 mem[rd_addrB];
//		$display ("nrst: %d", nrst);
//		$display ("I am reading B: %d", rd_dataB);
	end
end



endmodule