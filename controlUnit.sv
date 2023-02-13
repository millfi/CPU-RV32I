module controlUnit(
    input logic [31:0] instruction,
    output logic memToReg, memWrite, branch, isImm, we_reg,
    output logic [3:0] ALUop
);
	always_comb begin
        case (instruction[6:0])  
            7'b1100011: begin 
                        if(instruction[14:12] == 3'b000)begin ALUop = 4'b1000;memToReg = 1'b0;memWrite = 1'b0;branch = 1'b1;isImm = 1'b0;we_reg = 1'b0;end //beq
                        else if(instruction[14:12] == 3'b001)begin ALUop = 4'b1001;memToReg = 1'b0;memWrite = 1'b0;branch = 1'b1;isImm = 1'b0;we_reg = 1'b0;end //bne
                        else if(instruction[14:12] == 3'b100)begin ALUop = 4'b1010;memToReg = 1'b0;memWrite = 1'b0;branch = 1'b1;isImm = 1'b0;we_reg = 1'b0;end //blt
                        else if(instruction[14:12] == 3'b101)begin ALUop = 4'b1011;memToReg = 1'b0;memWrite = 1'b0;branch = 1'b1;isImm = 1'b0;we_reg = 1'b0;end //bge
                        else begin ALUop = 4'b1111;memToReg = 1'b0;memWrite = 1'b0;branch = 1'b1;isImm = 1'b0;we_reg = 1'b0;end
                        end//BRANCH系命令
            7'b0000011: begin ALUop = 4'b0011;isImm = 1'b1;memWrite = 1'b0;branch = 1'b0;memToReg = 1'b1;we_reg = 1'b1;end//LOAD系命令
            7'b0100011: begin ALUop = 4'b0011;isImm = 1'b1;memWrite = 1'b1;branch = 1'b0;memToReg = 1'b0;we_reg = 1'b0;end//STORE系命令
            7'b0010011: begin 
                            
                            if(instruction[14:12] == 3'b000) begin ALUop = 4'b0011;isImm = 1'b1;memWrite = 1'b0;branch = 1'b0;memToReg = 1'b0;we_reg = 1'b1;end//addi 
                            else if(instruction[14:12] == 3'b001)begin ALUop = 4'b0111;isImm = 1'b1;memWrite = 1'b0;branch = 1'b0;memToReg = 1'b0;we_reg = 1'b1;end//slli
                            else if(instruction[14:12] == 3'b010)begin ALUop = 4'b1010;isImm = 1'b1;memWrite = 1'b0;branch = 1'b0;memToReg = 1'b0;we_reg = 1'b1;end//slti 
                            else if(instruction[14:12] == 3'b101)begin ALUop = 4'b0110;isImm = 1'b1;memWrite = 1'b0;branch = 1'b0;memToReg = 1'b0;we_reg = 1'b1;end//srli
                            else if(instruction[14:12] == 3'b100)begin ALUop = 4'b0010;isImm = 1'b1;memWrite = 1'b0;branch = 1'b0;memToReg = 1'b0;we_reg = 1'b1;end//xori 
                            else if(instruction[14:12] == 3'b110)begin ALUop = 4'b0001;isImm = 1'b1;memWrite = 1'b0;branch = 1'b0;memToReg = 1'b0;we_reg = 1'b1;end//ori 
                            else if(instruction[14:12] == 3'b111)begin ALUop = 4'b0000;isImm = 1'b1;memWrite = 1'b0;branch = 1'b0;memToReg = 1'b0;we_reg = 1'b1;end//andi 
                            else begin ALUop = 4'b1111;memToReg = 1'b0;memWrite = 1'b0;branch = 1'b0;isImm = 1'b0;we_reg = 1'b0;end
                        end
            //即値演算命令
            7'b0110011: begin 
                            if(instruction[14:12] == 3'b000 && instruction[31:25] == 7'b0000_000)begin ALUop = 4'b0011;isImm = 1'b0;memWrite = 1'b0;branch = 1'b0;memToReg = 1'b0;we_reg = 1'b1; end//add
                            else if(instruction[14:12] == 3'b000 && instruction[31:25] == 7'b0100_000)begin  ALUop = 4'b0100; isImm = 1'b0;memWrite = 1'b0;branch = 1'b0;memToReg = 1'b0;we_reg = 1'b1;end//sub
                            else if(instruction[14:12] == 3'b001 && instruction[31:25] == 7'b0000_000)begin  ALUop = 4'b0111; isImm = 1'b0;memWrite = 1'b0;branch = 1'b0;memToReg = 1'b0;we_reg = 1'b1;end//sll
                            else if(instruction[14:12] == 3'b010 && instruction[31:25] == 7'b0000_000)begin  ALUop = 4'b1010; isImm = 1'b0;memWrite = 1'b0;branch = 1'b0;memToReg = 1'b0;we_reg = 1'b1;end//slt
                            else if(instruction[14:12] == 3'b100 && instruction[31:25] == 7'b0000_000)begin  ALUop = 4'b0010; isImm = 1'b0;memWrite = 1'b0;branch = 1'b0;memToReg = 1'b0;we_reg = 1'b1;end//xor
                            else if(instruction[14:12] == 3'b101 && instruction[31:25] == 7'b0000_000)begin  ALUop = 4'b0001; isImm = 1'b0;memWrite = 1'b0;branch = 1'b0;memToReg = 1'b0;we_reg = 1'b1;end//srl
                            else if(instruction[14:12] == 3'b110 && instruction[31:25] == 7'b0000_000)begin  ALUop = 4'b0001; isImm = 1'b0;memWrite = 1'b0;branch = 1'b0;memToReg = 1'b0;we_reg = 1'b1;end//or
                            else if(instruction[14:12] == 3'b111 && instruction[31:25] == 7'b0000_000)begin  ALUop = 4'b0010; isImm = 1'b0;memWrite = 1'b0;branch = 1'b0;memToReg = 1'b0;we_reg = 1'b1;end//xor
                            else begin  ALUop = 4'b1111;isImm = 1'b0;memWrite = 1'b0;branch = 1'b0;memToReg = 1'b0;we_reg = 1'b0;end
                        end//演算命令
            default: begin memToReg = 0; memWrite = 0; branch = 0; isImm = 0; we_reg = 0;ALUop = 4'b1111;end
        endcase
    end
endmodule