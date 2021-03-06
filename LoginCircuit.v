`define STAGE1 0
`define STAGE2 1
`define STAGE3 2
`define STAGE4 3
`define STAGE5 4
`define STAGE6 5
`define STAGE7 6
`define STAGE8 7
`define STAGE9 8

`define RESET1 0
`define RESET2 1
`define RESET3 2
`define FUNC_SET 3
`define DISPLAY_OFF 4
`define DISPLAY_CLEAR 5
`define DISPLAY_ON 6
`define MODE_SET 7
`define RETURN_HOME 8
`define TOGGLE_E 9
`define HOLD 10
`define HALT 11
`define SUB01 12
`define SUB02 13
`define SUB03 14
`define SUB04 15
`define SUB05 16
`define SUB06 17
`define SUB07 18
`define SUB08 19
`define SUB09 20
`define SUB10 21
`define SUB11 22
`define SUB12 23
`define SUB13 24
`define SUB14 25
`define SUB15 26
`define SUB16 27
`define SUB17 28
`define SUB18 29
`define SUB19 30
`define SUB20 31
`define SUB21 32
`define SUB22 33
`define SUB23 34

module LoginCircuit(LCD_RS, LCD_E, LCD_ON, LCD_RW, DATA_BUS,
					KEY3, KEY2, KEY1, KEY0, SW, SWADMIN,
					LEDG3, LEDG2, LEDG1, LEDG0, LEDR, LEDRLOG, LEDRADMIN,
					CLK_50MHZ);

//khai bao cong
input [5:0] SW;
input KEY3, KEY2, KEY1, KEY0, CLK_50MHZ, SWADMIN;

output [5:0] LEDR;
output LEDG3, LEDG2, LEDG1, LEDG0, LEDRADMIN;
output reg LEDRLOG;

output reg LCD_RS, LCD_E, LCD_ON, LCD_RW;
output reg [7:0] DATA_BUS;

integer count1, count2, CLK2, logcount;
reg CLK1;

reg [5:0] PASS, TIME, CD;
integer STAGE, SUB, NEXT_SUB;

//noi cac line co ban
assign LEDR = SW;
assign LEDG3 = KEY3;
assign LEDG2 = KEY2;
assign LEDG1 = KEY1;
assign LEDG0 = KEY0;
assign LEDRADMIN = SWADMIN;

//Khoi tao--------------------------------------------
initial
begin
	LCD_ON<=1'b1;
	LEDRLOG<=0;
	count1 = 0;
	count2 = 0;
	PASS = 6'd0;
	TIME = 6'd5;
	CD = TIME;
	STAGE = `STAGE1;
	SUB = `RESET1;
	CLK1 = 0;
	CLK2 = 0;
end

//Dem xung 50MHZ--------------------------------------
always @(posedge CLK_50MHZ)
begin
	if (count1>25000)
	begin
		count1 = 0;
		CLK1 = !CLK1;
	end
	else
		count1 = count1 + 1;
end

//Xu li thong tin
always @(posedge CLK1)
begin

//Dem xung 1s---------------------------------------------
	if (count2>1000)
	begin
		count2 = 0;
		CLK2 = CLK2 + 1;
		if (CLK2>1000) CLK2 = 0;
		if (STAGE==`STAGE4) CD<=CD-1;
		if (STAGE==`STAGE5 && CLK2==2)
			CLK2=0;
	end
	else
		count2 = count2 + 1;

//DEFAULT SUB STAGE
	case (SUB)
	`RESET1:
		begin
			LCD_E<=1;
			LCD_RS<=0;
			LCD_RW<=0;
			DATA_BUS<=8'h38;
			SUB<=`TOGGLE_E;
			NEXT_SUB<=`RESET2;
		end	
	`RESET2:
		begin
			LCD_E<=1;
			LCD_RS<=0;
			LCD_RW<=0;
			DATA_BUS<=8'h38;
			SUB<=`TOGGLE_E;
			NEXT_SUB<=`RESET3;
		end
	`RESET3:
		begin
			LCD_E<=1;
			LCD_RS<=0;
			LCD_RW<=0;
			DATA_BUS<=8'h38;
			SUB<=`TOGGLE_E;
			NEXT_SUB<=`FUNC_SET;
		end		
	`FUNC_SET:
		begin
			LCD_E<=1;
			LCD_RS<=0;
			LCD_RW<=0;
			DATA_BUS<=8'h38;
			SUB<=`TOGGLE_E;
			NEXT_SUB<=`DISPLAY_OFF;
		end		
	`DISPLAY_OFF:
		begin
			LCD_E<=1;
			LCD_RS<=0;
			LCD_RW<=0;
			DATA_BUS<=8'h08;
			SUB<=`TOGGLE_E;
			NEXT_SUB<=`DISPLAY_CLEAR;
		end
	`DISPLAY_CLEAR:
		begin
			LCD_E<=1;
			LCD_RS<=0;
			LCD_RW<=0;
			DATA_BUS<=8'h01;
			SUB<=`TOGGLE_E;
			NEXT_SUB<=`DISPLAY_ON;
		end		
	`DISPLAY_ON:
		begin
			LCD_E<=1;
			LCD_RS<=0;
			LCD_RW<=0;
			DATA_BUS<=8'h0C;
			SUB<=`TOGGLE_E;
			NEXT_SUB<=`MODE_SET;
		end
	`TOGGLE_E:
		begin
			LCD_E<=0;
			SUB<=`HOLD;
		end
	`HOLD:
			SUB<=NEXT_SUB;
	`MODE_SET:
		begin
			LCD_E<=1;
			LCD_RS<=0;
			LCD_RW<=0;
			DATA_BUS<=8'h06;
			SUB<=`TOGGLE_E;
			NEXT_SUB<=`SUB01;
		end
	endcase
	
	case (STAGE)
	
//WELCOME-------------------------------------------------------------------
	`STAGE1: 
	begin
		case (SUB)
		`SUB01:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h58;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB02;
			end
		`SUB02:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h69;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB03;
			end
		`SUB03:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h6E;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB04;
			end
		`SUB04:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h20;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB05;
			end
		`SUB05:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h43;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB06;
			end
		`SUB06:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h68;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB07;
			end
		`SUB07:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h61;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB08;
			end
		`SUB08:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h6F;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB09;
			end
		`SUB09:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h21;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`RETURN_HOME;
			end
		`RETURN_HOME:
			begin
				LCD_E<=1;
				LCD_RS<=0;
				LCD_RW<=0;
				DATA_BUS<=8'h80;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`HALT;
			end
		endcase
		
		if (CLK2>=3)
		begin
			logcount<=0;
			STAGE<=`STAGE2;
			SUB<=`RESET1;
			CLK2<=0;
			count2<=0;
		end
	end
	
//LOGIN-----------------------------------------------------------------------
	`STAGE2:
	begin
		LEDRLOG<=0;	
		case (SUB)
		`SUB01:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h4D;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB02;
			end
		`SUB02:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h61;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB03;
			end
		`SUB03:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h74;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB04;
			end
		`SUB04:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h20;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB05;
			end
		`SUB05:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h4B;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB06;
			end
		`SUB06:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h68;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB07;
			end
		`SUB07:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h61;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB08;
			end
		`SUB08:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h75;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB09;
			end
		`SUB09:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h3F;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB10;
			end
		`SUB10:
			begin
				LCD_E<=1;
				LCD_RS<=0;
				LCD_RW<=0;
				DATA_BUS<=8'hC9;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB11;
			end
		`SUB11:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h30+SW[5];
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB12;
			end
		`SUB12:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h30+SW[4];
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB13;
			end
		`SUB13:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h30+SW[3];
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB14;
			end
		`SUB14:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h30+SW[2];
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB15;
			end
		`SUB15:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h30+SW[1];
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB16;
			end
		`SUB16:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h30+SW[0];
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`RETURN_HOME;
			end
		`RETURN_HOME:
			begin
				LCD_E<=1;
				LCD_RS<=0;
				LCD_RW<=0;
				DATA_BUS<=8'h80;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB01;
			end
		endcase
		
		if (KEY3==0)
			if (SW==PASS)
			begin
				logcount<=0;
				STAGE<=`STAGE5;
				SUB<=`RESET1;
				CLK2<=0;
				count2<=0;
			end
			else
			begin
				logcount=logcount+1;
				SUB<=`RESET1;
				CLK2<=0;
				count2<=0;
				if (logcount>=3)
				begin
					CD<=TIME;
					STAGE<=`STAGE4;
					logcount<=0;
				end
				else
					STAGE<=`STAGE3;
		end
	end

//FAILED LV1 -------------------------------------------------------------
	`STAGE3:
	begin
		case (SUB)
		`SUB01:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h53;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB02;
			end
		`SUB02:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h61;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB03;
			end
		`SUB03:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h69;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB04;
			end
		`SUB04:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h20;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB05;
			end
		`SUB05:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h4D;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB06;
			end
		`SUB06:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h4B;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB07;
			end
		`SUB07:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h21;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB08;
			end
		`SUB08:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h21;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB09;
			end
		`SUB09:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h21;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`RETURN_HOME;
			end
		`RETURN_HOME:
			begin
				LCD_E<=1;
				LCD_RS<=0;
				LCD_RW<=0;
				DATA_BUS<=8'h80;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`HALT;
			end
		endcase
		
		if (CLK2>=3)
		begin
			STAGE<=`STAGE2;
			SUB<=`RESET1;
			CLK2<=0;
			count2<=0;
		end
	end
	
//FAILED LV2 ----------------------------------------------------------------
	`STAGE4:
	begin
		case (SUB)
		`SUB01:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h53;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB02;
			end
		`SUB02:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h61;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB03;
			end
		`SUB03:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h69;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB04;
			end
		`SUB04:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h21;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB05;
			end
		`SUB05:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h21;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB06;
			end
		`SUB06:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h21;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB07;
			end
		`SUB07:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h20;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB08;
			end
		`SUB08:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h4C;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB09;
			end
		`SUB09:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h6F;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB10;
			end
		`SUB10:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h67;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB11;
			end
		`SUB11:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h69;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB12;
			end
		`SUB12:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h6E;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB13;
			end
		`SUB13:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h20;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB14;
			end
		`SUB14:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h43;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB15;
			end
		`SUB15:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h44;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB16;
			end
		`SUB16:
			begin
				LCD_E<=1;
				LCD_RS<=0;
				LCD_RW<=0;
				DATA_BUS<=8'hC8;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB17;
			end
		`SUB17:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h30+CD[5];
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB18;
			end
		`SUB18:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h30+CD[4];
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB19;
			end
		`SUB19:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h30+CD[3];
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB20;
			end
		`SUB20:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h30+CD[2];
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB21;
			end
		`SUB21:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h30+CD[1];
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB22;
			end
		`SUB22:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h30+CD[0];
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB23;
			end
		`SUB23:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h73;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`RETURN_HOME;
			end
		`RETURN_HOME:
			begin
				LCD_E<=1;
				LCD_RS<=0;
				LCD_RW<=0;
				DATA_BUS<=8'h80;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB01;
			end
		endcase
		
		if (CLK2>=TIME)
		begin
			STAGE<=`STAGE2;
			SUB<=`RESET1;
			CLK2<=0;
			count2<=0;
		end
	end

//SUCCESS ----------------------------------------------------------------
	`STAGE5:
	begin
		case (SUB)
		`SUB01:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=(CLK2>=1)?8'h44:8'h20;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB02;
			end
		`SUB02:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=(CLK2>=1)?8'h4E:8'h20;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB03;
			end
		`SUB03:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h20;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB04;
			end
		`SUB04:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=(CLK2>=1)?8'h54:8'h20;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB05;
			end
		`SUB05:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=(CLK2>=1)?8'h68:8'h20;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB06;
			end
		`SUB06:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=(CLK2>=1)?8'h61:8'h20;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB07;
			end
		`SUB07:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=(CLK2>=1)?8'h6E:8'h20;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB08;
			end
		`SUB08:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=(CLK2>=1)?8'h68:8'h20;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB09;
			end
		`SUB09:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h20;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB10;
			end
		`SUB10:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=(CLK2>=1)?8'h43:8'h20;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB11;
			end
		`SUB11:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=(CLK2>=1)?8'h6F:8'h20;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB12;
			end
		`SUB12:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=(CLK2>=1)?8'h6E:8'h20;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB13;
			end
		`SUB13:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=(CLK2>=1)?8'h67:8'h20;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB14;
			end
		`SUB14:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=(CLK2>=1)?8'h21:8'h20;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB15;
			end
		`SUB15:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=(CLK2>=1)?8'h21:8'h20;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB16;
			end
		`SUB16:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=(CLK2>=1)?8'h21:8'h20;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`RETURN_HOME;
			end
		`RETURN_HOME:
			begin
				LCD_E<=1;
				LCD_RS<=0;
				LCD_RW<=0;
				DATA_BUS<=8'h80;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`RESET1;
			end
		endcase
		
		LEDRLOG<=1;
		
		if (KEY0==0)
		begin
			STAGE<=`STAGE1;
			SUB<=`RESET1;
			CLK2<=0;
			count2<=0;
		end
		
		if (SWADMIN)
		begin
			STAGE<=`STAGE6;
			SUB<=`RESET1;
			CLK2<=0;
			count2<=0;
		end
	end
	
//ADMIN --------------------------------------------------------------
	`STAGE6:
	begin
		case (SUB)
		`SUB01:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h41;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB02;
			end
		`SUB02:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h64;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB03;
			end
		`SUB03:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h6D;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB04;
			end
		`SUB04:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h69;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB05;
			end
		`SUB05:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h6E;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`RETURN_HOME;
			end
			`RETURN_HOME:
			begin
				LCD_E<=1;
				LCD_RS<=0;
				LCD_RW<=0;
				DATA_BUS<=8'h80;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`HALT;
			end
		endcase
		
		if (KEY0==0)
		begin
			STAGE<=`STAGE1;
			SUB<=`RESET1;
			CLK2<=0;
			count2<=0;
		end
		if (KEY3==0)
		begin
			STAGE<=`STAGE7;
			SUB<=`RESET1;
			CLK2<=0;
			count2<=0;
		end
		if (KEY2==0)
		begin
			STAGE<=`STAGE8;
			SUB<=`RESET1;
			CLK2<=0;
			count2<=0;
		end
	end
	
//CHANGE PASS ------------------------------------------------------
	`STAGE7:
	begin
		case (SUB)
		`SUB01:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h44;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB02;
			end
		`SUB02:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h6F;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB03;
			end
		`SUB03:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h69;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB04;
			end
		`SUB04:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h20;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB05;
			end
		`SUB05:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h50;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB06;
			end
		`SUB06:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h61;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB07;
			end
		`SUB07:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h73;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB08;
			end
		`SUB08:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h73;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB09;
			end
		`SUB09:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h3A;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB10;
			end
		`SUB10:
			begin
				LCD_E<=1;
				LCD_RS<=0;
				LCD_RW<=0;
				DATA_BUS<=8'hC9;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB11;
			end
		`SUB11:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h30+SW[5];
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB12;
			end
		`SUB12:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h30+SW[4];
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB13;
			end
		`SUB13:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h30+SW[3];
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB14;
			end
		`SUB14:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h30+SW[2];
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB15;
			end
		`SUB15:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h30+SW[1];
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB16;
			end
		`SUB16:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h30+SW[0];
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`RETURN_HOME;
			end
		`RETURN_HOME:
			begin
				LCD_E<=1;
				LCD_RS<=0;
				LCD_RW<=0;
				DATA_BUS<=8'h80;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB01;
			end
		endcase
		
		if (KEY1==0)
		begin
			PASS<=SW;
			STAGE<=`STAGE9;
			SUB<=`RESET1;
			CLK2<=0;
			count2<=0;
		end
		if (KEY0==0)
		begin
			STAGE<=`STAGE6;
			SUB<=`RESET1;
			CLK2<=0;
			count2<=0;
		end
	end
	
//CHANGE TIME ------------------------------------------------------
	`STAGE8:
	begin
		case (SUB)
		`SUB01:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h44;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB02;
			end
		`SUB02:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h6F;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB03;
			end
		`SUB03:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h69;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB04;
			end
		`SUB04:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h20;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB05;
			end
		`SUB05:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h54;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB06;
			end
		`SUB06:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h69;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB07;
			end
		`SUB07:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h6D;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB08;
			end
		`SUB08:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h65;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB09;
			end
		`SUB09:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h3A;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB10;
			end
		`SUB10:
			begin
				LCD_E<=1;
				LCD_RS<=0;
				LCD_RW<=0;
				DATA_BUS<=8'hC9;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB11;
			end
		`SUB11:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h30+SW[5];
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB12;
			end
		`SUB12:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h30+SW[4];
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB13;
			end
		`SUB13:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h30+SW[3];
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB14;
			end
		`SUB14:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h30+SW[2];
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB15;
			end
		`SUB15:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h30+SW[1];
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB16;
			end
		`SUB16:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h30+SW[0];
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`RETURN_HOME;
			end
		`RETURN_HOME:
			begin
				LCD_E<=1;
				LCD_RS<=0;
				LCD_RW<=0;
				DATA_BUS<=8'h80;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB01;
			end
		endcase
		
		if (KEY1==0)
		begin
			TIME<=SW;
			STAGE<=`STAGE9;
			SUB<=`RESET1;
			CLK2<=0;
			count2<=0;
		end
		if (KEY0==0)
		begin
			STAGE<=`STAGE6;
			SUB<=`RESET1;
			CLK2<=0;
			count2<=0;
		end
	end

//CHANGED ----------------------------------------------------------------
	`STAGE9:
	begin
		case (SUB)
		`SUB01:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h43;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB02;
			end
		`SUB02:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h68;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB03;
			end
		`SUB03:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h61;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB04;
			end
		`SUB04:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h6E;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB05;
			end
		`SUB05:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h67;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB06;
			end
		`SUB06:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h69;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB07;
			end
		`SUB07:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h6E;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB08;
			end
		`SUB08:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h67;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB09;
			end
		`SUB09:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h2E;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB10;
			end
		`SUB10:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h2E;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`SUB11;
			end
		`SUB11:
			begin
				LCD_E<=1;
				LCD_RS<=1;
				LCD_RW<=0;
				DATA_BUS<=8'h2E;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`RETURN_HOME;
			end
		`RETURN_HOME:
			begin
				LCD_E<=1;
				LCD_RS<=0;
				LCD_RW<=0;
				DATA_BUS<=8'h80;
				SUB<=`TOGGLE_E;
				NEXT_SUB<=`HALT;
			end
		endcase
		
		if (CLK2>=3)
		begin
			STAGE<=`STAGE6;
			SUB<=`RESET1;
			CLK2<=0;
			count2<=0;
		end
	end	

	endcase
end

endmodule