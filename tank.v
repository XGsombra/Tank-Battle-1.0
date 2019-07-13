module tank(clk,resetn,initial_xpos,initial_ypos,initial_x,initial_y,direction,x,x1,y,y1,xpos,ypos,moving);
	input clk,resetn;
	input [7:0] initial_xpos;
	input [6:0] initial_ypos;
	input [3:0] initial_x,initial_y;
	input [2:0] direction;
	output reg [3:0] x,x1,y,y1;
	output reg [7:0] xpos;
	output reg [6:0] ypos;
	output reg moving;
	wire [3:0] xu,xd,xl,xr,yu,yd,yl,yr;
	wire finish;
	reg [3:0] counter_output;
	reg counter_enable,init;
	reg [2:0] current_state,next_state;
	reg [1:0] moving_direction;
	reg [20:0] dividerout;
	reg divider;
	
	assign xu = x;
	assign yu = y-1'd1;
	assign xd = x;
	assign yd = y+1'd1;
	assign xl = x-1'd1;
	assign yl = y;
	assign xr = x+1'd1;
	assign yr = y;
				
	always @(*)
		begin:x1_y1
			if(counter_enable == 1'b0)begin
				x1 = x;
				y1 = y;
				end
			else begin
				case(moving_direction)
					2'd0: begin
						x1 = xu;
						y1 = yu;
						end
					2'd1: begin
						x1 = xd;
						y1 = yd;
						end
					2'd2: begin
						x1 = xl;
						y1 = yl;
						end
					2'd3: begin
						x1 = xr;
						y1 = yr;
						end
				endcase
			end
		end
		
	always @(posedge clk)
		begin:ratedivider
			if(!resetn)begin
				dividerout <=  21'd0;
				divider <= 1'd0;
				end
			else if(dividerout == 21'b110000110101000000000)begin
				dividerout <= 21'd0;
				divider <= 1'd1;
				end
			else if(counter_enable == 1'd0)begin
				dividerout <= 21'd0;
				divider <= 1'd0;
				end
			else begin
				dividerout <= dividerout + 1'b1;
				divider <= 1'd0;
				end
		end
		
	always @(posedge clk)
		begin
			if(!resetn)begin
				xpos <= initial_xpos;
				ypos <= initial_ypos;
				end
			else if(init == 1'd1)begin
				xpos <= initial_xpos;
				ypos <= initial_ypos;
				end
			else if(divider == 1'd1)begin
				case(moving_direction)
					2'd0: begin
						xpos <= xpos;
						ypos <= ypos-1'd1;
						end
					2'd1: begin
						xpos <= xpos;
						ypos <= ypos+1'd1;
						end
					2'd2: begin
						xpos <= xpos-1'd1;
						ypos <= ypos;
						end
					2'd3: begin
						xpos <= xpos+1'd1;
						ypos <= ypos;
						end
				endcase
			end
			else begin
				xpos <= xpos;
				ypos <= ypos;
				end
		end

	always @(posedge clk)
		begin
			if(!resetn)begin
				x <= initial_x;
				y <= initial_y;
				end
			else if(init == 1'd1)begin
				x <= initial_x;
				y <= initial_y;
				end
			else if(finish == 1'd1)begin
				case(direction[1:0])
					2'd0: begin
						x <= x;
						y <= y-1'd1;
						end
					2'd1: begin
						x <= x;
						y <= y+1'd1;
						end
					2'd2: begin
						x <= x-1'd1;
						y <= y;
						end
					2'd3: begin
						x <= x+1'd1;
						y <= y;
						end
				endcase
			end
			else begin
				x <= x;
				y <= y;
				end
		end

	always @(posedge clk)
		begin: counter
			if(!resetn)
				counter_output <= 4'd0;
			else if(counter_enable == 4'd0)
				counter_output <= 4'd0;
			else if(divider == 1'd1)
				counter_output <= counter_output + 1'b1;
			else
				counter_output <= counter_output;
		end

	assign finish = (counter_output == 4'd9) ? 1'b1 : 1'b0;

	localparam      INITIAL = 3'd0,
					STATIC  = 3'd1,
					UP      = 3'd2,
					DOWN    = 3'd3,
					LEFT    = 3'd4,
					RIGHT   = 3'd5;
					
		
		always@(*)
		begin: state_table 
				case (current_state)
					INITIAL: next_state = STATIC;
					STATIC: begin
								if(direction[2] == 1'd0)
									next_state = STATIC;
								else begin
									case(direction[1:0])
										2'd0: next_state = UP;
										2'd1: next_state = DOWN;
										2'd2: next_state = LEFT;
										2'd3: next_state = RIGHT;
									endcase
								end
							end
					UP: next_state = finish ? STATIC : UP;
					DOWN: next_state = finish ? STATIC : DOWN;
					LEFT: next_state = finish ? STATIC : LEFT;
					RIGHT: next_state = finish ? STATIC : RIGHT;
					default: next_state = STATIC;
				endcase
		end
												 
		// current_state registers
		always@(posedge clk)
		begin: state_FFs
			if(!resetn)
				current_state <= INITIAL;
			else
				current_state <= next_state;
		end // state_FFS
		
		always @(*)
		begin: output_logic
			counter_enable = 1'b0;
			init = 1'b0;
			moving = 1'b0;
			moving_direction = 2'd0;
			case (current_state)
				INITIAL: begin
					init = 1'b1;
					moving = 1'b0;
					end
				UP: begin
					counter_enable = 1'b1;
					moving = 1'b1;
					moving_direction = 2'd0;
					end
				DOWN: begin
					counter_enable = 1'b1;
					moving = 1'b1;
					moving_direction = 2'd1;
					end
				LEFT: begin
					counter_enable = 1'b1;
					moving = 1'b1;
					moving_direction = 2'd2;
					end
				RIGHT: begin
					counter_enable = 1'b1;
					moving = 1'b1;
					moving_direction = 2'd3;
					end
			endcase
		end
endmodule
