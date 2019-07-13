module map(coordinate,is_wall);
	output reg is_wall;
	input [7:0] coordinate;
	always @(*)
	begin
		case(coordinate)
			8'b00000110: is_wall = 1'b1;
			8'b00010001: is_wall = 1'b1;
			8'b00010010: is_wall = 1'b1;
			8'b00010100: is_wall = 1'b1;
			8'b00010110: is_wall = 1'b1;
			8'b00011000: is_wall = 1'b1;
			8'b00011010: is_wall = 1'b1;
			8'b00011011: is_wall = 1'b1;
			8'b00110001: is_wall = 1'b1;
			8'b00110010: is_wall = 1'b1;
			8'b00110100: is_wall = 1'b1;
			8'b00111000: is_wall = 1'b1;
			8'b00111010: is_wall = 1'b1;
			8'b00111011: is_wall = 1'b1;
			8'b01010001: is_wall = 1'b1;
			8'b01010011: is_wall = 1'b1;
			8'b01010100: is_wall = 1'b1;
			8'b01010110: is_wall = 1'b1;
			8'b01011000: is_wall = 1'b1;
			8'b01011001: is_wall = 1'b1;
			8'b01011011: is_wall = 1'b1;
			8'b01100110: is_wall = 1'b1;
			8'b01110001: is_wall = 1'b1;
			8'b01110011: is_wall = 1'b1;
			8'b01110100: is_wall = 1'b1;
			8'b01110110: is_wall = 1'b1;
			8'b01111000: is_wall = 1'b1;
			8'b01111001: is_wall = 1'b1;
			8'b01111011: is_wall = 1'b1;
			8'b10010001: is_wall = 1'b1;
			8'b10010010: is_wall = 1'b1;
			8'b10010100: is_wall = 1'b1;
			8'b10011000: is_wall = 1'b1;
			8'b10011010: is_wall = 1'b1;
			8'b10011011: is_wall = 1'b1;
			8'b10110001: is_wall = 1'b1;
			8'b10110010: is_wall = 1'b1;
			8'b10110100: is_wall = 1'b1;
			8'b10110110: is_wall = 1'b1;
			8'b10111000: is_wall = 1'b1;
			8'b10111010: is_wall = 1'b1;
			8'b10111011: is_wall = 1'b1;
			8'b11000110: is_wall = 1'b1;
			default: is_wall = 1'b0;
		endcase
	end
endmodule

		