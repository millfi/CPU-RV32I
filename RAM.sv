module RAM(
        input logic        clk,
        input logic [31:0] Ad,
        input logic [31:0] Wd,
        input logic        we_ram,
        output logic [31:0] Rd
    );
    logic [31:0] mem[0:511];

    always_ff @(posedge clk) begin
        if(we_ram) begin
            mem[Ad] = Wd;
        end
    end
    assign Rd = mem[Ad];
endmodule