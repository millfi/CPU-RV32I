module regFile(
    input logic clk,
    input logic [4:0] rd, rs1, rs2,
    input logic [31:0] d,
    input logic we_reg,
    output logic [31:0] rd1,
    output logic [31:0] rd2
);
    logic [31:0] register[0:31];
    assign rd1 = (rs1 == 0) ? 0 : register[rs1];
    assign rd2 = (rs2 == 0) ? 0 : register[rs2];
    always_ff @(posedge clk) begin
        if (we_reg) begin
            register[rd] <= d;
        end
    end
endmodule