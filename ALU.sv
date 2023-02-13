module ALU(
    input  logic [3:0]           ALUop, 
    input  logic signed [31:0]   x,
    input  logic signed [31:0]   y,
    output  logic signed [31:0]  result,
    output                 flag
);
    always_comb begin
        case (ALUop)
            4'b0000: begin result = x & y; flag = 1'b0; end
            4'b0001: begin result = x | y; flag = 1'b0; end
            4'b0010: begin result = x ^ y; flag = 1'b0; end
            4'b0011: begin result = x + y; flag = 1'b0; end
            4'b0100: begin result = x - y; flag = 1'b0; end
            4'b0101: begin result = x * y; flag = 1'b0; end
            4'b0110: begin result = x >> y; flag = 1'b0;end//srl
            4'b0111: begin result = x << y; flag = 1'b0;end//sll
            4'b1000: begin flag = ((x == y)?1'b1:1'b0);result = ((x == y)?32'b1 : 32'b0);end//beq
            4'b1001: begin flag = ((x != y)?1'b1 : 1'b0);result = ((x == y)?32'h0000_0001 : 32'h0000_0000);end//bnq
            4'b1010: begin flag = ((x < y)?1'b1:1'b0);result = ((x < y)?32'b1 : 32'b0);end //blt,slt,slti
            4'b1011: begin flag = ((x >= y)?1'b1 : 1'b0);result = ((x < y)?32'h0000_0001 : 32'h0000_0000);end//bge
            default: begin result = 32'h0000_0000;flag = 1'b0;end
        endcase
    end
endmodule