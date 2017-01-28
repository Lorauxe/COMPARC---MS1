`include "register.v"

module register_tb();

reg elk,
	nrst,
	wr_en;

reg	[4:0] rd_addrA;
reg	[4:0] rd_addrB;
reg	[4:0] wr_addr;
reg	[31:0] wr_data;

wire [31:0] rd_dataA;
wire [31:0] rd_dataB;

initial begin

  $dumpfile("register.vcd"); 
  $dumpvars(0,elk,nrst,wr_en,rd_addrA,rd_addrB,wr_addr,wr_data, rd_dataA, rd_dataB);


  elk = 0;

  wr_en = 0;
  nrst = 0;


  #2


  nrst = 1;

  #2

  rd_addrA = 5'b10111;
  rd_addrB = 5'b11001;

  #2


  wr_addr = 5'b10000;
  wr_data = 32'd24;



  wr_en = 1;



  #2

  rd_addrA = 5'b10000;

  #2

  wr_en = 0;

  #2

  rd_addrA = 5'b10000;
  rd_addrB = 5'b10000;

  wr_addr = 5'b10111;
  wr_data = 32'd1000;

  #2 


  wr_en = 1;

  #2

  rd_addrB = 5'b10111;

  #2

  wr_en = 0;

  #2

  rd_addrA = 5'b10111;
  rd_addrB = 5'b10000;

  #2 


  nrst = 0;

  #2

  nrst = 1;

  #20
  $finish;

end

always begin
#1 elk = ~elk;
end

// Connect DUT to test bench
register U_register(
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

endmodule