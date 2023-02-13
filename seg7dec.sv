module seg7dec (
    input logic [3:0] sw,
    output logic [6:0] decoded
);
    always_comb begin 
        case(sw)
            4'h0:   decoded = 7'b1000000;
            4'h1:   decoded = 7'b1111001;
            4'h2:   decoded = 7'b0100100;
            4'h3:   decoded = 7'b0110000;
            4'h4:   decoded = 7'b0011001;
            4'h5:   decoded = 7'b0010010;
            4'h6:   decoded = 7'b0000010;
            4'h7:   decoded = 7'b1011000;
            4'h8:   decoded = 7'b0000000;
            4'h9:   decoded = 7'b0010000;
            4'ha:   decoded = 7'b0001000;
            4'hb:   decoded = 7'b0000011;
            4'hc:   decoded = 7'b1000110;
            4'hd:   decoded = 7'b0100001;
            4'he:   decoded = 7'b0000110;
            4'hf:   decoded = 7'b0001110;
            default:decoded = 7'b1111111;
			endcase
    end
endmodule