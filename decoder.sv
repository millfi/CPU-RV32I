module decoder (
    input logic [31:0] instruction,
    output logic [4:0] rs1,rs2,rd,
    output logic [31:0] signImm
);
    logic [6:0] op;
    logic [6:0] imm1;
    logic [4:0] imm2;
    logic [11:0] immediate;
    assign op = instruction[6:0];
    always_comb begin
        case (op)
            7'b1100011: begin imm1 = instruction[31:25];imm2 = instruction[11:7];rs1 = instruction[19:15];rs2 = instruction[24:20];rd = 5'b0;end//BRANCH
            7'b0000011: begin imm1 = instruction[31:25];imm2 = instruction[24:20];rs1 = instruction[19:15];rs2 = 5'b0;rd = instruction[11:7];end//LOAD
            7'b0010011: begin   if(instruction[14:12] != 3'b001 && instruction[14:12] != 3'b101)begin 
                                    imm1 = instruction[31:25];
                                    imm2 = instruction[24:20];
                                    rs1 = instruction[19:15];
												rs2 = 5'b0;
                                    rd = instruction[11:7];
                                end else begin 
                                    imm1 = 7'b0;
                                    imm2 = instruction[24:20];
                                    rs1 = instruction[19:15];
												rs2 = 5'b0;
                                    rd = instruction[11:7]; 
                                end//即値演算命令
                        end
            7'b0110011: begin imm1 = 7'b0; imm2 = 5'b0; rs1 = instruction[19:15];rs2 = instruction[24:20];rd = instruction[11:7]; end//演算命令
            7'b0100011: begin imm1 = instruction[31:25];imm2 = instruction[11:7];rs2 = instruction[24:20];rs1 = instruction[19:15];rd = 5'b0;end//STORE
            default:    begin rs1 = 5'b0;rs2 = 5'b0;rd = 5'b0; imm1 = 7'b0; imm2 = 5'b0;end
        endcase
        immediate = {imm1, imm2};
        signImm = {{20{immediate[11]}},immediate};
    end
    
endmodule
