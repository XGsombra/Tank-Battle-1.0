module get_direction(up,down,left,right,direction);
	input up,down,left,right;
	output reg [2:0] direction;
	wire [3:0] input_direction;
	assign input_direction = {up,down,left,right};
	always @(*)
		begin
			case(input_direction)
				4'b1000: direction = 3'b100;
				4'b0100: direction = 3'b101;
				4'b0010: direction = 3'b110;
				4'b0001: direction = 3'b111;
				default: direction = 3'b000;
			endcase
		end
endmodule
