//keyboard module modified from https://www.stepfpga.com/doc/ps2%E9%94%AE%E7%9B%98%E6%A8%A1%E5%9D%97. 
//This module is initially only capable for at most one key being pressed at a time. We modified it to be capable for multiple keys to adapt our need. Also, we assigned keys to direction and fire signals.
module Keyboard_PS2
(
input					clk_in,			
input					rst_n_in,			
input					key_clk,			
input					key_data,			
output	reg	[19:0]		out			
		
);
 

 
reg		key_clk_r0 = 1'b1,key_clk_r1 = 1'b1; 
reg		key_data_r0 = 1'b1,key_data_r1 = 1'b1;
reg 		key_break; 
always @ (posedge clk_in) begin
	if(!rst_n_in) begin
		key_clk_r0 <= 1'b1;
		key_clk_r1 <= 1'b1;
		key_data_r0 <= 1'b1;
		key_data_r1 <= 1'b1;
	end else begin
		key_clk_r0 <= key_clk;
		key_clk_r1 <= key_clk_r0;
		key_data_r0 <= key_data;
		key_data_r1 <= key_data_r0;
	end
end
 

wire	key_clk_neg = key_clk_r1 & (~key_clk_r0); 
 
reg				[3:0]	cnt; 
reg				[7:0]	temp_data;

always @ (posedge clk_in) begin
	if(!rst_n_in) begin
		cnt <= 4'd0;
		temp_data <= 8'd0;
	end else if(key_clk_neg) begin 
		if(cnt >= 4'd10) cnt <= 4'd0;
		else cnt <= cnt + 1'b1;
		case (cnt)
			4'd0: ;			
			4'd1: temp_data[0] <= key_data_r1;  
			4'd2: temp_data[1] <= key_data_r1;  
			4'd3: temp_data[2] <= key_data_r1; 
			4'd4: temp_data[3] <= key_data_r1; 
			4'd5: temp_data[4] <= key_data_r1; 
			4'd6: temp_data[5] <= key_data_r1;  
			4'd7: temp_data[6] <= key_data_r1;  
			4'd8: temp_data[7] <= key_data_r1;  
			4'd9: ;			
			4'd10:;			
			default: ;
		endcase
	end
end
 
localparam  TANK1_UP = 8'h1D, // W
				TANK1_DOWN = 8'h1B, // S
				TANK1_LEFT = 8'h1C, // A
				TANK1_RIGHT = 8'h23, // D
				TANK1_FIRE = 8'h11, // left ALT
	            TANK2_UP = 8'h35, // Y
				TANK2_DOWN = 8'h33, // H
				TANK2_LEFT = 8'h34, // G
				TANK2_RIGHT = 8'h3B, //J
				TANK2_FIRE = 8'h29, // SPACE
				TANK3_UP = 8'h75, // UP
				TANK3_DOWN = 8'h72, // DOWN
				TANK3_LEFT = 8'h6B, // LEFT
				TANK3_RIGHT = 8'h74, // RIGHT
				TANK3_FIRE = 8'h70, // 0
				TANK4_UP = 8'h4D, // P
				TANK4_DOWN = 8'h4C, // ;
				TANK4_LEFT = 8'h4B, // L
				TANK4_RIGHT = 8'h52, // '
				TANK4_FIRE = 8'h14; // right CTRL  

always @ (posedge clk_in) begin 
	if(!rst_n_in) begin
		key_break <= 1'b0;
	end else if(cnt==4'd10 && key_clk_neg) begin 
		if(temp_data == 8'hf0) key_break <= 1'b1;	
		else key_break <= 1'b0; 	
			case(temp_data)
				TANK1_UP: out[0] <= ~key_break;
				TANK1_DOWN: out[1] <= ~key_break;
				TANK1_LEFT : out[2] <= ~key_break;
				TANK1_RIGHT: out[3] <= ~key_break;
				TANK2_UP: out[4] <= ~key_break;
				TANK2_DOWN: out[5] <= ~key_break;
				TANK2_LEFT: out[6] <= ~key_break;
				TANK2_RIGHT: out[7] <= ~key_break;
				TANK3_UP: out[8] <= ~key_break;
				TANK3_DOWN: out[9] <= ~key_break;
				TANK3_LEFT: out[10] <= ~key_break;
				TANK3_RIGHT: out[11] <= ~key_break;
				TANK4_UP: out[12] <= ~key_break;
				TANK4_DOWN: out[13] <= ~key_break;
				TANK4_LEFT: out[14] <= ~key_break;
				TANK4_RIGHT: out[15] <= ~key_break;
				TANK1_FIRE: out[16] <= ~key_break;
				TANK2_FIRE: out[17] <= ~key_break;
				TANK3_FIRE: out[18] <= ~key_break;
				TANK4_FIRE: out[19] <= ~key_break;
				default: ;
			endcase	
	end
end
 

 
endmodule