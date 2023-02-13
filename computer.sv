q	input logic CLK,
	output reg [6:0] HEX0, HEX1, HEX2, HEX3, HEX4
);
	logic [31:0] instruction;
	logic [31:0] readData;
	logic memWrite;
	logic [31:0] aluResult;
	logic [31:0] rd2;
	logic [4:0] pc;
	logic [6:0] led0;
	logic [6:0] led1;
	logic [6:0] led2;
	logic [6:0] led3;
	logic [6:0] led4;
	CPU CPU(
		.clk(CLK),
		.instruction(instruction),
		.readData(readData),
		.memWrite(memWrite),
		.aluResult(aluResult),
		.pc(pc),
		.rd2(rd2)
	);
	RAM RAM(
		.clk(CLK),
		.Ad(aluResult),
		.Wd(rd2),
		.we_ram(memWrite),
		.Rd(readData)
	);
	imem imem(
		.pc(pc),
		.instruction(instruction)
	);
	seg7dec seg7dec0(
		.sw(rd2[3:0]),
		.decoded(led0)
	);
	seg7dec seg7dec1(
		.sw(rd2[7:4]),
		.decoded(led1)
	);
	seg7dec seg7dec2(
		.sw(rd2[11:8]),
		.decoded(led2)
	);
	seg7dec seg7dec3(
		.sw(rd2[15:12]),
		.decoded(led3)
	);
	seg7dec seg7dec4(
		.sw(rd2[19:16]),
		.decoded(led4)
	);
	always_ff @(posedge CLK) begin
		if(memWrite && (aluResult == 32'h1ff))begin
			HEX0 <= led0;
			HEX1 <= led1;
			HEX2 <= led2;
			HEX3 <= led3;
			HEX4 <= led4;
		end else begin
			HEX0 <= HEX0;
			HEX1 <= HEX1;
			HEX2 <= HEX2;
			HEX3 <= HEX3;
			HEX4 <= HEX4;
		end
	end
endmodule