module control(clk,resetn,
	B1X,B2X,B3X,B4X,T1X,T2X,T3X,T4X,B1Y,B2Y,B3Y,B4Y,T1Y,T2Y,T3Y,T4Y,
	t1moving,t2moving,t3moving,t4moving,
	tdirection1,tdirection2,tdirection3,tdirection4,bdirection1,bdirection2,bdirection3,bdirection4,
	t1out,t2out,t3out,t4out,
	t1outcur,t2outcur,t3outcur,t4outcur,
	b1_out,b2_out,b3_out,b4_out,
	t1_destroyed,t2_destroyed,t3_destroyed,t4_destroyed,
	wall_destoryed,erase_finish,winner,start,
	t1score,t2score,t3score,t4score,
	t1_moving_d,t2_moving_d,t3_moving_d,t4_moving_d,
	mapselect);
	input clk,start;
	input [1:0] mapselect;
	output resetn;
	input [7:0] B1X,B2X,B3X,B4X,T1X,T2X,T3X,T4X;
	input [6:0] B1Y,B2Y,B3Y,B4Y,T1Y,T2Y,T3Y,T4Y;
	input t1moving,t2moving,t3moving,t4moving;
	input [2:0] tdirection1,tdirection2,tdirection3,tdirection4,bdirection1,bdirection2,bdirection3,bdirection4;
	input erase_finish;
	input [2:0] t1_moving_d,t2_moving_d,t3_moving_d,t4_moving_d;
	output [2:0] t1out,t2out,t3out,t4out;
	output reg [1:0] t1outcur,t2outcur,t3outcur,t4outcur;
	output reg b1_out,b2_out,b3_out,b4_out;
	output reg t1_destroyed,t2_destroyed,t3_destroyed,t4_destroyed;
	output reg [7:0] wall_destoryed;
	output reg [2:0] winner;
	output reg [3:0] t1score,t2score,t3score,t4score;
	wire [3:0] txu,txd,txl,txr,tyu,tyd,tyl,tyr,bxu,bxd,bxl,bxr,byu,byd,byl,byr;
	wire upmost,downmost,leftmost,rightmost,bupmost,bdownmost,bleftmost,brightmost,totherup,totherdown,totherleft,totherright,finish;
	wire cango,t1move,t2move,t3move,t4move;
	wire tdes1,tdes2,tdes3,tdes4,tdes,mapout;
	reg [3:0] tx,ty,txw,tyw,bx,by,bxw,byw;
	reg [7:0] BX,TX;
	reg [6:0] BY,TY;
	wire [7:0] BXM9,BXP1,TXM9,TXP9,TXM18,TXP18;
	wire [6:0] BYM9,BYP1,TYM9,TYP9,TYM18,TYP18;
	reg tother;
	reg bcheck;
	reg [7:0] address;
	reg check_t1,check_t2,check_t3,check_t4;
	reg wren,dataselect,most,bmost,counter_enable,data;
	reg [1:0] addselect;
	reg [2:0] tdirection,bdirection;
	reg [1:0] tdtmp;
	reg [1:0] tank_num,bullet_num;
	reg [5:0] current_state,next_state;
	reg [7:0] counter_output;
	reg [7:0] BXREAL;
	reg [6:0] BYREAL;
	wire q;
	reg [27:0] revive_counter1,revive_counter2,revive_counter3,revive_counter4;
	
	
	ram256x1 (
	address,
	clk,
	data,
	wren,
	q);
	
	assign TXM9 = TX-4'd9;
	assign TXP9 = TX+4'd9;
	assign TYM9 = TY-4'd9;
	assign TYP9 = TY+4'd9;
	assign TXM18 = TX-5'd18;
	assign TXP18 = TX+5'd18;
	assign TYM18 = TY-5'd18;
	assign TYP18 = TY+5'd18;
	assign tdes1 = ((BYM9<T1Y)|bupmost)&(BYP1>T1Y)&(BXM9<T1X)&(BXP1>T1X)&~(bullet_num==2'd0)&~t1_destroyed;
	assign tdes2 = ((BYM9<T2Y)|bupmost)&(BYP1>T2Y)&(BXM9<T2X)&(BXP1>T2X)&~(bullet_num==2'd1)&~t2_destroyed;
	assign tdes3 = ((BYM9<T3Y)|bupmost)&(BYP1>T3Y)&(BXM9<T3X)&(BXP1>T3X)&~(bullet_num==2'd2)&~t3_destroyed;
	assign tdes4 = ((BYM9<T4Y)|bupmost)&(BYP1>T4Y)&(BXM9<T4X)&(BXP1>T4X)&~(bullet_num==2'd3)&~t4_destroyed;
	assign tdes = tdes1|tdes2|tdes3|tdes4;
	assign BXM9 = BXREAL-4'd9;
	assign BXP1 = BXREAL+1'b1;
	assign BYM9 = BYREAL-4'd9;
	assign BYP1 = BYREAL+1'b1;
	assign t1out = {t1move,tdtmp};
	assign t2out = {t2move,tdtmp};
	assign t3out = {t3move,tdtmp};
	assign t4out = {t4move,tdtmp};
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
	assign upmost = (TY == 7'd1);
	assign downmost = (TY == 7'd109);
	assign leftmost = (TX == 8'd21);
	assign rightmost = (TX == 8'd129);
	assign bupmost = (BY == 7'd1);
	assign bdownmost = (BY == 7'd109);
	assign bleftmost = (BX == 8'd21);
	assign brightmost = (BX == 8'd129);
	assign totherup = ((T1Y>=TYM18)&(T1Y<TYM9)&(t1_moving_d==3'b101)|(TYM9 == T1Y)&(TXM9<T1X)&(TXP9>T1X))&~t1_destroyed|((T2Y>=TYM18)&(T2Y<TYM9)&(t2_moving_d==3'b101)|(TYM9 == T2Y)&(TXM9<T2X)&(TXP9>T2X))&~t2_destroyed|((T3Y>=TYM18)&(T3Y<TYM9)&(t3_moving_d==3'b101)|(TYM9 == T3Y)&(TXM9<T3X)&(TXP9>T3X))&~t3_destroyed|((T4Y>=TYM18)&(T4Y<TYM9)&(t4_moving_d==3'b101)|(TYM9 == T4Y)&(TXM9<T4X)&(TXP9>T4X))&~t4_destroyed;
	assign totherdown = ((T1Y<=TYP18)&(T1Y>TYP9)&(t1_moving_d==3'b100)|(TYP9 == T1Y)&(TXM9<T1X)&(TXP9>T1X))&~t1_destroyed|((T2Y<=TYP18)&(T2Y>TYP9)&(t2_moving_d==3'b100)|(TYP9 == T2Y)&(TXM9<T2X)&(TXP9>T2X))&~t2_destroyed|((T3Y<=TYP18)&(T3Y>TYP9)&(t3_moving_d==3'b100)|(TYP9 == T3Y)&(TXM9<T3X)&(TXP9>T3X))&~t3_destroyed|((T4Y<=TYP18)&(T4Y>TYP9)&(t4_moving_d==3'b100)|(TYP9 == T4Y)&(TXM9<T4X)&(TXP9>T4X))&~t4_destroyed;
	assign totherleft = ((T1X>=TXM18)&(T1X<TXM9)&(t1_moving_d==3'b111)|(TXM9 == T1X)&((TYM9<T1Y)|upmost)&(TYP9>T1Y))&~t1_destroyed|((T2X>=TXM18)&(T2X<TXM9)&(t2_moving_d==3'b111)|(TXM9 == T2X)&((TYM9<T2Y)|upmost)&(TYP9>T2Y))&~t2_destroyed|((T3X>=TXM18)&(T3X<TXM9)&(t3_moving_d==3'b111)|(TXM9 == T3X)&((TYM9<T3Y)|upmost)&(TYP9>T3Y))&~t3_destroyed|((T4X>=TXM18)&(T4X<TXM9)&(t4_moving_d==3'b111)|(TXM9 == T4X)&((TYM9<T4Y)|upmost)&(TYP9>T4Y))&~t4_destroyed;
	assign totherright = ((T1X<=TXP18)&(T1X>TXP9)&(t1_moving_d==3'b110)|(TXP9 == T1X)&((TYM9<T1Y)|upmost)&(TYP9>T1Y))&~t1_destroyed|((T2X<=TXP18)&(T2X>TXP9)&(t2_moving_d==3'b110)|(TXP9 == T2X)&((TYM9<T2Y)|upmost)&(TYP9>T2Y))&~t2_destroyed|((T3X<=TXP18)&(T3X>TXP9)&(t3_moving_d==3'b110)|(TXP9 == T3X)&((TYM9<T3Y)|upmost)&(TYP9>T3Y))&~t3_destroyed|((T4X<=TXP18)&(T4X>TXP9)&(t4_moving_d==3'b110)|(TXP9 == T4X)&((TYM9<T4Y)|upmost)&(TYP9>T4Y))&~t4_destroyed;
	assign resetn = ~((t1score == 3'd4)|(t2score == 3'd4)|(t3score == 3'd4)|(t4score == 3'd4));
	
	always @(posedge clk)
	begin
		tdtmp <= tdirection[1:0];
	end
	
	always @(posedge clk)
	begin
		if(!resetn)begin
			if(t1score == 3'd4)
				winner <= 3'b100;
			else if(t2score == 3'd4)
				winner <= 3'b101;
			else if(t3score == 3'd4)
				winner <= 3'b110;
			else if(t4score == 3'd4)
				winner <= 3'b111;
			else
				winner <= 3'b000;
		end
	end
			
	always @(posedge clk)
	begin
		if(!resetn)
			t1score <= 3'd0;
		else if(tdes&&bcheck&&(bullet_num == 2'd0))
			t1score <= t1score + 1'b1;
		else 
			t1score <= t1score;
		if(!resetn)
			t2score <= 3'd0;
		else if(tdes&&bcheck&&(bullet_num == 2'd1))
			t2score <= t2score + 1'b1;
		else 
			t2score <= t2score;
		if(!resetn)
			t3score <= 3'd0;
		else if(tdes&&bcheck&&(bullet_num == 2'd2))
			t3score <= t3score + 1'b1;
		else 
			t3score <= t3score;
		if(!resetn)
			t4score <= 3'd0;
		else if(tdes&&bcheck&&(bullet_num == 2'd3))
			t4score <= t4score + 1'b1;
		else 
			t4score <= t4score;
	end
			
	always @(posedge clk)
	begin
		if(!resetn)
			revive_counter1 <= 28'd0;
		else if(~t1_destroyed)
			revive_counter1 <= 28'd0;
		else
			revive_counter1 <= revive_counter1 + 1'b1;
		if(!resetn)
			revive_counter2 <= 28'd0;
		else if(~t2_destroyed)
			revive_counter2 <= 28'd0;
		else
			revive_counter2 <= revive_counter2 + 1'b1;
			
		if(!resetn)
			revive_counter3 <= 28'd0;
		else if(~t3_destroyed)
			revive_counter3 <= 28'd0;
		else
			revive_counter3 <= revive_counter3 + 1'b1;
			
		if(!resetn)
			revive_counter4 <= 28'd0;
		else if(~t4_destroyed)
			revive_counter4 <= 28'd0;
		else
			revive_counter4 <= revive_counter4 + 1'b1;
	end
	
	always @(posedge clk)
	begin
		if(!resetn)
			wall_destoryed <= 8'b11011101;
		else if(!dataselect)
			wall_destoryed <= address;
		else if(erase_finish)
			wall_destoryed <= 8'b11011101;
		else 
			wall_destoryed <= wall_destoryed;
	end
	
	always @(posedge clk)
	begin
		if(!resetn)
			t1_destroyed <= 1'b0;
		else if(tdes1&&bcheck)
			t1_destroyed <= 1'b1;
		else if(revive_counter1 == 28'd250000000)
			t1_destroyed <= 1'b0;
		else t1_destroyed <= t1_destroyed;
	end
	
	always @(posedge clk)
	begin
		if(!resetn)
			t2_destroyed <= 1'b0;
		else if(tdes2&&bcheck)
			t2_destroyed <= 1'b1;
		else if(revive_counter2 == 28'd250000000)
			t2_destroyed <= 1'b0;
		else t2_destroyed <= t2_destroyed;
	end
	
	always @(posedge clk)
	begin
		if(!resetn)
			t3_destroyed <= 1'b0;
		else if(tdes3&&bcheck)
			t3_destroyed <= 1'b1;
		else if(revive_counter3 == 28'd250000000)
			t3_destroyed <= 1'b0;
		else t3_destroyed <= t3_destroyed;
	end
	
	always @(posedge clk)
	begin
		if(!resetn)
			t4_destroyed <= 1'b0;
		else if(tdes4&&bcheck)
			t4_destroyed <= 1'b1;
		else if(revive_counter4 == 28'd250000000)
			t4_destroyed <= 1'b0;
		else t4_destroyed <= t4_destroyed;
	end
	
	always @(posedge clk)
	begin
		if(!resetn) 
			t1outcur <= 2'd0;
		else if(check_t1 == 1'b1)
			t1outcur <= tdtmp;
		else
			t1outcur <= t1outcur;
	end
	
	always @(posedge clk)
	begin
		if(!resetn) 
			t2outcur <= 2'd0;
		else if(check_t2 == 1'b1)
			t2outcur <= tdtmp;
		else
			t2outcur <= t2outcur;
	end
	
	always @(posedge clk)
	begin
		if(!resetn) 
			t3outcur <= 2'd0;
		else if(check_t3 == 1'b1)
			t3outcur <= tdtmp;
		else
			t3outcur <= t3outcur;
	end
	
	always @(posedge clk)
	begin
		if(!resetn) 
			t4outcur <= 2'd0;
		else if(check_t4 == 1'b1)
			t4outcur <= tdtmp;
		else
			t4outcur <= t4outcur;
	end
	
	always @(posedge clk)
	begin: counter
		if(!resetn)
			counter_output <= 8'd0;
		else if(counter_output == 8'b11111111)
			counter_output <= 8'd0;
		else if(counter_enable == 1'b0)
			counter_output <= 8'd0;
		else 
			counter_output <= counter_output + 1'b1;
	end
	
	
	assign finish = &counter_output;
	map(counter_output,mapout,mapselect);
	
	always @(*)
	begin
		case(dataselect)
			1'b0: data = 1'b0;
			1'b1: data = mapout;
		endcase
	end
	
	always @(*)
	begin
		case(tdtmp)
			2'd0: tother = totherup;
			2'd1: tother = totherdown;
			2'd2: tother = totherleft;
			2'd3: tother = totherright;
		endcase
	end
	
	always @(*)
	begin
		case(tdtmp)
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
					BXREAL = BX+3'd4;
					BYREAL = BY;
					end
			2'd1: begin 
					bxw = bxd;
					byw = byd;
					bmost = bdownmost;
					BXREAL = BX+3'd4;
					BYREAL = BY+4'd8;
					end
			2'd2: begin 
					bxw = bxl;
					byw = byl;
					bmost = bleftmost;
					BXREAL = BX;
					BYREAL = BY+3'd4;
					end
			2'd3: begin 
					bxw = bxr;
					byw = byr;
					bmost = brightmost;
					BXREAL = BX+4'd8;
					BYREAL = BY+3'd4;
					end
		endcase
	end
		
	always @(*)
	begin
		case(tank_num)
			2'd0: begin
					tdirection = tdirection1;
					TX = T1X;
					TY = T1Y;
					end
			2'd1: begin
					tdirection = tdirection2;
					TX = T2X;
					TY = T2Y;
					end
			2'd2: begin
					tdirection = tdirection3;
					TX = T3X;
					TY = T3Y;
					end
			2'd3: begin
					tdirection = tdirection4;
					TX = T4X;
					TY = T4Y;
					end
		endcase
	end
	
	always @(*)
	begin
		if((((BX-5'd21)%4'd9)==4'd0)&&(((BY-1'd1)%4'd9)==4'd0))
			begin
			bx = ((BX-5'd21)/4'd9);
			by = ((BY-1'd1)/4'd9);
			end
		else begin
			bx = 4'd14;
			by = 4'd14;
			end
	end
	
		always @(*)
	begin
		if((((TX-5'd21)%4'd9)==4'd0)&&(((TY-1'd1)%4'd9)==4'd0))
			begin
			tx = ((TX-5'd21)/4'd9);
			ty = ((TY-1'd1)/4'd9);
			end
		else begin
			tx = 4'd15;
			ty = 4'd15;
			end
	end
	
	always @(*)
	begin
		case(bullet_num)
			2'd0: begin
					bdirection = bdirection1;
					BX = B1X;
					BY = B1Y;
					end
			2'd1: begin
					bdirection = bdirection2;
					BX = B2X;
					BY = B2Y;
					end
			2'd2: begin
					bdirection = bdirection3;
					BX = B3X;
					BY = B3Y;
					end
			2'd3: begin
					bdirection = bdirection4;
					BX = B4X;
					BY = B4Y;
					end
		endcase
	end
	
	
	localparam  
				WAIT = 6'd0,
				SETMAP = 6'd25,
				T1_WAIT = 6'd1,
				T1_CHECK = 6'd2,
				T2_WAIT = 6'd3,
				T2_CHECK = 6'd4,
				T3_WAIT=6'd5,
				T3_CHECK = 6'd6,
				T4_WAIT=6'd7,
				T4_CHECK = 6'd8,
				B1_WAIT=6'd9,
				B1_CHECK=6'd10,
				B1_DESTROY=6'd11,
				B1_READY=6'd12,
				B2_WAIT=6'd13,
				B2_CHECK=6'd14,
				B2_DESTROY=6'd15,
				B2_READY=6'd16,
				B3_WAIT=6'd17,
				B3_CHECK=6'd18,
				B3_DESTROY=6'd19,
				B3_READY=6'd20,
				B4_WAIT=6'd21,
				B4_CHECK=6'd22,
				B4_DESTROY=6'd23,
				B4_READY=6'd24;
				
				
	
	always@(*)
    begin: state_table 
            case (current_state)
				WAIT: next_state = start ? SETMAP : WAIT;
				SETMAP: next_state = finish ? T1_WAIT : SETMAP;
				T1_WAIT: next_state = ((tdirection1[2]==1'b0) | (t1moving==1'b1) | (t1_destroyed==1'b1)) ? T2_WAIT : T1_CHECK;
				T2_WAIT: next_state = ((tdirection2[2]==1'b0) | (t2moving==1'b1) | (t2_destroyed==1'b1)) ? T3_WAIT : T2_CHECK;
				T3_WAIT: next_state = ((tdirection3[2]==1'b0) | (t3moving==1'b1) | (t3_destroyed==1'b1)) ? T4_WAIT : T3_CHECK;
				T4_WAIT: next_state = ((tdirection4[2]==1'b0) | (t4moving==1'b1) | (t4_destroyed==1'b1)) ? B1_WAIT : T4_CHECK;
				T1_CHECK: next_state = T2_WAIT;
				T2_CHECK: next_state = T3_WAIT;
				T3_CHECK: next_state = T4_WAIT;
				T4_CHECK: next_state = B1_WAIT;
				B1_WAIT: begin
							if((bdirection1[2] == 1'b0))
								next_state = B2_WAIT;
							else if(t1_destroyed)
								next_state = B1_READY;
							else
								next_state = B1_CHECK;
						end
				B1_CHECK: begin
							if(q == 1'b1)
								next_state = B1_DESTROY;
							else if(tdes == 1'b1 | bmost == 1'b1)
								next_state = B1_READY;
							else
								next_state = B2_WAIT;
							end
				B1_DESTROY: next_state = B1_READY;
				B1_READY: next_state = B2_WAIT;
				B2_WAIT: begin
							if((bdirection2[2] == 1'b0))
								next_state = B3_WAIT;	
							else if(t2_destroyed)
								next_state = B2_READY;
							else
								next_state = B2_CHECK;
						end
				B2_CHECK: begin
							if(q == 1'b1)
								next_state = B2_DESTROY;
							else if(tdes == 1'b1 | bmost == 1'b1)
								next_state = B2_READY;
							else
								next_state = B3_WAIT;
							end
				B2_DESTROY: next_state = B2_READY;
				B2_READY: next_state = B3_WAIT;
				B3_WAIT: begin
							if((bdirection3[2] == 1'b0))
								next_state = B4_WAIT;
							else if(t3_destroyed)
								next_state = B3_READY;	
							else
								next_state = B3_CHECK;
						end
				B3_CHECK: begin
							if(q == 1'b1)
								next_state = B3_DESTROY;
							else if(tdes == 1'b1 | bmost == 1'b1)
								next_state = B3_READY;
							else
								next_state = B4_WAIT;
							end
				B3_DESTROY: next_state = B3_READY;
				B3_READY: next_state = B4_WAIT;
				B4_WAIT: begin
							if((bdirection4[2] == 1'b0))
								next_state = T1_WAIT;
							else if(t4_destroyed)
								next_state = B4_READY;	
							else
								next_state = B4_CHECK;
						end
				B4_CHECK: begin
							if(q == 1'b1)
								next_state = B4_DESTROY;
							else if(tdes == 1'b1 | bmost == 1'b1)
								next_state = B4_READY;
							else
								next_state = T1_WAIT;
							end
				B4_DESTROY: next_state = B4_READY;
				B4_READY: next_state = T1_WAIT;
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
		dataselect = 1'b1;
		wren = 1'b0;
		check_t1 = 1'b0;
		check_t2 = 1'b0;
		check_t3 = 1'b0;
		check_t4 = 1'b0;
		tank_num = 2'd0;
		bullet_num = 2'd0;
		b1_out = 1'b0;
		b2_out = 1'b0;
		b3_out = 1'b0;
		b4_out = 1'b0;
		bcheck = 1'b0;
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
			B1_WAIT: begin
				bullet_num = 2'd0;
				addselect = 2'd1;
				end
			B1_CHECK: begin
				bullet_num = 2'd0;
				addselect = 2'd1;
				bcheck = 1'b1;
				end
			B1_DESTROY: begin
				bullet_num = 2'd0;
				addselect = 2'd1;
				wren = 1'b1;
				dataselect = 1'b0;
				end
			B1_READY: begin
				bullet_num = 2'd0;
				addselect = 2'd1;
				b1_out = 1'b1;
				end
			B2_WAIT: begin
				bullet_num = 2'd1;
				addselect = 2'd1;
				end
			B2_CHECK: begin
				bullet_num = 2'd1;
				addselect = 2'd1;
				bcheck = 1'b1;
				end
			B2_DESTROY: begin
				bullet_num = 2'd1;
				addselect = 2'd1;
				wren = 1'b1;
				dataselect = 1'b0;
				end
			B2_READY: begin
				bullet_num = 2'd1;
				addselect = 2'd1;
				b2_out = 1'b1;
				end
			B3_WAIT: begin
				bullet_num = 2'd2;
				addselect = 2'd1;
				end
			B3_CHECK: begin
				bullet_num = 2'd2;
				addselect = 2'd1;
				bcheck = 1'b1;
				end
			B3_DESTROY: begin
				bullet_num = 2'd2;
				addselect = 2'd1;
				wren = 1'b1;
				dataselect = 1'b0;
				end
			B3_READY: begin
				bullet_num = 2'd2;
				addselect = 2'd1;
				b3_out = 1'b1;
				end
			B4_WAIT: begin
				bullet_num = 2'd3;
				addselect = 2'd1;
				end
			B4_CHECK: begin
				bullet_num = 2'd3;
				addselect = 2'd1;
				bcheck = 1'b1;
				end
			B4_DESTROY: begin
				bullet_num = 2'd3;
				addselect = 2'd1;
				wren = 1'b1;
				dataselect = 1'b0;
				end
			B4_READY: begin
				bullet_num = 2'd3;
				addselect = 2'd1;
				b4_out = 1'b1;
				end
        endcase
    end 
endmodule
