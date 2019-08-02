module erase_wall(clk,resetn,erase_wall_enable,x_y,x,y,finish);
	input clk,resetn;
	input erase_wall_enable;
	input [7:0] x_y;
	output [7:0] x;
	output [6:0] y;
	output finish;
	reg [5:0] counter_output;
	reg [3:0] xp,yp;
	
	assign x = 4'd9*x_y[7:4] + 5'd21 + xp;
	assign y = 4'd9*x_y[3:0] + 1'b1 + yp;
	assign finish = (counter_output == 6'd47);
	always @(posedge clk)
	begin
		if(!resetn)
			counter_output <= 6'd0;
		else if(counter_output == 6'd47)
			counter_output <= 6'd0;
		else if(!erase_wall_enable)
			counter_output <= 6'd0;
		else
			counter_output <= counter_output + 1'b1;
	end
	
	always @(*)
	begin
		case(counter_output)
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
			