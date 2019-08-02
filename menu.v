//The VGA text generator is quoted from previous poject "pong++" from CSCB58's website, project section. The original author of this VGA text generator is: https://github.com/Derek-X-Wang/VGA-Text-Generator
module menu(clk,erase,bound,menu_enable,winner,finish,plot,x,y);
	input clk,erase,bound,menu_enable;
	input [2:0] winner;
	output finish;
	output reg plot;
	output [7:0] x;
	output [6:0] y;
	reg [14:0] counter;
	wire [8:0] textSelect;
	wire bound_plot;
	reg winner_plot;
	
	assign finish = &counter;
	assign x = counter[14:7];
	assign y = counter[6:0];
	assign bound_plot = ((y==7'd0)|(y==7'd118))&(x>8'd19)&(x<8'd139) | ((x==8'd20)|(x==8'd138))&(y>7'd0)&(y<7'd118);
	
	always @(*)
	begin
		if(erase)
			plot = 1'b1;
		else if(bound)
			plot = bound_plot;
		else if(!winner[2])
			plot = textSelect[0]|textSelect[6]|textSelect[1];
		else
			plot = winner_plot | textSelect[1] | textSelect[6] | textSelect[7] | textSelect[8];
	end
	
	always @(*)
	begin
		case(winner)
		3'd0: winner_plot = 1'b0;
		3'b100: winner_plot = textSelect[2];
		3'b101: winner_plot = textSelect[3];
		3'b110: winner_plot = textSelect[4];
		3'b111: winner_plot = textSelect[5];
		default: winner_plot = 1'b0;
		endcase
	end
	
	always @(posedge clk)
	begin
		if(!menu_enable)
			counter <= 15'd0;
		else if(counter == 15'b111111111111111)
			counter <= 15'd0;
		else
			counter <= counter + 1'b1;
	end
	
	Pixel_On_Text2 #(.displayText("TANK BATTLE")) t1(
		 clk,
		 37, 
		 20, 
		 x, 
		 y, 
		 textSelect[0]  
	);	
	
	Pixel_On_Text2 #(.displayText("KEY0 START")) t2(
		 clk,
		 40, 
		 70, 
		 x, 
		 y, 
		 textSelect[1]  
	);
	
	Pixel_On_Text2 #(.displayText("PLAYER 1 WINS")) t3(
		 clk,
		 28, 
		 4, 
		 x, 
		 y, 
		 textSelect[2]  
	);
	
	Pixel_On_Text2 #(.displayText("PLAYER 2 WINS")) t4(
		 clk,
		 28, 
		 4, 
		 x, 
		 y, 
		 textSelect[3]  
	);
	
	Pixel_On_Text2 #(.displayText("PLAYER 3 WINS")) t5(
		 clk,
		 28, 
		 4, 
		 x, 
		 y, 
		 textSelect[4]  
	);
	
	Pixel_On_Text2 #(.displayText("PLAYER 4 WINS")) t6(
		 clk,
		 28, 
		 4, 
		 x, 
		 y, 
		 textSelect[5]  
	);
	
	Pixel_On_Text2 #(.displayText("SW1-0 MAP")) t7(
		 clk,
		 44, 
		 90, 
		 x, 
		 y, 
		 textSelect[6]  
	);
	
	Pixel_On_Text2 #(.displayText("WINNER WINNER")) t8(
		 clk,
		 28, 
		 24, 
		 x, 
		 y, 
		 textSelect[7]  
	);
	
	Pixel_On_Text2 #(.displayText("CHICKEN DINNER")) t9(
		 clk,
		 24, 
		 44, 
		 x, 
		 y, 
		 textSelect[8]  
	);
endmodule