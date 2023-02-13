module CPU(
    input logic clk,
    input logic [31:0] instruction,
    input logic [31:0] readData,
    output logic memWrite,
    output logic [31:0] aluResult,
    output logic [4:0] pc,
	 output logic [31:0] rd2
);
    logic [3:0] ALUop;
    logic [4:0] rs1;
    logic [4:0] rs2;
    logic [31:0] rd1;
    logic [4:0] rd;
    logic we_reg;
    logic flag;
	 logic branch;
    logic isImm;
    logic memToReg;
    logic [31:0] immediate;
    logic [31:0] temp;
    logic [31:0] alu_y;
    decoder decoder(
        .instruction(instruction),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .signImm(immediate)
    );
    controlUnit controlUnit(
        .instruction(instruction),
        .we_reg(we_reg),
        .branch(branch),
        .memWrite(memWrite),
        .memToReg(memToReg),
        .isImm(isImm),
        .ALUop(ALUop)
    );
    assign alu_y = isImm ? immediate : rd2;
    ALU ALU(
		.ALUop(ALUop),
        .x(rd1),
        .y(alu_y),
        .result(aluResult),
        .flag(flag)
    );
    assign temp = memToReg ? readData : aluResult;
    
    regFile regFile(
        .clk(clk),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .rd1(rd1),
        .rd2(rd2),
        .d(temp),
        .we_reg(we_reg)
    );
    always_ff @(posedge clk ) begin 
        if (pc != 5'b11111 && (branch == 1'b0 || flag == 1'b0))begin
            pc <= pc + 5'h1;
        end
        else if(pc != 5'b11111 && branch == 1'b1 && flag == 1'b1) begin
            pc <= pc + immediate[4:0];
        end
        else begin
            pc <= pc;
        end
    end
endmodule