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
		PS2_KBCLK,                      //KEYBOARD CLOCK
		PS2_KBDAT,                       //KEYBOARD DATA
		SW
	);
	input [3:0] KEY;
	input [1:0] SW;
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
	wire [2:0] tdirection1,tdirection2,tdirection3,tdirection4,tdirection1o,tdirection2o,tdirection3o,tdirection4o;
	wire [6:0] t1y,t2y,t3y,t4y,b1y,b2y,b3y,b4y;
	wire [7:0] t1x,t2x,t3x,t4x,b1x,b2x,b3x,b4x;
	wire [1:0] t1d,t2d,t3d,t4d;
	wire [2:0] b1d,b2d,b3d,b4d;
	wire [7:0] x;
	wire [6:0] y;
	wire [2:0] winner;
	wire [2:0] colour;
	wire start;
	wire [19:0] keyboard_output;
	wire plot;
	wire t1moving,t2moving,t3moving,t4moving;
	wire b1ready,b2ready,b3ready,b4ready;
	wire t1_destoryed,t2_destoryed,t3_destoryed,t4_destoryed;
	wire [7:0] wall_destroyed;
	wire erase_finish;
	wire [2:0] t1score,t2score,t3score,t4score;
	wire [2:0] t1_moving_d,t2_moving_d,t3_moving_d,t4_moving_d;
	wire [1:0] mapselect;
	
	assign start = ~KEY[0];
	assign mapselect = SW[1:0];
	
	Keyboard_PS2(
	.clk_in(CLOCK_50),				
	.rst_n_in(resetn),			
	.key_clk(PS2_KBCLK),			
	.key_data(PS2_KBDAT),			
	.out(keyboard_output));
	
	get_direction(keyboard_output[0],keyboard_output[1],keyboard_output[2],keyboard_output[3],tdirection1);
	get_direction(keyboard_output[4],keyboard_output[5],keyboard_output[6],keyboard_output[7],tdirection2);
	get_direction(keyboard_output[8],keyboard_output[9],keyboard_output[10],keyboard_output[11],tdirection3);
	get_direction(keyboard_output[12],keyboard_output[13],keyboard_output[14],keyboard_output[15],tdirection4);
	control(CLOCK_50,resetn,
	b1x,b2x,b3x,b4x,t1x,t2x,t3x,t4x,b1y,b2y,b3y,b4y,t1y,t2y,t3y,t4y,
	t1moving,t2moving,t3moving,t4moving,
	tdirection1,tdirection2,tdirection3,tdirection4,b1d,b2d,b3d,b4d,
	tdirection1o,tdirection2o,tdirection3o,tdirection4o,
	t1d,t2d,t3d,t4d,
	b1ready,b2ready,b3ready,b4ready,
	t1_destoryed,t2_destoryed,t3_destoryed,t4_destoryed,
	wall_destroyed,erase_finish,winner,start,
	t1score,t2score,t3score,t4score,
	t1_moving_d,t2_moving_d,t3_moving_d,t4_moving_d,
	mapselect);
	
	draw(CLOCK_50,resetn,start,
	t1y,t2y,t3y,t4y,b1y,b2y,b3y,b4y,
	t1x,t2x,t3x,t4x,b1x,b2x,b3x,b4x,
	~t1_destoryed,~t2_destoryed,~t3_destoryed,~t4_destoryed,~t1_destoryed,~t2_destoryed,~t3_destoryed,~t4_destoryed,
	t1d,t2d,t3d,t4d,b1d,b2d,b3d,b4d,
	x,y,colour,plot,wall_destroyed,erase_finish,
	winner,t1score,t2score,t3score,t4score,
	mapselect);
	
	tank tank1(
		.clk(CLOCK_50),
		.resetn(resetn),
		.initial_xpos(8'd21),
		.initial_ypos(7'd1),
		.direction(tdirection1o),
		.xpos(t1x),
		.ypos(t1y),
		.moving(t1moving),
		.start(start),
		.moving_direction(t1_moving_d));
	
	tank tank2(
		.clk(CLOCK_50),
		.resetn(resetn),
		.initial_xpos(8'd129),
		.initial_ypos(7'd1),
		.direction(tdirection2o),
		.xpos(t2x),
		.ypos(t2y),
		.moving(t2moving),
		.start(start),
		.moving_direction(t2_moving_d));
	
	tank tank3(
		.clk(CLOCK_50),
		.resetn(resetn),
		.initial_xpos(8'd21),
		.initial_ypos(7'd109),
		.direction(tdirection3o),
		.xpos(t3x),
		.ypos(t3y),
		.moving(t3moving),
		.start(start),
		.moving_direction(t3_moving_d));
	
	tank tank4(
		.clk(CLOCK_50),
		.resetn(resetn),
		.initial_xpos(8'd129),
		.initial_ypos(7'd109),
		.direction(tdirection4o),
		.xpos(t4x),
		.ypos(t4y),
		.moving(t4moving),
		.start(start),
		.moving_direction(t4_moving_d));
	
	bullet bullet1(
	.clk(CLOCK_50),
	.resetn(resetn),
	.tx(t1x),
	.ty(t1y),
	.td(t1d),
	.ready(b1ready),
	.fire(keyboard_output[16]),
	.bx(b1x),
	.by(b1y),
	.bd(b1d),
	.start(start));
	
	bullet bullet2(
	.clk(CLOCK_50),
	.resetn(resetn),
	.tx(t2x),
	.ty(t2y),
	.td(t2d),
	.ready(b2ready),
	.fire(keyboard_output[17]),
	.bx(b2x),
	.by(b2y),
	.bd(b2d),
	.start(start));
	
	bullet bullet3(
	.clk(CLOCK_50),
	.resetn(resetn),
	.tx(t3x),
	.ty(t3y),
	.td(t3d),
	.ready(b3ready),
	.fire(keyboard_output[18]),
	.bx(b3x),
	.by(b3y),
	.bd(b3d),
	.start(start));
	
	bullet bullet4(
	.clk(CLOCK_50),
	.resetn(resetn),
	.tx(t4x),
	.ty(t4y),
	.td(t4d),
	.ready(b4ready),
	.fire(keyboard_output[19]),
	.bx(b4x),
	.by(b4y),
	.bd(b4d),
	.start(start));
	
	//VGA Adaptor provided by Professor Brian Harrington.
	vga_adapter VGA( // This VGA adoptor is from Professor Brian Harrington.
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