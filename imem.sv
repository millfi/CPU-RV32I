module imem(input logic[4:0] pc,
            output logic [31:0] instruction
);
    logic [31:0] ROM[0:31];
    initial begin
        $readmemb("sumofprime.dat", ROM);
    end
    assign instruction = ROM[pc];
endmodule