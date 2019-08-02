module tank(clk,resetn,initial_xpos,initial_ypos,direction,xpos,ypos,moving,start,moving_direction);
	input clk,resetn,start;
	input [7:0] initial_xpos;
	input [6:0] initial_ypos;
	input [2:0] direction;
	output reg [7:0] xpos;
	output reg [6:0] ypos;
	output reg moving;
	output reg [2:0] moving_direction;
	wire finish;
	reg [3:0] counter_output;
	reg counter_enable,init;
	reg [2:0] current_state,next_state;
	reg [20:0] dividerout;
	reg divider;
		
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
			if(!resetn)begin // if reset, then move tanks back to their inital postions.
				xpos <= initial_xpos;
				ypos <= initial_ypos;
				end
			else if(init == 1'd1)begin // if in the initial state, tanks are in inital positions.
				xpos <= initial_xpos;
				ypos <= initial_ypos;
				end
			else if(divider == 1'd1)begin
				case(moving_direction)
					3'b100: begin // go up, so y--
						xpos <= xpos;
						ypos <= ypos-1'd1;
						end
					3'b101: begin // go up, so y++
						xpos <= xpos;
						ypos <= ypos+1'd1;
						end
					3'b110: begin // go up, so x--
						xpos <= xpos-1'd1;
						ypos <= ypos;
						end
					3'b111: begin // go up, so x++
						xpos <= xpos+1'd1;
						ypos <= ypos;
						end
				endcase
			end
			else begin // stay in the original place.
				xpos <= xpos;
				ypos <= ypos;
				end
		end

	always @(posedge clk)
		begin: counter
			if(!resetn)
				counter_output <= 4'd0;
			else if(counter_enable == 4'd0)
				counter_output <= 4'd0;
			else if(counter_output == 4'b1111)
				counter_output <= 4'd0;
			else if(divider == 1'd1)
				counter_output <= counter_output + 1'b1;
			else
				counter_output <= counter_output;
		end

	assign finish = (counter_output == 4'd9) ? 1'b1 : 1'b0; // a tank finishes moving when it had moved 9 pixels.

	localparam      
					WAIT    = 3'd0,
					INITIAL = 3'd6,
					STATIC  = 3'd1,
					UP      = 3'd2,
					DOWN    = 3'd3,
					LEFT    = 3'd4,
					RIGHT   = 3'd5;
					
		
		always@(*)
		begin: state_table 
				case (current_state)
					WAIT: next_state = start ? INITIAL : WAIT;
					INITIAL: next_state = STATIC;
					STATIC: begin
						if(direction[2] == 1'd0) // this part is almost the same as the bullet.v module
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
				current_state <= WAIT;
			else
				current_state <= next_state;
		end // state_FFS
		
		always @(*)
		begin: output_logic
			counter_enable = 1'b0;
			init = 1'b0;
			moving = 1'b0;
			moving_direction = 3'd0;
			case (current_state)
				INITIAL: begin
					init = 1'b1;
					moving = 1'b0;
					end
				UP: begin
					counter_enable = 1'b1;
					moving = 1'b1;
					moving_direction = 3'b100;
					end
				DOWN: begin
					counter_enable = 1'b1;
					moving = 1'b1;
					moving_direction = 3'b101;
					end
				LEFT: begin
					counter_enable = 1'b1;
					moving = 1'b1;
					moving_direction = 3'b110;
					end
				RIGHT: begin
					counter_enable = 1'b1;
					moving = 1'b1;
					moving_direction = 3'b111;
					end
			endcase
		end
endmodule
