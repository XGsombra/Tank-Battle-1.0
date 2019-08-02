module draw_map(clk,resetn,map_counter_enable,map_finish,mx,my,mapselect);
	input resetn,clk,map_counter_enable;
	input [1:0] mapselect;
	output [7:0] mx;
	output [6:0] my;
	output map_finish;
	reg [3:0] xp,yp;
	reg [5:0] counter_output1;
	reg [7:0] counter_output2;
	reg [3:0] xpos,ypos;
	wire map_out;
	
	map(counter_output2,map_out,mapselect);
	
	assign mx = 4'd9*xpos + 5'd21 + xp;
	assign my = 4'd9*ypos + 1'b1 + yp;
	
	always @(*)
	begin
		case(map_out)
			1'b0: begin
				xpos = 4'b0110;
				ypos = 4'b0110;
				end
			1'b1: begin
				xpos = counter_output2[7:4];
				ypos = counter_output2[3:0];
				end
		endcase
	end
	
	always @(posedge clk)
	begin: counter1
		if(!resetn)
			counter_output1 <= 6'd0;
		else if(counter_output1 == 6'd47)
			counter_output1 <= 6'd0;
		else if(map_counter_enable == 1'b0)
			counter_output1 <= 6'd0;
		else
			counter_output1 <= counter_output1 + 1'b1;
	end
	
	always @(posedge clk)
	begin: counter2
		if(!resetn)
			counter_output2 <= 8'd0;
		else if(counter_output2 == 8'b11111111)
			counter_output2 <= 8'd0;
		else if(map_counter_enable == 1'b0)
			counter_output2 <= 8'd0;
		else if(counter_output1 == 6'd47)
			counter_output2 <= counter_output2 + 1'b1;
		else
			counter_output2 <= counter_output2;
	end
	
	assign map_finish = &counter_output2;
	
	always @(*)
	begin
		case(counter_output1)
			6'd0: begin
				xp = 4'd0;
				yp = 4'd0;
				end
			6'd1: begin
				xp = 4'd2;
				yp = 4'd0;
				end
			6'd2: begin
				xp = 4'd3;
				yp = 4'd0;
				end
			6'd3: begin
				xp = 4'd4;
				yp = 4'd0;
				end
			6'd4: begin
				xp = 4'd5;
				yp = 4'd0;
				end
			6'd5: begin
				xp = 4'd6;
				yp = 4'd0;
				end
			6'd6: begin
				xp = 4'd7;
				yp = 4'd0;
				end
			6'd7: begin
				xp = 4'd8;
				yp = 4'd0;
				end
			6'd8: begin
				xp = 4'd0;
				yp = 4'd2;
				end
			6'd9: begin
				xp = 4'd1;
				yp = 4'd2;
				end
			6'd10: begin
				xp = 4'd2;
				yp = 4'd2;
				end
			6'd11: begin
				xp = 4'd3;
				yp = 4'd2;
				end
			6'd12: begin
				xp = 4'd5;
				yp = 4'd2;
				end
			6'd13: begin
				xp = 4'd6;
				yp = 4'd2;
				end
			6'd14: begin
				xp = 4'd7;
				yp = 4'd2;
				end
			6'd15: begin
				xp = 4'd8;
				yp = 4'd2;
				end
			6'd16: begin
				xp = 4'd0;
				yp = 4'd3;
				end
			6'd17: begin
				xp = 4'd1;
				yp = 4'd3;
				end
			6'd18: begin
				xp = 4'd2;
				yp = 4'd3;
				end
			6'd19: begin
				xp = 4'd3;
				yp = 4'd3;
				end
			6'd20: begin
				xp = 4'd5;
				yp = 4'd3;
				end
			6'd21: begin
				xp = 4'd6;
				yp = 4'd3;
				end
			6'd22: begin
				xp = 4'd7;
				yp = 4'd3;
				end
			6'd23: begin
				xp = 4'd8;
				yp = 4'd3;
				end
			6'd24: begin
				xp = 4'd0;
				yp = 4'd5;
				end
			6'd25: begin
				xp = 4'd1;
				yp = 4'd5;
				end
			6'd26: begin
				xp = 4'd2;
				yp = 4'd5;
				end
			6'd27: begin
				xp = 4'd3;
				yp = 4'd5;
				end
			6'd28: begin
				xp = 4'd4;
				yp = 4'd5;
				end
			6'd29: begin
				xp = 4'd5;
				yp = 4'd5;
				end
			6'd30: begin
				xp = 4'd6;
				yp = 4'd5;
				end
			6'd31: begin
				xp = 4'd8;
				yp = 4'd5;
				end
			6'd32: begin
				xp = 4'd0;
				yp = 4'd6;
				end
			6'd33: begin
				xp = 4'd1;
				yp = 4'd6;
				end
			6'd34: begin
				xp = 4'd2;
				yp = 4'd6;
				end
			6'd35: begin
				xp = 4'd3;
				yp = 4'd6;
				end
			6'd36: begin
				xp = 4'd4;
				yp = 4'd6;
				end
			6'd37: begin
				xp = 4'd5;
				yp = 4'd6;
				end
			6'd38: begin
				xp = 4'd6;
				yp = 4'd6;
				end
			6'd39: begin
				xp = 4'd8;
				yp = 4'd6;
				end
			6'd40: begin
				xp = 4'd0;
				yp = 4'd8;
				end
			6'd41: begin
				xp = 4'd2;
				yp = 4'd8;
				end
			6'd42: begin
				xp = 4'd3;
				yp = 4'd8;
				end
			6'd43: begin
				xp = 4'd4;
				yp = 4'd8;
				end
			6'd44: begin
				xp = 4'd5;
				yp = 4'd8;
				end
			6'd45: begin
				xp = 4'd6;
				yp = 4'd8;
				end
			6'd46: begin
				xp = 4'd7;
				yp = 4'd8;
				end
			6'd47: begin
				xp = 4'd8;
				yp = 4'd8;
				end
			default: begin
				xp = 4'd0;
				yp = 4'd0;
				end
		endcase
	end
endmodule