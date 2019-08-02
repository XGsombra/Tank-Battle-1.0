module draw(clk,resetn,start,
t1y,t2y,t3y,t4y,b1y,b2y,b3y,b4y, // t for tank, b for bullet
t1x,t2x,t3x,t4x,b1x,b2x,b3x,b4x, // 1, 2, 3, 4 for tank and bullet number
t1e,t2e,t3e,t4e,b1e,b2e,b3e,b4e, // y, x, e, d for y, x-coordinates, existence and direction
t1d,t2d,t3d,t4d,b1d,b2d,b3d,b4d,
x,y,colour,plot,wall_destroyed,erase_wall_finish,
winner,t1score,t2score,t3score,t4score,
mapselect);
	input clk,resetn,start;
	input [1:0] mapselect; // SW[1:0]
	input [6:0] t1y,t2y,t3y,t4y,b1y,b2y,b3y,b4y;
	input [7:0] t1x,t2x,t3x,t4x,b1x,b2x,b3x,b4x;
	input t1e,t2e,t3e,t4e,b1e,b2e,b3e,b4e;
	//if t1e = 1 then tank 1 exists.
	input [1:0] t1d,t2d,t3d,t4d;
	input [2:0] b1d,b2d,b3d,b4d;
	input [7:0] wall_destroyed;
	input [2:0] winner; 
	input [2:0] t1score,t2score,t3score,t4score;
	output reg [2:0] colour;
	output reg [6:0] y;
	output reg [7:0] x;
	output erase_wall_finish;
	output plot;
	reg [7:0] t1xtmp,t2xtmp,t3xtmp,t4xtmp,b1xtmp,b2xtmp,b3xtmp,b4xtmp;
	reg [6:0] t1ytmp,t2ytmp,t3ytmp,t4ytmp,b1ytmp,b2ytmp,b3ytmp,b4ytmp;
	wire finish,map_finish,menu_finish,score_finish,menu_plot,score_plot;
	wire [6:0] tyo,my,menu_y,score_y;
	wire [7:0] txo,mx,menu_x,score_x;
	wire [7:0] wx;
	wire [6:0] wy;
	reg [7:0] bxreal;
	reg [6:0] byreal;
	reg [6:0] t1yy,t2yy,t3yy,t4yy,b1yy,b2yy,b3yy,b4yy;
	reg [7:0] t1xx,t2xx,t3xx,t4xx,b1xx,b2xx,b3xx,b4xx;
	reg [6:0] ty,by;
	reg [7:0] tx,bx;
	reg [1:0] direction;
	reg [1:0] t1dd,t2dd,t3dd,t4dd;
	reg [2:0] b1dd,b2dd,b3dd,b4dd;
	reg [4:0] object; // record the oject to draw
	reg [4:0] current_state, next_state;
	reg [2:0] bdirection;
	reg [1:0] tank_num;
	reg score_enable,erase,map_counter_enable,counter_enable,erase_wall_enable,menu_enable,load_t1,load_t2,load_t3,load_t4,load_b1,load_b2,load_b3,load_b4;
	wire ld_t1,ld_t2,ld_t3,ld_t4;
	reg bound;
	
	draw_map(clk,resetn,map_counter_enable,map_finish,mx,my,mapselect);
	draw_tank(tx,ty,clk,resetn,direction,counter_enable,finish,txo,tyo);
	erase_wall(clk,resetn,erase_wall_enable,wall_destroyed,wx,wy,erase_wall_finish);
	menu(clk,erase,bound,menu_enable,winner,menu_finish,menu_plot,menu_x,menu_y);
	draw_score(clk,score_enable,t1score,t2score,t3score,t4score,tank_num,erase,score_x,score_y,score_plot,score_finish);
	
	assign ld_t1 = load_t1 & finish; // signals to update tanks
	assign ld_t2 = load_t2 & finish;
	assign ld_t3 = load_t3 & finish;
	assign ld_t4 = load_t4 & finish;
	assign plot = ~((object == 5'b11000)&~score_plot | (object == 5'b10000)&~menu_plot | (object == 5'd0)&~load_t1&~t1e | (object == 5'd1)&~load_t2&~t2e | (object == 5'd2)&~load_t3&~t3e | (object == 5'd3)&~load_t4&~t4e | (object == 5'd4)&~load_b1&~b1e | (object == 5'd5)&~load_b2&~b2e | (object == 5'd6)&~load_b3&~b3e | (object == 5'd7)&~load_b4&~b4e);
	
	always @(*)
	begin
		if(t1e)begin
			t1xtmp = t1x;
			t1ytmp = t1y;
			b1xtmp = b1x;
			b1ytmp = b1y;
			end
		else begin
			t1xtmp = 8'd147;
			t1ytmp = 7'd109;
			b1xtmp = 8'd147;
			b1ytmp = 7'd109;
			end
		if(t2e)begin
			t2xtmp = t2x;
			t2ytmp = t2y;
			b2xtmp = b2x;
			b2ytmp = b2y;
			end
		else begin
			t2xtmp = 8'd147;
			t2ytmp = 7'd109;
			b2xtmp = 8'd147;
			b2ytmp = 7'd109;
			end
		if(t3e)begin
			t3xtmp = t3x;
			t3ytmp = t3y;
			b3xtmp = b3x;
			b3ytmp = b3y;
			end
		else begin
			t3xtmp = 8'd147;
			t3ytmp = 7'd109;
			b3xtmp = 8'd147;
			b3ytmp = 7'd109;
			end
		if(t4e)begin
			t4xtmp = t4x;
			t4ytmp = t4y;
			b4xtmp = b4x;
			b4ytmp = b4y;
			end
		else begin
			t4xtmp = 8'd147;
			t4ytmp = 7'd109;
			b4xtmp = 8'd147;
			b4ytmp = 7'd109;
			end
	end
	
	always @(*)
	begin
		case(bdirection)
			3'b100: begin
				bxreal = bx+3'd4;
				byreal = by;
				end
			3'b101: begin
				bxreal = bx+3'd4;
				byreal = by+4'd8;
				end
			3'b110: begin
				bxreal = bx;
				byreal = by+3'd4;
				end
			3'b111: begin
				bxreal = bx+4'd8;
				byreal = by+3'd4;
				end
			3'b000: begin
				bxreal = bx+1'b1;
				byreal = by;
				end
			default:begin
				bxreal = bx;
				byreal = by;
				end
		endcase
	end
	
	always @(*)
	begin
		case(object[4:2]) // in terms of different objects.
			3'b000: begin // tank
					x = txo; 
					y = tyo;
					end
			3'b001: begin // bullet
					x = bxreal;
					y = byreal;
					end
			3'b010: begin // map
					x = mx;
					y = my;
					end
			3'b011: begin // wall
					x = wx;
					y = wy;
					end
			3'b100: begin // the menu
					x = menu_x;
					y = menu_y;
					end
			3'b110: begin // the score
					x = score_x;
					y = score_y;
					end
			default: begin
					x = mx;
					y = my;
					end
		endcase
	end

	always @(*)
	begin
		case(object[1:0])
			2'd0: begin
					tx = t1xx;
					ty = t1yy;
					direction = t1dd;
					bx = b1xx;
					by = b1yy;
					bdirection = b1dd;
					end
			2'd1: begin
					tx = t2xx;
					ty = t2yy;
					direction = t2dd;
					bx = b2xx;
					by = b2yy;
					bdirection = b2dd;
					end
			2'd2: begin
					tx = t3xx;
					ty = t3yy;
					direction = t3dd;
					bx = b3xx;
					by = b3yy;
					bdirection = b3dd;
					end
			2'd3: begin
					tx = t4xx;
					ty = t4yy;
					direction = t4dd;
					bx = b4xx;
					by = b4yy;
					bdirection = b4dd;
					end
		endcase
	end

	always @(posedge clk)
	begin
		if(!resetn)
		begin
			t1xx <= 8'd21;
			t1yy <= 7'd1;
			t1dd <= 2'd0;
			end
		else if(ld_t1 == 1'b1)
		begin
			t1xx <= t1xtmp;
			t1yy <= t1ytmp;
			t1dd <= t1d;
			end
		else
		begin
			t1xx <= t1xx;
			t1yy <= t1yy;
			t1dd <= t1dd;
			end
		if(!resetn)
		begin
			t2xx <= 8'd129;
			t2yy <= 7'd1;
			t2dd <= 2'd0;
			end
		else if(ld_t2 == 1'b1)
		begin
			t2xx <= t2xtmp;
			t2yy <= t2ytmp;
			t2dd <= t2d;
			end
		else
		begin
			t2xx <= t2xx;
			t2yy <= t2yy;
			t2dd <= t2dd;
			end
		if(!resetn)
		begin
			t3xx <= 8'd21;
			t3yy <= 7'd109;
			t3dd <= 2'd0;
			end
		else if(ld_t3 == 1'b1)
		begin
			t3xx <= t3xtmp;
			t3yy <= t3ytmp;
			t3dd <= t3d;
			end
		else
		begin
			t3xx <= t3xx;
			t3yy <= t3yy;
			t3dd <= t3dd;
			end
		if(!resetn)
		begin
			t4xx <= 8'd129;
			t4yy <= 7'd109;
			t4dd <= 2'd0;
			end
		else if(ld_t4 == 1'b1)
		begin
			t4xx <= t4xtmp;
			t4yy <= t4ytmp;
			t4dd <= t4d;
			end
		else
		begin
			t4xx <= t4xx;
			t4yy <= t4yy;
			t4dd <= t4dd;
			end
		if(load_b1 == 1'b1)
		begin
			b1xx <= b1xtmp;
			b1yy <= b1ytmp;
			b1dd <= b1d;
			end
		else
		begin
			b1xx <= b1xx;
			b1yy <= b1yy;
			b1dd <= b1dd;
			end
		if(load_b2 == 1'b1)
		begin
			b2xx <= b2xtmp;
			b2yy <= b2ytmp;
			b2dd <= b2d;
			end
		else
		begin
			b2xx <= b2xx;
			b2yy <= b2yy;
			b2dd <= b2dd;
			end
		if(load_b3 == 1'b1)
		begin
			b3xx <= b3xtmp;
			b3yy <= b3ytmp;
			b3dd <= b3d;
			end
		else
		begin
			b3xx <= b3xx;
			b3yy <= b3yy;
			b3dd <= b3dd;
			end
		if(load_b4 == 1'b1)
		begin
			b4xx <= b4xtmp;
			b4yy <= b4ytmp;
			b4dd <= b4d;
			end
		else
		begin
			b4xx <= b4xx;
			b4yy <= b4yy;
			b4dd <= b4dd;
			end
	end

	localparam  	
					MENU_DRAW       = 5'd0,
					MENU_WAIT       = 5'd1,
					MENU_ERASE      = 5'd2,
					ERASE           = 5'd3,
					BOUND           = 5'd31,
					MAP             = 5'd4,
					TANK1_ERASE     = 5'd5,
					TANK1_DRAW      = 5'd6,
					TANK2_ERASE     = 5'd7,
					TANK2_DRAW	    = 5'd8,
					TANK3_ERASE     = 5'd9,
					TANK3_DRAW		= 5'd10,
					TANK4_ERASE		= 5'd11,
					TANK4_DRAW		= 5'd12,
					BU1_ERASE		= 5'd13,
					BU1_DRAW		= 5'd14,
					BU2_ERASE		= 5'd15,
					BU2_DRAW		= 5'd16,
					BU3_ERASE		= 5'd17,
					BU3_DRAW		= 5'd18,
					BU4_ERASE		= 5'd19,
					BU4_DRAW		= 5'd20,
					T1_SCORE_DRAW   = 5'd21,
					T1_SCORE_ERASE  = 5'd22,
					T2_SCORE_DRAW   = 5'd23,
					T2_SCORE_ERASE  = 5'd24,
					T3_SCORE_DRAW   = 5'd25,
					T3_SCORE_ERASE  = 5'd26,
					T4_SCORE_DRAW   = 5'd27,
					T4_SCORE_ERASE  = 5'd28,
					WALL_CHECK      = 5'd29,
					WALL_ERASE      = 5'd30;
					
		
		always@(*)
		begin: state_table 
				case (current_state)
					ERASE: next_state = menu_finish ? MENU_DRAW : ERASE;
					MENU_DRAW: next_state = menu_finish ? MENU_WAIT : MENU_DRAW;
					MENU_WAIT: next_state = start ? MENU_ERASE : MENU_WAIT;
					MENU_ERASE: next_state = menu_finish ? BOUND : MENU_ERASE;
					BOUND: next_state = menu_finish ? MAP : BOUND;
					MAP: next_state = map_finish ? TANK1_ERASE : MAP;
					TANK1_ERASE: next_state = finish ? TANK1_DRAW : TANK1_ERASE; 
					TANK1_DRAW: next_state = finish ? TANK2_ERASE : TANK1_DRAW; 
					TANK2_ERASE: next_state = finish ? TANK2_DRAW : TANK2_ERASE; 
					TANK2_DRAW: next_state = finish ? TANK3_ERASE : TANK2_DRAW; 
					TANK3_ERASE: next_state = finish ? TANK3_DRAW : TANK3_ERASE; 
					TANK3_DRAW: next_state = finish ? TANK4_ERASE : TANK3_DRAW; 
					TANK4_ERASE: next_state = finish ? TANK4_DRAW : TANK4_ERASE; 
					TANK4_DRAW: next_state = finish ? BU1_ERASE : TANK4_DRAW; 
					BU1_ERASE: next_state = BU1_DRAW;
					BU1_DRAW: next_state = BU2_ERASE;
					BU2_ERASE: next_state = BU2_DRAW;
					BU2_DRAW: next_state = BU3_ERASE;
					BU3_ERASE: next_state = BU3_DRAW;
					BU3_DRAW: next_state = BU4_ERASE;
					BU4_ERASE: next_state = BU4_DRAW;
					BU4_DRAW: next_state = 	T1_SCORE_ERASE;
					T1_SCORE_ERASE: next_state = score_finish ? T1_SCORE_DRAW : T1_SCORE_ERASE;
					T1_SCORE_DRAW: next_state = score_finish ? T2_SCORE_ERASE : T1_SCORE_DRAW;
					T2_SCORE_ERASE: next_state = score_finish ? T2_SCORE_DRAW : T2_SCORE_ERASE;
					T2_SCORE_DRAW: next_state = score_finish ? T3_SCORE_ERASE : T2_SCORE_DRAW;
					T3_SCORE_ERASE: next_state = score_finish ? T3_SCORE_DRAW : T3_SCORE_ERASE;
					T3_SCORE_DRAW: next_state = score_finish ? T4_SCORE_ERASE : T3_SCORE_DRAW;
					T4_SCORE_ERASE: next_state = score_finish ? T4_SCORE_DRAW : T4_SCORE_ERASE;
					T4_SCORE_DRAW: next_state = score_finish ? WALL_CHECK : T4_SCORE_DRAW;
					WALL_CHECK: next_state = (wall_destroyed == 8'b11011101) ? TANK1_ERASE : WALL_ERASE;
					WALL_ERASE: next_state = erase_wall_finish ? TANK1_ERASE : WALL_ERASE;
			endcase
		end 
		
		// current_state registers
		always@(posedge clk)
		begin: state_FFs
			if(!resetn)
				current_state <= ERASE;
			else
				current_state <= next_state;
		end // state_FFS
		
		always @(*)
		begin: output_logic
			map_counter_enable = 1'b0;
			counter_enable = 1'b0;
			erase_wall_enable = 1'b0;
			score_enable = 1'b0;
			object = 5'd0;
			colour = 3'd0;
			load_t1 = 1'b0;
			load_t2 = 1'b0;
			load_t3 = 1'b0;
			load_t4 = 1'b0;
			load_b1 = 1'b0;
			load_b2 = 1'b0;
			load_b3 = 1'b0;
			load_b4 = 1'b0;
			menu_enable = 1'b0;
			erase = 1'b0;
			bound = 1'b0;
			tank_num = 2'd0;
			case (current_state)
				ERASE: begin // Erase
					menu_enable = 1'b1;
					object = 5'b10000;
					colour = 3'd0;
					erase = 1'b1;
					end
				MENU_DRAW: begin // Draw the menu
					menu_enable = 1'b1;
					object = 5'b10000;
					colour = 3'b111;
					end
				MENU_ERASE: begin // Erase the menu
					menu_enable = 1'b1;
					object = 5'b10000;
					colour = 3'd0;
					erase = 1'b1;
					end
				BOUND: begin // 
					menu_enable = 1'b1;
					object = 5'b10000;
					colour = 3'b111;
					bound = 1'b1;
					end
				MAP: begin // draw the map
					map_counter_enable = 1'b1;
					object = 5'd8;
					colour = 3'b111;
					end
				TANK1_ERASE: begin // erase tank 1
					counter_enable = 1'b1;
					load_t1 = 1'b1;
					object = 5'd0;
					colour = 3'd0;
					end
				TANK1_DRAW: begin // draw tank 1 in its new position
					counter_enable = 1'b1;
					object = 5'd0;
					colour = 3'd1;
					end
				TANK2_ERASE: begin
					counter_enable = 1'b1;
					load_t2 = 1'b1;
					object = 5'd1;
					colour = 3'd0;
					end
				TANK2_DRAW: begin
					counter_enable = 1'b1;
					object = 5'd1;
					colour = 3'd2;
					end
				TANK3_ERASE: begin
					counter_enable = 1'b1;
					load_t3 = 1'b1;
					object = 5'd2;
					colour = 3'd0;
					end
				TANK3_DRAW: begin
					counter_enable = 1'b1;
					object = 5'd2;
					colour = 3'd3;
					end
				TANK4_ERASE: begin
					counter_enable = 1'b1;
					load_t4 = 1'b1;
					object = 5'd3;
					colour = 3'd0;
					end
				TANK4_DRAW: begin
					counter_enable = 1'b1;
					object = 5'd3;
					colour = 3'd4;
					end
				BU1_ERASE: begin // erase bullet
					load_b1 = 1'b1;
					object = 5'd4;
					colour = 3'd0;
					end
				BU1_DRAW: begin // draw bullet in the new position
					object = 5'd4;
					colour = 3'd1;
					end
				BU2_ERASE: begin
					load_b2 = 1'b1;
					object = 5'd5;
					colour = 3'd0;
					end
				BU2_DRAW: begin
					object = 5'd5;
					colour = 3'd2;
					end
				BU3_ERASE: begin
					load_b3 = 1'b1;
					object = 5'd6;
					colour = 3'd0;
					end
				BU3_DRAW: begin
					object = 5'd6;
					colour = 3'd3;
					end
				BU4_ERASE: begin
					load_b4 = 1'b1;
					object = 5'd7;
					colour = 3'd0;
					end
				BU4_DRAW: begin
					object = 5'd7;
					colour = 3'd4;
					end
				T1_SCORE_ERASE: begin // erase the score
					score_enable = 1'b1;
					tank_num = 2'd0;
					erase = 1'b1;
					object = 5'b11000;
					colour = 3'd0;
					end
				T1_SCORE_DRAW: begin // draw the updated score (can be unchanged)
					score_enable = 1'b1;
					tank_num = 2'd0;
					object = 5'b11000;
					colour = 3'd1;
					end
				T2_SCORE_ERASE: begin
					score_enable = 1'b1;
					tank_num = 2'd1;
					erase = 1'b1;
					object = 5'b11000;
					colour = 3'd0;
					end
				T2_SCORE_DRAW: begin
					score_enable = 1'b1;
					tank_num = 2'd1;
					object = 5'b11000;
					colour = 3'd2;
					end
				T3_SCORE_ERASE: begin
					score_enable = 1'b1;
					tank_num = 2'd2;
					erase = 1'b1;
					object = 5'b11000;
					colour = 3'd0;
					end
				T3_SCORE_DRAW: begin
					score_enable = 1'b1;
					tank_num = 2'd2;
					object = 5'b11000;
					colour = 3'd3;
					end
				T4_SCORE_ERASE: begin
					score_enable = 1'b1;
					tank_num = 2'd3;
					erase = 1'b1;
					object = 5'b11000;
					colour = 3'd0;
					end
				T4_SCORE_DRAW: begin
					score_enable = 1'b1;
					tank_num = 2'd3;
					object = 5'b11000;
					colour = 3'd4;
					end
				WALL_ERASE: begin // erase the walls
					object = 5'b1100;
					colour = 3'd0;
					erase_wall_enable = 1'b1;
					end
			endcase
		end 
endmodule
