module control(clk,resetn,
	B1X,B2X,B3X,B4X,T1X,T2X,T3X,T4X,B1Y,B2Y,B3Y,B4Y,T1Y,T2Y,T3Y,T4Y,
	t1moving,t2moving,t3moving,t4moving,
	tdirection1,tdirection2,tdirection3,tdirection4,bdirection1,bdirection2,bdirection3,bdirection4,
	t11x,t12x,t11y,t12y,t21x,t22x,t21y,t22y,t31x,t32x,t31y,t32y,t41x,t42x,t41y,t42y,
	b1x,b2x,b3x,b4x,b1y,b2y,b3y,b4y,
	t1out,t2out,t3out,t4out,
	t1outcur,t2outcur,t3outcur,t4outcur,
	b1_out,b2_out,b3_out,b4_out);
	input clk,resetn;
	input [7:0] B1X,B2X,B3X,B4X,T1X,T2X,T3X,T4X;
	input [6:0] B1Y,B2Y,B3Y,B4Y,T1Y,T2Y,T3Y,T4Y;
	input t1moving,t2moving,t3moving,t4moving;
	input [2:0] tdirection1,tdirection2,tdirection3,tdirection4,bdirection1,bdirection2,bdirection3,bdirection4;
	input [3:0] t11x,t12x,t11y,t12y,t21x,t22x,t21y,t22y,t31x,t32x,t31y,t32y,t41x,t42x,t41y,t42y,b1x,b2x,b3x,b4x,b1y,b2y,b3y,b4y;
	output [2:0] t1out,t2out,t3out,t4out;
	output reg [1:0] t1outcur,t2outcur,t3outcur,t4outcur;
	output reg b1_out,b2_out,b3_out,b4_out;
	wire [3:0] txu,txd,txl,txr,tyu,tyd,tyl,tyr,bxu,bxd,bxl,bxr,byu,byd,byl,byr;
	wire upmost,downmost,leftmost,rightmost,bupmost,bdownmost,bleftmost,brightmost,totherup,totherdown,totherleft,totherright,finish;
	wire cango,t1move,t2move,t3move,t4move;
	wire tdes1,tdes2,tdes3,tdes4,tdes,mapout;
	reg [3:0] tx,ty,txw,tyw,bx,by,bxw,byw;
	reg [7:0] BX;
	reg [6:0] BY;
	wire [7:0] BXM9,BXP1;
	wire [6:0] BYM9,BYP1;
	reg [7:0] address;
	reg check_t1,check_t2,check_t3,check_t4;
	reg wren,dataselect,most,bmost,tother,counter_enable,data;
	reg [1:0] addselect;
	reg [2:0] tdirection,bdirection;
	reg [1:0] tank_num,bullet_num;
	reg [5:0] current_state,next_state;
	reg [7:0] counter_output;
	wire q;
	
	ram256x1 (
	address,
	clk,
	data,
	wren,
	q);
	
	assign tdes1 = (BYM9<T1Y)&(BYP1>T1Y)&(BXM9<T1X)&(BXP1>T1X)&~(bullet_num==2'd0);
	assign tdes2 = (BYM9<T2Y)&(BYP1>T2Y)&(BXM9<T2X)&(BXP1>T2X)&~(bullet_num==2'd1);
	assign tdes3 = (BYM9<T3Y)&(BYP1>T3Y)&(BXM9<T3X)&(BXP1>T3X)&~(bullet_num==2'd2);
	assign tdes4 = (BYM9<T4Y)&(BYP1>T4Y)&(BXM9<T4X)&(BXP1>T4X)&~(bullet_num==2'd3);
	assign tdes = tdes1|tdes2|tdes3|tdes4;
	assign BXM9 = BX-4'd9;
	assign BXP1 = BX+1'b1;
	assign BYM9 = BY-4'd9;
	assign BYP1 = BY+1'b1;
	assign t1out = {t1move,tdirection[1:0]};
	assign t2out = {t2move,tdirection[1:0]};
	assign t3out = {t3move,tdirection[1:0]};
	assign t4out = {t4move,tdirection[1:0]};
	assign t1move = check_t1 & cango;
	assign t2move = check_t2 & cango;
	assign t3move = check_t3 & cango;
	assign t4move = check_t4 & cango;
	assign cango = ~(most | q | tother);
	assign txu = tx;
	assign tyu = ty-1'd1;
	assign txd = tx;
	assign tyd = ty+1'd1;
	assign txl = tx-1'd1;
	assign tyl = ty;
	assign txr = tx+1'd1;
	assign tyr = ty;
	assign bxu = bx;
	assign byu = by-1'd1;
	assign bxd = bx;
	assign byd = by+1'd1;
	assign bxl = bx-1'd1;
	assign byl = by;
	assign bxr = bx+1'd1;
	assign byr = by;
	assign upmost = (ty == 4'd0) ? 1'b1 : 1'b0;
	assign downmost = (ty == 4'd12) ? 1'b1 : 1'b0;
	assign leftmost = (tx == 4'd0) ? 1'b1 : 1'b0;
	assign rightmost = (tx == 4'd12) ? 1'b1 : 1'b0;
	assign bupmost = (ty == 4'd0) ? 1'b1 : 1'b0;
	assign bdownmost = (ty == 4'd12) ? 1'b1 : 1'b0;
	assign bleftmost = (tx == 4'd0) ? 1'b1 : 1'b0;
	assign brightmost = (tx == 4'd12) ? 1'b1 : 1'b0;
	assign totherup = (txu==t11x)&(tyu==t11y)|(txu==t12x)&(tyu==t12y)|(txu==t21x)&(tyu==t21y)|(txu==t22x)&(tyu==t22y)|(txu==t31x)&(tyu==t31y)|(txu==t32x)&(tyu==t32y) |(txu==t41x)&(tyu==t41y)|(txu==t42x)&(tyu==t42y);
	assign totherdown = (txd==t11x)&(tyd==t11y)|(txd==t12x)&(tyd==t12y)|(txd==t21x)&(tyd==t21y)|(txd==t22x)&(tyd==t22y)|(txd==t31x)&(tyd==t31y)|(txd==t32x)&(tyd==t32y) |(txd==t41x)&(tyd==t41y)|(txd==t42x)&(tyd==t42y);
	assign totherleft = (txl==t11x)&(tyl==t11y)|(txl==t12x)&(tyl==t12y)|(txl==t21x)&(tyl==t21y)|(txl==t22x)&(tyl==t22y)|(txl==t31x)&(tyl==t31y)|(txl==t32x)&(tyl==t32y) |(txl==t41x)&(tyl==t41y)|(txl==t42x)&(tyl==t42y);
	assign totherright = (txr==t11x)&(tyr==t11y)|(txr==t12x)&(tyr==t12y)|(txr==t21x)&(tyr==t21y)|(txr==t22x)&(tyr==t22y)|(txr==t31x)&(tyr==t31y)|(txr==t32x)&(tyr==t32y) |(txr==t41x)&(tyr==t41y)|(txr==t42x)&(tyr==t42y);
	
	always @(posedge clk)
	begin
		if(!resetn) 
			t1outcur <= 2'd0;
		else if(check_t1 == 1'b1)
			t1outcur <= tdirection[1:0];
		else
			t1outcur <= t1outcur;
	end
	
	always @(posedge clk)
	begin
		if(!resetn) 
			t2outcur <= 2'd0;
		else if(check_t2 == 1'b1)
			t2outcur <= tdirection[1:0];
		else
			t2outcur <= t2outcur;
	end
	
	always @(posedge clk)
	begin
		if(!resetn) 
			t3outcur <= 2'd0;
		else if(check_t3 == 1'b1)
			t3outcur <= tdirection[1:0];
		else
			t3outcur <= t3outcur;
	end
	
	always @(posedge clk)
	begin
		if(!resetn) 
			t4outcur <= 2'd0;
		else if(check_t4 == 1'b1)
			t4outcur <= tdirection[1:0];
		else
			t4outcur <= t4outcur;
	end
	
	always @(posedge clk)
	begin: counter
		if(!resetn)
			counter_output <= 8'd0;
		else if(counter_output == 8'b11111111)
			counter_output <= 8'd0;
		else if(counter_enable == 1'b1)
			counter_output <= counter_output + 1'b1;
		else 
			counter_output <= counter_output;
	end
	
	
	assign finish = &counter_output;
	map(counter_output,mapout);
	
	always @(*)
	begin
		case(dataselect)
			1'b0: data = 1'b0;
			1'b1: data = mapout;
		endcase
	end
	
	always @(*)
	begin
		case(tdirection[1:0])
			2'd0: tother = totherup;
			2'd1: tother = totherdown;
			2'd2: tother = totherleft;
			2'd3: tother = totherright;
		endcase
	end
	
	always @(*)
	begin
		case(tdirection[1:0])
			2'd0: most = upmost;
			2'd1: most = downmost;
			2'd2: most = leftmost;
			2'd3: most = rightmost;
		endcase
	end
		
	always @(*)
	begin
		case(addselect)
			2'd0: address = {txw,tyw};
			2'd1: address = {bxw,byw};
			2'd2: address = counter_output;
		endcase
	end
	
	always @(*)
	begin
		case(tdirection[1:0])
			2'd0: begin 
					txw = txu;
					tyw = tyu;
					end
			2'd1: begin 
					txw = txd;
					tyw = tyd;
					end
			2'd2: begin 
					txw = txl;
					tyw = tyl;
					end
			2'd3: begin 
					txw = txr;
					tyw = tyr;
					end
		endcase
	end
	
	always @(*)
	begin
		case(bdirection[1:0])
			2'd0: begin 
					bxw = bxu;
					byw = byu;
					bmost = bupmost;
					end
			2'd1: begin 
					bxw = bxd;
					byw = byd;
					bmost = bdownmost;
					end
			2'd2: begin 
					bxw = bxl;
					byw = byl;
					bmost = bleftmost;
					end
			2'd3: begin 
					bxw = bxr;
					byw = byr;
					bmost = brightmost;
					end
		endcase
	end
		
	always @(*)
	begin
		case(tank_num)
			2'd0: begin
					tx = t11x;
					ty = t11y;
					tdirection = tdirection1;
					end
			2'd1: begin
					tx = t21x;
					ty = t21y;
					tdirection = tdirection2;
					end
			2'd2: begin
					tx = t31x;
					ty = t31y;
					tdirection = tdirection3;
					end
			2'd3: begin
					tx = t41x;
					ty = t41y;
					tdirection = tdirection4;
					end
		endcase
	end
	
	always @(*)
	begin
		case(bullet_num)
			2'd0: begin
					bx = b1x;
					by = b1y;
					bdirection = bdirection1;
					BX = B1X;
					BY = B1Y;
					end
			2'd1: begin
					bx = b2x;
					by = b2y;
					bdirection = bdirection2;
					BX = B2X;
					BY = B2Y;
					end
			2'd2: begin
					bx = b3x;
					by = b3y;
					bdirection = bdirection3;
					BX = B3X;
					BY = B3Y;
					end
			2'd3: begin
					bx = b4x;
					by = b4y;
					bdirection = bdirection4;
					BX = B4X;
					BY = B4Y;
					end
		endcase
	end
	
	
	localparam  
				SETMAP = 6'd0,
				T1_WAIT = 6'd1,
				T1_CHECK = 6'd2,
				T2_WAIT = 6'd3,
				T2_CHECK = 6'd4,
				T3_WAIT=6'd5,
				T3_CHECK = 6'd6,
				T4_WAIT=6'd7,
				T4_CHECK = 6'd8;
//				B1_WAIT=6'd20,
//				B1_CHECK=6'd21,
//				B1_DESTROY=6'd22,
//				B1_READY=6'd23,
//				B2_WAIT=6'd24,
//				B2_CHECK=6'd25,
//				B2_DESTROY=6'd26,
//				B2_READY=6'd27,
//				B3_WAIT=6'd28,
//				B3_CHECK=6'd29,
//				B3_DESTROY=6'd30,
//				B3_READY=6'd31,
//				B4_WAIT=6'd32,
//				B4_CHECK=6'd33,
//				B4_DESTROY=6'd34,
//				B4_READY=6'd35;
				
				
	
	always@(*)
    begin: state_table 
            case (current_state)
				SETMAP: next_state = finish ? T1_WAIT : SETMAP;
				T1_WAIT: next_state = ((tdirection1[2]==1'b0) | (t1moving==1'b1)) ? T2_WAIT : T1_CHECK;
				T2_WAIT: next_state = ((tdirection2[2]==1'b0) | (t2moving==1'b1)) ? T3_WAIT : T2_CHECK;
				T3_WAIT: next_state = ((tdirection3[2]==1'b0) | (t3moving==1'b1)) ? T4_WAIT : T3_CHECK;
				T4_WAIT: next_state = ((tdirection4[2]==1'b0) | (t4moving==1'b1)) ? T1_WAIT : T4_CHECK;
				T1_CHECK: next_state = T2_WAIT;
				T2_CHECK: next_state = T3_WAIT;
				T3_CHECK: next_state = T4_WAIT;
				T4_CHECK: next_state = T1_WAIT;
//				B1_WAIT: begin
//							if(bdirection[2] == 1'b0)
//								next_state = B2_WAIT;	
//							else
//								next_state = B1_CHECK;
//						end
//				B1_CHECK: begin
//							if(q == 1'b1)
//								next_state = B1_DESTROY;
//							else if(tdes == 1'b1 | bmost == 1'b1)
//								next_state = B1_READY;
//							else
//								next_state = B2_WAIT;
//							end
//				B1_DESTROY: next_state = B1_READY;
//				B1_READY: next_state = B2_WAIT;
//				B2_WAIT: begin
//							if(bdirection[2] == 1'b0)
//								next_state = B3_WAIT;	
//							else
//								next_state = B2_CHECK;
//						end
//				B2_CHECK: begin
//							if(q == 1'b1)
//								next_state = B2_DESTROY;
//							else if(tdes == 1'b1 | bmost == 1'b1)
//								next_state = B2_READY;
//							else
//								next_state = B3_WAIT;
//							end
//				B2_DESTROY: next_state = B2_READY;
//				B2_READY: next_state = B3_WAIT;
//				B3_WAIT: begin
//							if(bdirection[2] == 1'b0)
//								next_state = B4_WAIT;	
//							else
//								next_state = B3_CHECK;
//						end
//				B3_CHECK: begin
//							if(q == 1'b1)
//								next_state = B3_DESTROY;
//							else if(tdes == 1'b1 | bmost == 1'b1)
//								next_state = B3_READY;
//							else
//								next_state = B4_WAIT;
//							end
//				B3_DESTROY: next_state = B3_READY;
//				B3_READY: next_state = B4_WAIT;
//				B4_WAIT: begin
//							if(bdirection[2] == 1'b0)
//								next_state = T1_WAIT;	
//							else
//								next_state = B4_CHECK;
//						end
//				B4_CHECK: begin
//							if(q == 1'b1)
//								next_state = B4_DESTROY;
//							else if(tdes == 1'b1 | bmost == 1'b1)
//								next_state = B4_READY;
//							else
//								next_state = T1_WAIT;
//							end
//				B4_DESTROY: next_state = B4_READY;
//				B4_READY: next_state = T1_WAIT;
			endcase
    end 
	
	// current_state registers
    always@(posedge clk)
    begin: state_FFs
        if(!resetn)
            current_state <= SETMAP;
        else
            current_state <= next_state;
    end // state_FFS
	
	always @(*)
    begin: output_logic
		dataselect = 1'b0;
		wren = 1'b0;
		check_t1 = 1'b0;
		check_t2 = 1'b0;
		check_t3 = 1'b0;
		check_t4 = 1'b0;
		tank_num = 2'd0;
//		b1_out = 1'b0;
//		b2_out = 1'b0;
//		b3_out = 1'b0;
//		b4_out = 1'b0;
		counter_enable = 1'b0;
        case (current_state)
			SETMAP: begin
				addselect = 2'd2;
				dataselect = 1'b1;
				counter_enable = 1'b1;
				wren = 1'b1;
				end
            T1_WAIT: begin
                tank_num = 2'd0;
				addselect = 2'd0;
                end
            T1_CHECK: begin
                tank_num = 2'd0;
				addselect = 2'd0;
				check_t1 = 1'b1;
                end
			T2_WAIT: begin
                tank_num = 2'd1;
				addselect = 2'd0;
                end
            T2_CHECK: begin
                tank_num = 2'd1;
				addselect = 2'd0;
				check_t2 = 1'b1;
                end
			T3_WAIT: begin
                tank_num = 2'd2;
				addselect = 2'd0;
                end
            T3_CHECK: begin
                tank_num = 2'd2;
				addselect = 2'd0;
				check_t3 = 1'b1;
                end
			T4_WAIT: begin
                tank_num = 2'd3;
				addselect = 2'd0;
                end
            T4_CHECK: begin
                tank_num = 2'd3;
				addselect = 2'd0;
				check_t4 = 1'b1;
                end
//			B1_WAIT: begin
//				bullet_num = 2'd0;
//				addselect = 2'd1;
//				end
//			B1_CHECK: begin
//				bullet_num = 2'd0;
//				addselect = 2'd1;
//				end
//			B1_DESTROY: begin
//				bullet_num = 2'd0;
//				addselect = 2'd1;
//				wren = 1'b1;
//				dataselect = 1'b0;
//				end
//			B1_READY: begin
//				bullet_num = 2'd0;
//				addselect = 2'd1;
//				b1_out = 1'b1;
//				end
//			B2_WAIT: begin
//				bullet_num = 2'd1;
//				addselect = 2'd1;
//				end
//			B2_CHECK: begin
//				bullet_num = 2'd1;
//				addselect = 2'd1;
//				end
//			B2_DESTROY: begin
//				bullet_num = 2'd1;
//				addselect = 2'd1;
//				wren = 1'b1;
//				dataselect = 1'b0;
//				end
//			B2_READY: begin
//				bullet_num = 2'd1;
//				addselect = 2'd1;
//				b2_out = 1'b1;
//				end
//			B3_WAIT: begin
//				bullet_num = 2'd2;
//				addselect = 2'd1;
//				end
//			B3_CHECK: begin
//				bullet_num = 2'd2;
//				addselect = 2'd1;
//				end
//			B3_DESTROY: begin
//				bullet_num = 2'd2;
//				addselect = 2'd1;
//				wren = 1'b1;
//				dataselect = 1'b0;
//				end
//			B3_READY: begin
//				bullet_num = 2'd2;
//				addselect = 2'd1;
//				b3_out = 1'b1;
//				end
//			B4_WAIT: begin
//				bullet_num = 2'd3;
//				addselect = 2'd1;
//				end
//			B4_CHECK: begin
//				bullet_num = 2'd3;
//				addselect = 2'd1;
//				end
//			B4_DESTROY: begin
//				bullet_num = 2'd3;
//				addselect = 2'd1;
//				wren = 1'b1;
//				dataselect = 1'b0;
//				end
//			B4_READY: begin
//				bullet_num = 2'd3;
//				addselect = 2'd1;
//				b4_out = 1'b1;
//				end
        endcase
    end 
endmodule
