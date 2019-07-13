module draw_tank(xpos,ypos,clk,resetn,direction,counter_enable,finish,x,y);
	input [6:0] ypos;
	input [7:0] xpos;
	input [1:0] direction;
	input clk,resetn,counter_enable;
	output finish;
	output [6:0] y;
	output [7:0] x;

	reg [3:0] xp,yp,xpu,ypu,xpd,ypd,xpl,ypl,xpr,ypr;
	reg [5:0] counter_output;

	assign finish = (counter_output == 6'd59) ? 1'b1 : 1'b0;
	assign x = xpos + xp;
	assign y = ypos + yp;

	always @(posedge clk)
		begin: counter
			if(!resetn)
				counter_output <= 6'd0;
			else if(counter_output == 6'd59)
				counter_output <= 6'd0;
			else if(counter_enable == 1'b1)
				counter_output <= counter_output + 1'b1;
			else
				counter_output <= counter_output;
		end

	always @(*)
	begin
		case(direction)
			2'd0: begin
					xp = xpu;
					yp = ypu;
				end
			2'd1: begin
					xp = xpd;
					yp = ypd;
				end
			2'd2: begin
					xp = xpl;
					yp = ypl;
				end
			2'd3: begin
					xp = xpr;
					yp = ypr;
				end
		endcase
	end

	always @(*)
	begin:tank_plot
		case(counter_output)
			6'd0: begin
					xpu = 4'd0;
					ypu = 4'd0;
					xpd = 4'd0;
					ypd = 4'd0;
					xpl = 4'd0;
					ypl = 4'd0;
					xpr = 4'd0;
					ypr = 4'd0;
				end
			6'd1: begin
					xpu = 4'd0;
					ypu = 4'd1;
					xpd = 4'd0;
					ypd = 4'd1;
					xpl = 4'd0;
					ypl = 4'd1;
					xpr = 4'd0;
					ypr = 4'd1;
				end
			6'd2: begin
					xpu = 4'd0;
					ypu = 4'd2;
					xpd = 4'd0;
					ypd = 4'd2;
					xpl = 4'd0;
					ypl = 4'd4;
					xpr = 4'd0;
					ypr = 4'd7;
				end
			6'd3: begin
					xpu = 4'd0;
					ypu = 4'd3;
					xpd = 4'd0;
					ypd = 4'd3;
					xpl = 4'd0;
					ypl = 4'd7;
					xpr = 4'd0;
					ypr = 4'd8;
				end
			6'd4: begin
					xpu = 4'd0;
					ypu = 4'd4;
					xpd = 4'd0;
					ypd = 4'd4;
					xpl = 4'd0;
					ypl = 4'd8;
					xpr = 4'd1;
					ypr = 4'd0;
				end
			6'd5: begin
					xpu = 4'd0;
					ypu = 4'd5;
					xpd = 4'd0;
					ypd = 4'd5;
					xpl = 4'd1;
					ypl = 4'd0;
					xpr = 4'd1;
					ypr = 4'd1;
				end
			6'd6: begin
					xpu = 4'd0;
					ypu = 4'd6;
					xpd = 4'd0;
					ypd = 4'd6;
					xpl = 4'd1;
					ypl = 4'd1;
					xpr = 4'd1;
					ypr = 4'd2;
				end
			6'd7: begin
					xpu = 4'd0;
					ypu = 4'd7;
					xpd = 4'd0;
					ypd = 4'd7;
					xpl = 4'd1;
					ypl = 4'd4;
					xpr = 4'd1;
					ypr = 4'd3;
				end
			6'd8: begin
					xpu = 4'd0;
					ypu = 4'd8;
					xpd = 4'd0;
					ypd = 4'd8;
					xpl = 4'd1;
					ypl = 4'd7;
					xpr = 4'd1;
					ypr = 4'd4;
				end
			6'd9: begin
					xpu = 4'd1;
					ypu = 4'd0;
					xpd = 4'd1;
					ypd = 4'd0;
					xpl = 4'd1;
					ypl = 4'd8;
					xpr = 4'd1;
					ypr = 4'd5;
				end
			6'd10: begin
					xpu = 4'd1;
					ypu = 4'd1;
					xpd = 4'd1;
					ypd = 4'd1;
					xpl = 4'd2;
					ypl = 4'd0;
					xpr = 4'd1;
					ypr = 4'd6;
				end
			6'd11: begin
					xpu = 4'd1;
					ypu = 4'd2;
					xpd = 4'd1;
					ypd = 4'd2;
					xpl = 4'd2;
					ypl = 4'd1;
					xpr = 4'd1;
					ypr = 4'd7;
				end
			6'd12: begin
					xpu = 4'd1;
					ypu = 4'd3;
					xpd = 4'd1;
					ypd = 4'd3;
					xpl = 4'd2;
					ypl = 4'd4;
					xpr = 4'd1;
					ypr = 4'd8;
				end
			6'd13: begin
					xpu = 4'd1;
					ypu = 4'd4;
					xpd = 4'd1;
					ypd = 4'd4;
					xpl = 4'd2;
					ypl = 4'd7;
					xpr = 4'd2;
					ypr = 4'd0;
				end
			6'd14: begin
					xpu = 4'd1;
					ypu = 4'd5;
					xpd = 4'd1;
					ypd = 4'd5;
					xpl = 4'd2;
					ypl = 4'd8;
					xpr = 4'd2;
					ypr = 4'd1;
				end
			6'd15: begin
					xpu = 4'd1;
					ypu = 4'd6;
					xpd = 4'd1;
					ypd = 4'd6;
					xpl = 4'd3;
					ypl = 4'd0;
					xpr = 4'd2;
					ypr = 4'd2;
				end
			6'd16: begin
					xpu = 4'd1;
					ypu = 4'd7;
					xpd = 4'd1;
					ypd = 4'd7;
					xpl = 4'd3;
					ypl = 4'd1;
					xpr = 4'd2;
					ypr = 4'd3;
				end
			6'd17: begin
					xpu = 4'd1;
					ypu = 4'd8;
					xpd = 4'd1;
					ypd = 4'd8;
					xpl = 4'd3;
					ypl = 4'd4;
					xpr = 4'd2;
					ypr = 4'd4;
				end
			6'd18: begin
					xpu = 4'd2;
					ypu = 4'd4;
					xpd = 4'd2;
					ypd = 4'd1;
					xpl = 4'd3;
					ypl = 4'd7;
					xpr = 4'd2;
					ypr = 4'd5;
				end
			6'd19: begin
					xpu = 4'd2;
					ypu = 4'd5;
					xpd = 4'd2;
					ypd = 4'd2;
					xpl = 4'd3;
					ypl = 4'd8;
					xpr = 4'd2;
					ypr = 4'd6;
				end
			6'd20: begin
					xpu = 4'd2;
					ypu = 4'd6;
					xpd = 4'd2;
					ypd = 4'd3;
					xpl = 4'd4;
					ypl = 4'd0;
					xpr = 4'd2;
					ypr = 4'd7;
				end
			6'd21: begin
					xpu = 4'd2;
					ypu = 4'd7;
					xpd = 4'd2;
					ypd = 4'd4;
					xpl = 4'd4;
					ypl = 4'd1;
					xpr = 4'd2;
					ypr = 4'd8;
				end
			6'd22: begin
					xpu = 4'd3;
					ypu = 4'd4;
					xpd = 4'd3;
					ypd = 4'd1;
					xpl = 4'd4;
					ypl = 4'd2;
					xpr = 4'd3;
					ypr = 4'd0;
				end
			6'd23: begin
					xpu = 4'd3;
					ypu = 4'd5;
					xpd = 4'd3;
					ypd = 4'd2;
					xpl = 4'd4;
					ypl = 4'd3;
					xpr = 4'd3;
					ypr = 4'd1;
				end
			6'd24: begin
					xpu = 4'd3;
					ypu = 4'd6;
					xpd = 4'd3;
					ypd = 4'd3;
					xpl = 4'd4;
					ypl = 4'd4;
					xpr = 4'd3;
					ypr = 4'd2;
				end
			6'd25: begin
					xpu = 4'd3;
					ypu = 4'd7;
					xpd = 4'd3;
					ypd = 4'd4;
					xpl = 4'd4;
					ypl = 4'd5;
					xpr = 4'd3;
					ypr = 4'd3;
				end
			6'd26: begin
					xpu = 4'd4;
					ypu = 4'd0;
					xpd = 4'd4;
					ypd = 4'd1;
					xpl = 4'd4;
					ypl = 4'd5;
					xpr = 4'd3;
					ypr = 4'd4;
				end
			6'd27: begin
					xpu = 4'd4;
					ypu = 4'd1;
					xpd = 4'd4;
					ypd = 4'd2;
					xpl = 4'd4;
					ypl = 4'd7;
					xpr = 4'd3;
					ypr = 4'd5;
				end
			6'd28: begin
					xpu = 4'd4;
					ypu = 4'd2;
					xpd = 4'd4;
					ypd = 4'd3;
					xpl = 4'd4;
					ypl = 4'd8;
					xpr = 4'd3;
					ypr = 4'd5;
				end
			6'd29: begin
					xpu = 4'd4;
					ypu = 4'd3;
					xpd = 4'd4;
					ypd = 4'd4;
					xpl = 4'd5;
					ypl = 4'd0;
					xpr = 4'd3;
					ypr = 4'd7;
				end
			6'd30: begin
					xpu = 4'd4;
					ypu = 4'd4;
					xpd = 4'd4;
					ypd = 4'd5;
					xpl = 4'd5;
					ypl = 4'd1;
					xpr = 4'd3;
					ypr = 4'd8;
				end
			6'd31: begin
					xpu = 4'd4;
					ypu = 4'd5;
					xpd = 4'd4;
					ypd = 4'd6;
					xpl = 4'd5;
					ypl = 4'd2;
					xpr = 4'd4;
					ypr = 4'd0;
				end
			6'd32: begin
					xpu = 4'd4;
					ypu = 4'd6;
					xpd = 4'd4;
					ypd = 4'd7;
					xpl = 4'd5;
					ypl = 4'd3;
					xpr = 4'd4;
					ypr = 4'd1;
				end
			6'd33: begin
					xpu = 4'd4;
					ypu = 4'd7;
					xpd = 4'd4;
					ypd = 4'd8;
					xpl = 4'd5;
					ypl = 4'd4;
					xpr = 4'd4;
					ypr = 4'd2;
				end
			6'd34: begin
					xpu = 4'd5;
					ypu = 4'd4;
					xpd = 4'd5;
					ypd = 4'd1;
					xpl = 4'd5;
					ypl = 4'd5;
					xpr = 4'd4;
					ypr = 4'd3;
				end
			6'd35: begin
					xpu = 4'd5;
					ypu = 4'd5;
					xpd = 4'd5;
					ypd = 4'd2;
					xpl = 4'd5;
					ypl = 4'd6;
					xpr = 4'd4;
					ypr = 4'd4;
				end
			6'd36: begin
					xpu = 4'd5;
					ypu = 4'd6;
					xpd = 4'd5;
					ypd = 4'd3;
					xpl = 4'd5;
					ypl = 4'd7;
					xpr = 4'd4;
					ypr = 4'd5;
				end
			6'd37: begin
					xpu = 4'd5;
					ypu = 4'd7;
					xpd = 4'd5;
					ypd = 4'd4;
					xpl = 4'd5;
					ypl = 4'd8;
					xpr = 4'd4;
					ypr = 4'd6;
				end
			6'd38: begin
					xpu = 4'd6;
					ypu = 4'd4;
					xpd = 4'd6;
					ypd = 4'd1;
					xpl = 4'd6;
					ypl = 4'd0;
					xpr = 4'd4;
					ypr = 4'd7;
				end
			6'd39: begin
					xpu = 4'd6;
					ypu = 4'd5;
					xpd = 4'd6;
					ypd = 4'd2;
					xpl = 4'd6;
					ypl = 4'd1;
					xpr = 4'd4;
					ypr = 4'd8;
				end
			6'd40: begin
					xpu = 4'd6;
					ypu = 4'd6;
					xpd = 4'd6;
					ypd = 4'd3;
					xpl = 4'd6;
					ypl = 4'd2;
					xpr = 4'd5;
					ypr = 4'd0;
				end
			6'd41: begin
					xpu = 4'd6;
					ypu = 4'd7;
					xpd = 4'd6;
					ypd = 4'd4;
					xpl = 4'd6;
					ypl = 4'd3;
					xpr = 4'd5;
					ypr = 4'd1;
				end
			6'd42: begin
					xpu = 4'd7;
					ypu = 4'd0;
					xpd = 4'd7;
					ypd = 4'd6;
					xpl = 4'd4;
					ypl = 4'd0;
					xpr = 4'd5;
					ypr = 4'd4;
				end
			6'd43: begin
					xpu = 4'd7;
					ypu = 4'd1;
					xpd = 4'd7;
					ypd = 4'd1;
					xpl = 4'd6;
					ypl = 4'd5;
					xpr = 4'd5;
					ypr = 4'd7;
				end
			6'd44: begin
					xpu = 4'd7;
					ypu = 4'd2;
					xpd = 4'd7;
					ypd = 4'd2;
					xpl = 4'd6;
					ypl = 4'd6;
					xpr = 4'd5;
					ypr = 4'd8;
				end
			6'd45: begin
					xpu = 4'd7;
					ypu = 4'd3;
					xpd = 4'd7;
					ypd = 4'd3;
					xpl = 4'd6;
					ypl = 4'd7;
					xpr = 4'd6;
					ypr = 4'd0;
				end
			6'd46: begin
					xpu = 4'd7;
					ypu = 4'd4;
					xpd = 4'd7;
					ypd = 4'd4;
					xpl = 4'd6;
					ypl = 4'd8;
					xpr = 4'd6;
					ypr = 4'd1;
				end
			6'd47: begin
					xpu = 4'd7;
					ypu = 4'd5;
					xpd = 4'd7;
					ypd = 4'd5;
					xpl = 4'd7;
					ypl = 4'd0;
					xpr = 4'd6;
					ypr = 4'd4;
				end
			6'd48: begin
					xpu = 4'd7;
					ypu = 4'd6;
					xpd = 4'd7;
					ypd = 4'd6;
					xpl = 4'd7;
					ypl = 4'd1;
					xpr = 4'd6;
					ypr = 4'd7;
				end
			6'd49: begin
					xpu = 4'd7;
					ypu = 4'd7;
					xpd = 4'd7;
					ypd = 4'd7;
					xpl = 4'd7;
					ypl = 4'd2;
					xpr = 4'd6;
					ypr = 4'd8;
				end
			6'd50: begin
					xpu = 4'd7;
					ypu = 4'd8;
					xpd = 4'd7;
					ypd = 4'd8;
					xpl = 4'd7;
					ypl = 4'd3;
					xpr = 4'd7;
					ypr = 4'd0;
				end
			6'd51: begin
					xpu = 4'd8;
					ypu = 4'd0;
					xpd = 4'd8;
					ypd = 4'd0;
					xpl = 4'd7;
					ypl = 4'd4;
					xpr = 4'd7;
					ypr = 4'd1;
				end
			6'd52: begin
					xpu = 4'd8;
					ypu = 4'd1;
					xpd = 4'd8;
					ypd = 4'd1;
					xpl = 4'd7;
					ypl = 4'd5;
					xpr = 4'd7;
					ypr = 4'd4;
				end
			6'd53: begin
					xpu = 4'd8;
					ypu = 4'd2;
					xpd = 4'd8;
					ypd = 4'd2;
					xpl = 4'd7;
					ypl = 4'd6;
					xpr = 4'd7;
					ypr = 4'd7;
				end
			6'd54: begin
					xpu = 4'd8;
					ypu = 4'd3;
					xpd = 4'd8;
					ypd = 4'd3;
					xpl = 4'd7;
					ypl = 4'd7;
					xpr = 4'd7;
					ypr = 4'd8;
				end
			6'd55: begin
					xpu = 4'd8;
					ypu = 4'd4;
					xpd = 4'd8;
					ypd = 4'd4;
					xpl = 4'd7;
					ypl = 4'd8;
					xpr = 4'd8;
					ypr = 4'd0;
				end
			6'd56: begin
					xpu = 4'd8;
					ypu = 4'd5;
					xpd = 4'd8;
					ypd = 4'd5;
					xpl = 4'd8;
					ypl = 4'd0;
					xpr = 4'd8;
					ypr = 4'd1;
				end
			6'd57: begin
					xpu = 4'd8;
					ypu = 4'd6;
					xpd = 4'd8;
					ypd = 4'd6;
					xpl = 4'd8;
					ypl = 4'd1;
					xpr = 4'd8;
					ypr = 4'd4;
				end
			6'd58: begin
					xpu = 4'd8;
					ypu = 4'd7;
					xpd = 4'd8;
					ypd = 4'd7;
					xpl = 4'd8;
					ypl = 4'd7;
					xpr = 4'd8;
					ypr = 4'd7;
				end
			6'd59: begin
					xpu = 4'd8;
					ypu = 4'd8;
					xpd = 4'd8;
					ypd = 4'd8;
					xpl = 4'd8;
					ypl = 4'd8;
					xpr = 4'd8;
					ypr = 4'd8;
				end
			default: begin
					xpu = 4'd0;
					ypu = 4'd0;
					xpd = 4'd0;
					ypd = 4'd0;
					xpl = 4'd0;
					ypl = 4'd0;
					xpr = 4'd0;
					ypr = 4'd0;
				end
		endcase
	end
endmodule

				