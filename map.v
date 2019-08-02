module map(coordinate,is_wall,mapselect);
	output reg is_wall;
	input [1:0] mapselect;
	input [7:0] coordinate;
	reg is_wall0,is_wall1,is_wall2;
	always@(*)
	begin
		case(mapselect)
			2'd0: is_wall = is_wall0;
			2'd1: is_wall = is_wall1;
			2'd2: is_wall = is_wall2;
			default: is_wall = is_wall0;
		endcase
	end
	
	always @(*)
	begin
		case(coordinate)
			8'b00000110: is_wall0 = 1'b1;
			8'b00010001: is_wall0 = 1'b1;
			8'b00010010: is_wall0 = 1'b1;
			8'b00010100: is_wall0 = 1'b1;
			8'b00010110: is_wall0 = 1'b1;
			8'b00011000: is_wall0 = 1'b1;
			8'b00011010: is_wall0 = 1'b1;
			8'b00011011: is_wall0 = 1'b1;
			8'b00110001: is_wall0 = 1'b1;
			8'b00110010: is_wall0 = 1'b1;
			8'b00110100: is_wall0 = 1'b1;
			8'b00111000: is_wall0 = 1'b1;
			8'b00111010: is_wall0 = 1'b1;
			8'b00111011: is_wall0 = 1'b1;
			8'b01010001: is_wall0 = 1'b1;
			8'b01010011: is_wall0 = 1'b1;
			8'b01010100: is_wall0 = 1'b1;
			8'b01010110: is_wall0 = 1'b1;
			8'b01011000: is_wall0 = 1'b1;
			8'b01011001: is_wall0 = 1'b1;
			8'b01011011: is_wall0 = 1'b1;
			8'b01100110: is_wall0 = 1'b1;
			8'b01110001: is_wall0 = 1'b1;
			8'b01110011: is_wall0 = 1'b1;
			8'b01110100: is_wall0 = 1'b1;
			8'b01110110: is_wall0 = 1'b1;
			8'b01111000: is_wall0 = 1'b1;
			8'b01111001: is_wall0 = 1'b1;
			8'b01111011: is_wall0 = 1'b1;
			8'b10010001: is_wall0 = 1'b1;
			8'b10010010: is_wall0 = 1'b1;
			8'b10010100: is_wall0 = 1'b1;
			8'b10011000: is_wall0 = 1'b1;
			8'b10011010: is_wall0 = 1'b1;
			8'b10011011: is_wall0 = 1'b1;
			8'b10110001: is_wall0 = 1'b1;
			8'b10110010: is_wall0 = 1'b1;
			8'b10110100: is_wall0 = 1'b1;
			8'b10110110: is_wall0 = 1'b1;
			8'b10111000: is_wall0 = 1'b1;
			8'b10111010: is_wall0 = 1'b1;
			8'b10111011: is_wall0 = 1'b1;
			8'b11000110: is_wall0 = 1'b1;
			default: is_wall0 = 1'b0;
		endcase
	end

	always @(*)
	begin
case(coordinate)
			8'b00100110: is_wall1 = 1'b1;
			8'b00000110: is_wall1 = 1'b1;
			8'b01010000: is_wall1 = 1'b1;
			8'b01100000: is_wall1 = 1'b1;
			8'b01110000: is_wall1 = 1'b1;
			8'b00010001: is_wall1 = 1'b1;
			8'b00100001: is_wall1 = 1'b1;
			8'b00110001: is_wall1 = 1'b1;
			8'b01100001: is_wall1 = 1'b1;
			8'b10010001: is_wall1 = 1'b1;
			8'b10100001: is_wall1 = 1'b1;
			8'b10110001: is_wall1 = 1'b1;
			8'b00010010: is_wall1 = 1'b1;
			8'b01100010: is_wall1 = 1'b1;
			8'b00010011: is_wall1 = 1'b1;
			8'b01000011: is_wall1 = 1'b1;
			8'b10000011: is_wall1 = 1'b1;
			8'b10110011: is_wall1 = 1'b1;
			8'b00110100: is_wall1 = 1'b1;
			8'b01000100: is_wall1 = 1'b1;
			8'b01100100: is_wall1 = 1'b1;
			8'b10000100: is_wall1 = 1'b1;
			8'b10010100: is_wall1 = 1'b1;
			8'b00000101: is_wall1 = 1'b1;
			8'b01100101: is_wall1 = 1'b1;
			8'b11000101: is_wall1 = 1'b1;
			8'b00010110: is_wall1 = 1'b1;
			8'b01000110: is_wall1 = 1'b1;
			8'b01010110: is_wall1 = 1'b1;
			8'b01100110: is_wall1 = 1'b1;
			8'b01110110: is_wall1 = 1'b1;
			8'b10000110: is_wall1 = 1'b1;
			8'b10100110: is_wall1 = 1'b1;
			8'b10110110: is_wall1 = 1'b1;
			8'b11000110: is_wall1 = 1'b1;
			8'b00000111: is_wall1 = 1'b1;
			8'b01100111: is_wall1 = 1'b1;
			8'b11000111: is_wall1 = 1'b1;
			8'b00111000: is_wall1 = 1'b1;
			8'b01001000: is_wall1 = 1'b1;
			8'b01101000: is_wall1 = 1'b1;
			8'b10001000: is_wall1 = 1'b1;
			8'b10011000: is_wall1 = 1'b1;
			8'b00011001: is_wall1 = 1'b1;
			8'b01001001: is_wall1 = 1'b1;
			8'b10001001: is_wall1 = 1'b1;
			8'b10111001: is_wall1 = 1'b1;
			8'b00011010: is_wall1 = 1'b1;
			8'b01101010: is_wall1 = 1'b1;
			8'b10111010: is_wall1 = 1'b1;
			8'b00011011: is_wall1 = 1'b1;
			8'b00101011: is_wall1 = 1'b1;
			8'b00111011: is_wall1 = 1'b1;
			8'b01101011: is_wall1 = 1'b1;
			8'b10011011: is_wall1 = 1'b1;
			8'b10101011: is_wall1 = 1'b1;
			8'b10111011: is_wall1 = 1'b1;
			8'b01011100: is_wall1 = 1'b1;
			8'b01101100: is_wall1 = 1'b1;
			8'b01111100: is_wall1 = 1'b1;
			8'b10110010: is_wall1 = 1'b1;
			default: is_wall1 = 1'b0;
		endcase
end
	always @(*)
	begin
case(coordinate)
			8'b01000000: is_wall2 = 1'b1;
			8'b10000000: is_wall2 = 1'b1;
			8'b00010001: is_wall2 = 1'b1;
			8'b01000001: is_wall2 = 1'b1;
			8'b01010001: is_wall2 = 1'b1;
			8'b01110001: is_wall2 = 1'b1;
			8'b10000001: is_wall2 = 1'b1;
			8'b10110001: is_wall2 = 1'b1;
			8'b00100010: is_wall2 = 1'b1;
			8'b01010010: is_wall2 = 1'b1;
			8'b01100010: is_wall2 = 1'b1;
			8'b01110010: is_wall2 = 1'b1;
			8'b10100010: is_wall2 = 1'b1;
			8'b00110011: is_wall2 = 1'b1;
			8'b01100011: is_wall2 = 1'b1;
			8'b10010011: is_wall2 = 1'b1;
			8'b00000100: is_wall2 = 1'b1;
			8'b00010100: is_wall2 = 1'b1;
			8'b01000100: is_wall2 = 1'b1;
			8'b10000100: is_wall2 = 1'b1;
			8'b10110100: is_wall2 = 1'b1;
			8'b11000100: is_wall2 = 1'b1;
			8'b00010101: is_wall2 = 1'b1;
			8'b00100101: is_wall2 = 1'b1;
			8'b01010101: is_wall2 = 1'b1;
			8'b01110101: is_wall2 = 1'b1;
			8'b10100101: is_wall2 = 1'b1;
			8'b10110101: is_wall2 = 1'b1;
			8'b00100110: is_wall2 = 1'b1;
			8'b00110110: is_wall2 = 1'b1;
			8'b01100110: is_wall2 = 1'b1;
			8'b10010110: is_wall2 = 1'b1;
			8'b10100110: is_wall2 = 1'b1;
			8'b00010111: is_wall2 = 1'b1;
			8'b00100111: is_wall2 = 1'b1;
			8'b01010111: is_wall2 = 1'b1;
			8'b01110111: is_wall2 = 1'b1;
			8'b10100111: is_wall2 = 1'b1;
			8'b10110111: is_wall2 = 1'b1;
			8'b00001000: is_wall2 = 1'b1;
			8'b00011000: is_wall2 = 1'b1;
			8'b01001000: is_wall2 = 1'b1;
			8'b10001000: is_wall2 = 1'b1;
			8'b10111000: is_wall2 = 1'b1;
			8'b11001000: is_wall2 = 1'b1;
			8'b00111001: is_wall2 = 1'b1;
			8'b01101001: is_wall2 = 1'b1;
			8'b10011001: is_wall2 = 1'b1;
			8'b00101010: is_wall2 = 1'b1;
			8'b01011010: is_wall2 = 1'b1;
			8'b01101010: is_wall2 = 1'b1;
			8'b01111010: is_wall2 = 1'b1;
			8'b10101010: is_wall2 = 1'b1;
			8'b00011011: is_wall2 = 1'b1;
			8'b01001011: is_wall2 = 1'b1;
			8'b01011011: is_wall2 = 1'b1;
			8'b01111011: is_wall2 = 1'b1;
			8'b10001011: is_wall2 = 1'b1;
			8'b10111011: is_wall2 = 1'b1;
			8'b01001100: is_wall2 = 1'b1;
			8'b10001100: is_wall2 = 1'b1;
			default: is_wall2 = 1'b0;
		endcase	
	end
endmodule	