module project
	(
		CLOCK_50,						//	On Board 50 MHz
		// Your inputs and outputs here
        KEY,
		// The ports below are for the VGA output.  Do not change.
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK_N,						//	VGA BLANK
		VGA_SYNC_N,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B,   						//	VGA Blue[9:0]
		PS2_KBCLK,
		PS2_KBDAT
	);
	input [3:0] KEY;
	input CLOCK_50,PS2_KBCLK,PS2_KBDAT;
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[9:0]	VGA_R;   				//	VGA Red[9:0]
	output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B;   				//	VGA Blue[9:0]
	
	wire resetn;
	wire [2:0] tdirection1,tdirection2,tdirection3,tdirection4,tdirection1o,tdirection2o,tdirection3o,tdirection4o;//bdirection1,bdirection2,bdirection3,bdirection4;
	wire [3:0] t11x,t12x,t11y,t12y,t21x,t22x,t21y,t22y,t31x,t32x,t31y,t32y,t41x,t42x,t41y,t42y;
	wire [6:0] t1y,t2y,t3y,t4y;//b1y,b2y,b3y,b4y;
	wire [7:0] t1x,t2x,t3x,t4x;//b1x,b2x,b3x,b4x;
	wire [1:0] t1d,t2d,t3d,t4d;
	wire [7:0] x;
	wire [6:0] y;
	wire [2:0] colour;
	wire [19:0] keyboard_output;
	wire plot;
	wire t1moving,t2moving,t3moving,t4moving;
	wire b1ready,b2ready,b3ready,b4ready;
	//wire t1e,t2e,t3e,t4e,b1e,b2e,b3e,b4e;
	
	assign resetn = KEY[0];
	
	Keyboard_PS2(
	.clk_in(CLOCK_50),				//系统时钟
	.rst_n_in(resetn),			//系统复位，低有效
	.key_clk(PS2_KBCLK),			//PS2键盘时钟输入
	.key_data(PS2_KBDAT),			//PS2键盘数据输入
	.out(keyboard_output));
	
	get_direction(keyboard_output[0],keyboard_output[1],keyboard_output[2],keyboard_output[3],tdirection1);
	get_direction(keyboard_output[4],keyboard_output[5],keyboard_output[6],keyboard_output[7],tdirection2);
	get_direction(keyboard_output[8],keyboard_output[9],keyboard_output[10],keyboard_output[11],tdirection3);
	get_direction(keyboard_output[12],keyboard_output[13],keyboard_output[14],keyboard_output[15],tdirection4);
	//assign tdirection1 = 3'b101;
	//assign tdirection2 = 3'b101;
	//assign tdirection3 = 3'b100;
	//assign tdirection4 = 3'b100;
	control(CLOCK_50,resetn,
	8'd0,8'd0,8'd0,8'd0,t1x,t2x,t3x,t4x,7'd0,7'd0,7'd0,7'd0,t1y,t2y,t3y,t4y,
	t1moving,t2moving,t3moving,t4moving,
	tdirection1,tdirection2,tdirection3,tdirection4,3'd0,3'd0,3'd0,3'd0,
	t11x,t12x,t11y,t12y,t21x,t22x,t21y,t22y,t31x,t32x,t31y,t32y,t41x,t42x,t41y,t42y,
	4'd0,4'd0,4'd0,4'd0,4'd0,4'd0,4'd0,4'd0,
	tdirection1o,tdirection2o,tdirection3o,tdirection4o,
	t1d,t2d,t3d,t4d,
	b1ready,b2ready,b3ready,b4ready);
	draw(CLOCK_50,resetn,t1y,t2y,t3y,t4y,7'd0,7'd0,7'd0,7'd0,t1x,t2x,t3x,t4x,8'd0,8'd0,8'd0,8'd0,1'b1,1'b1,1'b1,1'b1,1'b0,1'b0,1'b0,1'b0,t1d,t2d,t3d,t4d,x,y,colour,plot);
	
	tank tank1(
		.clk(CLOCK_50),
		.resetn(resetn),
		.initial_xpos(8'd21),
		.initial_ypos(7'd1),
		.initial_x(4'd0),
		.initial_y(4'd0),
		.direction(tdirection1o),
		.x(t11x),
		.x1(t12x),
		.y(t11y),
		.y1(t12y),
		.xpos(t1x),
		.ypos(t1y),
		.moving(t1moving));
	
	tank tank2(
		.clk(CLOCK_50),
		.resetn(resetn),
		.initial_xpos(8'd129),
		.initial_ypos(7'd1),
		.initial_x(4'd12),
		.initial_y(4'd0),
		.direction(tdirection2o),
		.x(t21x),
		.x1(t22x),
		.y(t21y),
		.y1(t22y),
		.xpos(t2x),
		.ypos(t2y),
		.moving(t2moving));
	
	tank tank3(
		.clk(CLOCK_50),
		.resetn(resetn),
		.initial_xpos(8'd21),
		.initial_ypos(7'd109),
		.initial_x(4'd0),
		.initial_y(4'd12),
		.direction(tdirection3o),
		.x(t31x),
		.x1(t32x),
		.y(t31y),
		.y1(t32y),
		.xpos(t3x),
		.ypos(t3y),
		.moving(t3moving));
	
	tank tank4(
		.clk(CLOCK_50),
		.resetn(resetn),
		.initial_xpos(8'd129),
		.initial_ypos(7'd109),
		.initial_x(4'd12),
		.initial_y(4'd12),
		.direction(tdirection4o),
		.x(t41x),
		.x1(t42x),
		.y(t41y),
		.y1(t42y),
		.xpos(t4x),
		.ypos(t4y),
		.moving(t4moving));
	
	vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(colour),
			.x(x),
			.y(y),
			.plot(plot),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "black.mif";
endmodule
