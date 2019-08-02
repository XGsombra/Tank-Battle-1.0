module draw_score(clk,score_enable,t1,t2,t3,t4,tank_num,erase,x,y,plot,finish);
	input clk,score_enable;
	input [2:0] t1,t2,t3,t4;
	input [1:0] tank_num;
	input erase;
	output [7:0] x;
	output [6:0] y;
	output plot;
	output finish;
	reg [6:0] counter;
	reg [6:0] ypos;
	reg [2:0] score;
	reg [3:0] textSelect;
	reg tmp_plot;
	
	assign x = 3'd6 + counter[2:0];
	assign y = ypos + counter[6:3];
	assign plot = erase ? 1'b1 : tmp_plot;
	assign finish = &counter;
	
	always @(*)
	begin
		case(score)
			3'd0: tmp_plot = textSelect[0];
			3'd1: tmp_plot = textSelect[1];
			3'd2: tmp_plot = textSelect[2];
			3'd3: tmp_plot = textSelect[3];
			default: tmp_plot = 1'b0;
		endcase
	end
	
	always @(*)
	begin
		case(tank_num)
			2'd0: begin
				ypos = 7'd12;
				score = t1;
				end
			2'd1: begin
				ypos = 7'd40;
				score = t2;
				end
			2'd2: begin
				ypos = 7'd68;
				score = t3;
				end
			2'd3: begin
				ypos = 7'd96;
				score = t4;
				end
		endcase
	end
	
	always @(posedge clk)
	begin
		if(!score_enable)
			counter <= 7'd0;
		else if(counter==7'b1111111)
			counter <= 7'd0;
		else
			counter <= counter + 1'b1;
	end

always @(*)
begin
	case(counter)
		7'b0010001: textSelect[0] = 1'b1;
		7'b0010010: textSelect[0] = 1'b1;
		7'b0010011: textSelect[0] = 1'b1;
		7'b0010100: textSelect[0] = 1'b1;
		7'b0010101: textSelect[0] = 1'b1;
		7'b0011000: textSelect[0] = 1'b1;
		7'b0011001: textSelect[0] = 1'b1;
		7'b0011101: textSelect[0] = 1'b1;
		7'b0011110: textSelect[0] = 1'b1;
		7'b0100000: textSelect[0] = 1'b1;
		7'b0100001: textSelect[0] = 1'b1;
		7'b0100101: textSelect[0] = 1'b1;
		7'b0100110: textSelect[0] = 1'b1;
		7'b0101000: textSelect[0] = 1'b1;
		7'b0101001: textSelect[0] = 1'b1;
		7'b0101100: textSelect[0] = 1'b1;
		7'b0101101: textSelect[0] = 1'b1;
		7'b0101110: textSelect[0] = 1'b1;
		7'b0110000: textSelect[0] = 1'b1;
		7'b0110001: textSelect[0] = 1'b1;
		7'b0110011: textSelect[0] = 1'b1;
		7'b0110100: textSelect[0] = 1'b1;
		7'b0110101: textSelect[0] = 1'b1;
		7'b0110110: textSelect[0] = 1'b1;
		7'b0111000: textSelect[0] = 1'b1;
		7'b0111001: textSelect[0] = 1'b1;
		7'b0111010: textSelect[0] = 1'b1;
		7'b0111011: textSelect[0] = 1'b1;
		7'b0111101: textSelect[0] = 1'b1;
		7'b0111110: textSelect[0] = 1'b1;
		7'b1000000: textSelect[0] = 1'b1;
		7'b1000001: textSelect[0] = 1'b1;
		7'b1000010: textSelect[0] = 1'b1;
		7'b1000101: textSelect[0] = 1'b1;
		7'b1000110: textSelect[0] = 1'b1;
		7'b1001000: textSelect[0] = 1'b1;
		7'b1001001: textSelect[0] = 1'b1;
		7'b1001101: textSelect[0] = 1'b1;
		7'b1001110: textSelect[0] = 1'b1;
		7'b1010000: textSelect[0] = 1'b1;
		7'b1010001: textSelect[0] = 1'b1;
		7'b1010101: textSelect[0] = 1'b1;
		7'b1010110: textSelect[0] = 1'b1;
		7'b1011001: textSelect[0] = 1'b1;
		7'b1011010: textSelect[0] = 1'b1;
		7'b1011011: textSelect[0] = 1'b1;
		7'b1011100: textSelect[0] = 1'b1;
		7'b1011101: textSelect[0] = 1'b1;
	default: textSelect[0] = 1'b0;
	endcase
end

always @(*)
begin
	case(counter)
		7'b0010011: textSelect[1] = 1'b1;
		7'b0010100: textSelect[1] = 1'b1;
		7'b0011010: textSelect[1] = 1'b1;
		7'b0011011: textSelect[1] = 1'b1;
		7'b0011100: textSelect[1] = 1'b1;
		7'b0100001: textSelect[1] = 1'b1;
		7'b0100010: textSelect[1] = 1'b1;
		7'b0100011: textSelect[1] = 1'b1;
		7'b0100100: textSelect[1] = 1'b1;
		7'b0101011: textSelect[1] = 1'b1;
		7'b0101100: textSelect[1] = 1'b1;
		7'b0110011: textSelect[1] = 1'b1;
		7'b0110100: textSelect[1] = 1'b1;
		7'b0111011: textSelect[1] = 1'b1;
		7'b0111100: textSelect[1] = 1'b1;
		7'b1000011: textSelect[1] = 1'b1;
		7'b1000100: textSelect[1] = 1'b1;
		7'b1001011: textSelect[1] = 1'b1;
		7'b1001100: textSelect[1] = 1'b1;
		7'b1010011: textSelect[1] = 1'b1;
		7'b1010100: textSelect[1] = 1'b1;
		7'b1011001: textSelect[1] = 1'b1;
		7'b1011010: textSelect[1] = 1'b1;
		7'b1011011: textSelect[1] = 1'b1;
		7'b1011100: textSelect[1] = 1'b1;
		7'b1011101: textSelect[1] = 1'b1;
		7'b1011110: textSelect[1] = 1'b1;
		default: textSelect[1] = 1'b0;
	endcase
end

always @(*)
begin
	case(counter)
		7'b0010001: textSelect[2] = 1'b1;
		7'b0010010: textSelect[2] = 1'b1;
		7'b0010011: textSelect[2] = 1'b1;
		7'b0010100: textSelect[2] = 1'b1;
		7'b0010101: textSelect[2] = 1'b1;
		7'b0011000: textSelect[2] = 1'b1;
		7'b0011001: textSelect[2] = 1'b1;
		7'b0011101: textSelect[2] = 1'b1;
		7'b0011110: textSelect[2] = 1'b1;
		7'b0100101: textSelect[2] = 1'b1;
		7'b0100110: textSelect[2] = 1'b1;
		7'b0101100: textSelect[2] = 1'b1;
		7'b0101101: textSelect[2] = 1'b1;
		7'b0110011: textSelect[2] = 1'b1;
		7'b0110100: textSelect[2] = 1'b1;
		7'b0111010: textSelect[2] = 1'b1;
		7'b0111011: textSelect[2] = 1'b1;
		7'b1000001: textSelect[2] = 1'b1;
		7'b1000010: textSelect[2] = 1'b1;
		7'b1001000: textSelect[2] = 1'b1;
		7'b1001001: textSelect[2] = 1'b1;
		7'b1010000: textSelect[2] = 1'b1;
		7'b1010001: textSelect[2] = 1'b1;
		7'b1010101: textSelect[2] = 1'b1;
		7'b1010110: textSelect[2] = 1'b1;
		7'b1011000: textSelect[2] = 1'b1;
		7'b1011001: textSelect[2] = 1'b1;
		7'b1011010: textSelect[2] = 1'b1;
		7'b1011011: textSelect[2] = 1'b1;
		7'b1011100: textSelect[2] = 1'b1;
		7'b1011101: textSelect[2] = 1'b1;
		7'b1011110: textSelect[2] = 1'b1;
		default: textSelect[2] = 1'b0;
	endcase
end

always @(*)
begin
	case(counter)
		7'b0010001: textSelect[3] = 1'b1;
		7'b0010010: textSelect[3] = 1'b1;
		7'b0010011: textSelect[3] = 1'b1;
		7'b0010100: textSelect[3] = 1'b1;
		7'b0010101: textSelect[3] = 1'b1;
		7'b0011000: textSelect[3] = 1'b1;
		7'b0011001: textSelect[3] = 1'b1;
		7'b0011101: textSelect[3] = 1'b1;
		7'b0011110: textSelect[3] = 1'b1;
		7'b0100101: textSelect[3] = 1'b1;
		7'b0100110: textSelect[3] = 1'b1;
		7'b0101101: textSelect[3] = 1'b1;
		7'b0101110: textSelect[3] = 1'b1;
		7'b0110010: textSelect[3] = 1'b1;
		7'b0110011: textSelect[3] = 1'b1;
		7'b0110100: textSelect[3] = 1'b1;
		7'b0110101: textSelect[3] = 1'b1;
		7'b0111101: textSelect[3] = 1'b1;
		7'b0111110: textSelect[3] = 1'b1;
		7'b1000101: textSelect[3] = 1'b1;
		7'b1000110: textSelect[3] = 1'b1;
		7'b1001101: textSelect[3] = 1'b1;
		7'b1001110: textSelect[3] = 1'b1;
		7'b1010000: textSelect[3] = 1'b1;
		7'b1010001: textSelect[3] = 1'b1;
		7'b1010101: textSelect[3] = 1'b1;
		7'b1010110: textSelect[3] = 1'b1;
		7'b1011001: textSelect[3] = 1'b1;
		7'b1011010: textSelect[3] = 1'b1;
		7'b1011011: textSelect[3] = 1'b1;
		7'b1011100: textSelect[3] = 1'b1;
		7'b1011101: textSelect[3] = 1'b1;
		default: textSelect[3] = 1'b0;
	endcase
end
endmodule