module get_direction(up,down,left,right,direction);
	input up,down,left,right;
	output reg [2:0] direction;
	always @(*)
		begin
			if(up)
				direction = 3'b100;
			else if(down)
				direction = 3'b101;
			else if(left)
				direction = 3'b110;
			else if(right)
				direction = 3'b111;
			else
				direction = 3'b000;
		end
endmodule
