module draw(clk,resetn,t1y,t2y,t3y,t4y,b1y,b2y,b3y,b4y,t1x,t2x,t3x,t4x,b1x,b2x,b3x,b4x,t1e,t2e,t3e,t4e,b1e,b2e,b3e,b4e,t1d,t2d,t3d,t4d,x,y,colour,plot);
	input clk,resetn;
	input [6:0] t1y,t2y,t3y,t4y,b1y,b2y,b3y,b4y;
	input [7:0] t1x,t2x,t3x,t4x,b1x,b2x,b3x,b4x;
	input t1e,t2e,t3e,t4e,b1e,b2e,b3e,b4e;
	//if t1e = 1 then tank 1 exists.
	input [1:0] t1d,t2d,t3d,t4d;
	output reg [2:0] colour;
	output reg [6:0] y;
	output reg [7:0] x;
	output plot;
	wire finish,map_finish;
	wire [6:0] tyo,my;
	wire [7:0] txo,mx;
	reg [6:0] t1yy,t2yy,t3yy,t4yy,b1yy,b2yy,b3yy,b4yy;
	reg [7:0] t1xx,t2xx,t3xx,t4xx,b1xx,b2xx,b3xx,b4xx;
	reg [6:0] ty,by;
	reg [7:0] tx,bx;
	reg [1:0] direction;
	reg [1:0] t1dd,t2dd,t3dd,t4dd;
	reg [3:0] object;
	reg [4:0] current_state, next_state;
	reg map_counter_enable,counter_enable,load_t1,load_t2,load_t3,load_t4,load_b1,load_b2,load_b3,load_b4;
	wire ld_t1,ld_t2,ld_t3,ld_t4;
	
	draw_map(clk,resetn,map_counter_enable,map_finish,mx,my);
	draw_tank(tx,ty,clk,resetn,direction,counter_enable,finish,txo,tyo);
	
	assign ld_t1 = load_t1 & finish;
	assign ld_t2 = load_t2 & finish;
	assign ld_t3 = load_t3 & finish;
	assign ld_t4 = load_t4 & finish;
	assign plot = ~((object == 4'd0)&~load_t1&~t1e | (object == 4'd1)&~load_t2&~t2e | (object == 4'd2)&~load_t3&~t3e | (object == 4'd3)&~load_t4&~t4e | (object == 4'd4)&~load_b1&~b1e | (object == 4'd5)&~load_b2&~b2e | (object == 4'd6)&~load_b3&~b3e | (object == 4'd7)&~load_b4&~b4e);
	
	always @(*)
	begin
		case(object[3:2])
			2'b00: begin
					x = txo;
					y = tyo;
					end
			2'b01: begin
					x = bx;
					y = by;
					end
			2'b10: begin
					x = mx;
					y = my;
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
					end
			2'd1: begin
					tx = t2xx;
					ty = t2yy;
					direction = t2dd;
					bx = b2xx;
					by = b2yy;
					end
			2'd2: begin
					tx = t3xx;
					ty = t3yy;
					direction = t3dd;
					bx = b3xx;
					by = b3yy;
					end
			2'd3: begin
					tx = t4xx;
					ty = t4yy;
					direction = t4dd;
					bx = b4xx;
					by = b4yy;
					end
		endcase
	end

	always @(posedge clk)
	begin
		if(ld_t1 == 1'b1)
		begin
			t1xx <= t1x;
			t1yy <= t1y;
			t1dd <= t1d;
			end
		else
		begin
			t1xx <= t1xx;
			t1yy <= t1yy;
			t1dd <= t1dd;
			end
		if(ld_t2 == 1'b1)
		begin
			t2xx <= t2x;
			t2yy <= t2y;
			t2dd <= t2d;
			end
		else
		begin
			t2xx <= t2xx;
			t2yy <= t2yy;
			t2dd <= t2dd;
			end
		if(ld_t3 == 1'b1)
		begin
			t3xx <= t3x;
			t3yy <= t3y;
			t3dd <= t3d;
			end
		else
		begin
			t3xx <= t3xx;
			t3yy <= t3yy;
			t3dd <= t3dd;
			end
		if(ld_t4 == 1'b1)
		begin
			t4xx <= t4x;
			t4yy <= t4y;
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
			b1xx <= b1x;
			b1yy <= b1y;
			end
		else
		begin
			b1xx <= b1xx;
			b1yy <= b1yy;
			end
		if(load_b2 == 1'b1)
		begin
			b2xx <= b2x;
			b2yy <= b2y;
			end
		else
		begin
			b2xx <= b2xx;
			b2yy <= b2yy;
			end
		if(load_b3 == 1'b1)
		begin
			b3xx <= b3x;
			b3yy <= b3y;
			end
		else
		begin
			b3xx <= b3xx;
			b3yy <= b3yy;
			end
		if(load_b4 == 1'b1)
		begin
			b4xx <= b4x;
			b4yy <= b4y;
			end
		else
		begin
			b4xx <= b4xx;
			b4yy <= b4yy;
			end
	end

	localparam  	
					MAP             = 5'd0,
					TANK1_ERASE     = 5'd1,
					TANK1_DRAW      = 5'd2,
					TANK2_ERASE     = 5'd3,
					TANK2_DRAW	    = 5'd4,
					TANK3_ERASE     = 5'd5,
					TANK3_DRAW		= 5'd6,
					TANK4_ERASE		= 5'd7,
					TANK4_DRAW		= 5'd8,
					BU1_ERASE		= 5'd9,
					BU1_DRAW		= 5'd10,
					BU2_ERASE		= 5'd11,
					BU2_DRAW		= 5'd12,
					BU3_ERASE		= 5'd13,
					BU3_DRAW		= 5'd14,
					BU4_ERASE		= 5'd15,
					BU4_DRAW		= 5'd16;
					
		
		always@(*)
		begin: state_table 
				case (current_state)
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
					BU4_DRAW: next_state = 	TANK1_ERASE;
			endcase
		end 
		
		// current_state registers
		always@(posedge clk)
		begin: state_FFs
			if(!resetn)
				current_state <= MAP;
			else
				current_state <= next_state;
		end // state_FFS
		
		always @(*)
		begin: output_logic
			map_counter_enable = 1'b0;
			counter_enable = 1'b0;
			object = 4'd0;
			colour = 3'd0;
			load_t1 = 1'b0;
			load_t2 = 1'b0;
			load_t3 = 1'b0;
			load_t4 = 1'b0;
			load_b1 = 1'b0;
			load_b2 = 1'b0;
			load_b3 = 1'b0;
			load_b4 = 1'b0;
			case (current_state)
				MAP: begin
					map_counter_enable = 1'b1;
					object = 4'd8;
					colour = 3'b111;
					end
				TANK1_ERASE: begin
					counter_enable = 1'b1;
					load_t1 = 1'b1;
					object = 4'd0;
					colour = 3'd0;
					end
				TANK1_DRAW: begin
					counter_enable = 1'b1;
					object = 4'd0;
					colour = 3'd1;
					end
				TANK2_ERASE: begin
					counter_enable = 1'b1;
					load_t2 = 1'b1;
					object = 4'd1;
					colour = 3'd0;
					end
				TANK2_DRAW: begin
					counter_enable = 1'b1;
					object = 4'd1;
					colour = 3'd2;
					end
				TANK3_ERASE: begin
					counter_enable = 1'b1;
					load_t3 = 1'b1;
					object = 4'd2;
					colour = 3'd0;
					end
				TANK3_DRAW: begin
					counter_enable = 1'b1;
					object = 4'd2;
					colour = 3'd3;
					end
				TANK4_ERASE: begin
					counter_enable = 1'b1;
					load_t4 = 1'b1;
					object = 4'd3;
					colour = 3'd0;
					end
				TANK4_DRAW: begin
					counter_enable = 1'b1;
					object = 4'd3;
					colour = 3'd4;
					end
				BU1_ERASE: begin
					load_b1 = 1'b1;
					object = 4'd4;
					colour = 3'd0;
					end
				BU1_DRAW: begin
					object = 4'd4;
					colour = 3'd1;
					end
				BU2_ERASE: begin
					load_b2 = 1'b1;
					object = 4'd5;
					colour = 3'd0;
					end
				BU2_DRAW: begin
					object = 4'd5;
					colour = 3'd2;
					end
				BU3_ERASE: begin
					load_b3 = 1'b1;
					object = 4'd6;
					colour = 3'd0;
					end
				BU3_DRAW: begin
					object = 4'd6;
					colour = 3'd3;
					end
				BU4_ERASE: begin
					load_b4 = 1'b1;
					object = 4'd7;
					colour = 3'd0;
					end
				BU4_DRAW: begin
					object = 4'd7;
					colour = 3'd4;
					end
			endcase
		end 
endmodule