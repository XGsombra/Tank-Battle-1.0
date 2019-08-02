module bullet(clk,resetn,tx,ty,td,ready,fire,bx,by,bd,start);
	input clk,resetn,start;
	input [7:0] tx; // x-coordinate of tank
	input [6:0] ty; // y-coordinate of tank
	input [1:0] td; // direction of tank
	input ready; // a signal of bullet
	input fire; // the key of firing
	output reg [7:0] bx; // x-coordinate of bullet 
	output reg [6:0] by; // y-coordinate of bullet
	output reg [2:0] bd; // direction of bullet's movement. bd[2]==0 if no bullet movement.
	reg [2:0] current_state,next_state;	
	reg divider_enable;
	reg [19:0] dividerout;
	reg divider;
	
	localparam   // states of the bullet.
					WAIT = 3'd0,    // the bullet waits 
					READY = 3'd1,   // the bullet is ready.
					UP      = 3'd2, // bullet goes up.
					DOWN    = 3'd3, // bullet goes down.
					LEFT    = 3'd4, // bullet goes left.
					RIGHT   = 3'd5;	// bullet goes right.				
		
		always@(*)
		begin: state_table 
				case (current_state)
					WAIT: next_state = start ? READY : WAIT;
					READY: begin // the bullet will not be shot unless the fire key is pushed.
								if(!fire)
									next_state = READY;
								else begin // go to the direction that is indicated by tank direction
									case(td) // td for tank direction.
										2'd0: next_state = UP;
										2'd1: next_state = DOWN;
										2'd2: next_state = LEFT;
										2'd3: next_state = RIGHT;
									endcase
								end
							end
					UP: next_state = ready ? READY : UP;
					DOWN: next_state = ready ? READY : DOWN;
					LEFT: next_state = ready ? READY : LEFT;
					RIGHT: next_state = ready ? READY : RIGHT;
					default: next_state = READY;
				endcase
		end
												 
		// current_state registers
		always@(posedge clk)
		begin: state_FFs
			if(!resetn) // go to WAIT if the game restarts.
				current_state <= WAIT;
			else // otherwise go to the next state.
				current_state <= next_state;
		end // state_FFS
		
		always @(*)
		begin: output_logic
			divider_enable = 1'b0;
			bd = 3'd0;
			case (current_state) // bullet direction (i.e. bd, will be assigned a value according to the state.)
				READY: begin // ready means no direction of movement.
					divider_enable = 1'b0; // no movement of bullet.
					bd = 3'd0;
					end
				UP: begin
					divider_enable = 1'b1;
					bd = 3'b100;
					end
				DOWN: begin
					divider_enable = 1'b1;
					bd = 3'b101;
					end
				LEFT: begin
					divider_enable = 1'b1;
					bd = 3'b110;
					end
				RIGHT: begin
					divider_enable = 1'b1;
					bd = 3'b111;
					end
			endcase
		end
		
	always @(posedge clk)
		begin:ratedivider
			if(!resetn)begin
				dividerout <=  20'd0;
				divider <= 1'd0;
				end
			else if(dividerout == 20'b10100000010100000111)begin
				dividerout <= 20'd0;
				divider <= 1'd1;
				end
			else if(divider_enable == 1'd0)begin
				dividerout <= 20'd0;
				divider <= 1'd0;
				end
			else begin
				dividerout <= dividerout + 1'b1;
				divider <= 1'd0;
				end
		end
	
	always @(posedge clk)
		begin
			if(!bd[2])begin // no direction of movement, just load the coordinate of tank to bullet.
				bx <= tx;
				by <= ty;
				end
			else if(divider == 1'd1)begin
				case(bd[1:0])
					2'd0: begin // go up, so y--
						bx <= bx;
						by <= by-1'd1;
						end
					2'd1: begin // go down, so y++
						bx <= bx;
						by <= by+1'd1;
						end
					2'd2: begin // go left, so x--
						bx <= bx-1'd1;
						by <= by;
						end
					2'd3: begin // go right, so x++
						bx <= bx+1'd1;
						by <= by;
						end
				endcase
			end
			else begin
				bx <= bx;
				by <= by;
				end
		end
endmodule 
