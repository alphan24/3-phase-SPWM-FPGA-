module 3p_sin(clk,out_p1,out_p1_inv,out_p2,out_p2_inv,out_p3,out_p3_inv,freq_adj);
input clk;
input [3:0]freq_adj;
output out_p1,out_p1_inv,out_p2,out_p2_inv,out_p3,out_p3_inv;

wire [7:0]duty_cycle_1;
wire [7:0]duty_cycle_2;
wire [7:0]duty_cycle_3;

wire [7:0]address_p1;
wire [7:0]address_p2;
wire [7:0]address_p3;

wire en;
wire clock;

pwm u1(.duty_cycle(duty_cycle_1), .clk(clk), .out(out_p1), .en(en));
pwm u2(.duty_cycle(duty_cycle_2), .clk(clk), .out(out_p2), .en(en));
pwm u3(.duty_cycle(duty_cycle_3), .clk(clk), .out(out_p3), .en(en));
sin_look_up u4(.address(address_p1), .duty_cycle(duty_cycle_1));
sin_look_up u5(.address(address_p2), .duty_cycle(duty_cycle_2));
sin_look_up u6(.address(address_p3), .duty_cycle(duty_cycle_3));
clk_div u7(.clk(clk), .clk_sel(freq_adj), .clk_out(clock));
modulation_con u8(.clk(clock), .address_p1(address_p1), .address_p2(address_p2), .address_p3(address_p3));

	
assign en = 1;	
assign out_p1_inv = ~out_p1;
assign out_p2_inv = ~out_p2;
assign out_p3_inv = ~out_p3;
endmodule

module modulation_con(clk,address_p1,address_p2,address_p3);
input clk;
output [7:0]address_p1; 
output [7:0]address_p2; 
output [7:0]address_p3;

reg [14:0] counter;
reg [14:0] next_counter;

always @ (posedge clk)
	begin
		counter = next_counter;
	end
always @ *
	begin
		next_counter = counter+1;
	end
assign address_p1 [7:0]=  counter [14:7];
assign address_p2 [7:0]=  counter [14:7]+85;
assign address_p3 [7:0]=  counter [14:7]+171;
endmodule

module pwm(clk,en,duty_cycle,out);
input clk;
input en;
input [7:0]duty_cycle;
output reg out;

reg [7:0]counter;
reg [7:0]next_counter;

always @ (posedge clk)
	begin
		counter = next_counter;
	end
	
always @ *
	begin
		if(en)
			begin
				if(counter < duty_cycle)
					begin
						out = 1;
					end
				else
					begin
						out = 0;
					end
					
				next_counter = counter+1;
				
			end
		else 
			begin
				next_counter = 0;
			end	
	end
endmodule

module clk_div(clk,clk_sel,clk_out);
input clk;
input [3:0]clk_sel;
output reg clk_out;

reg [15:0]counter;
reg [15:0]next_counter;

always @ (posedge clk)
	begin
		counter = next_counter;
	end
always @ *
	begin
		next_counter = counter+1;
		
		case(clk_sel[3:0])
				0 : clk_out = counter[0];
				1 : clk_out = counter[1];
				2 : clk_out = counter[2];
				3 : clk_out = counter[3];
				4 : clk_out = counter[4];
				5 : clk_out = counter[5];
				6 : clk_out = counter[6];
				7 : clk_out = counter[7];
				8 : clk_out = counter[8];
				9 : clk_out = counter[9];
				10 : clk_out = counter[10];
				11 : clk_out = counter[11];
				12 : clk_out = counter[12];
				13 : clk_out = counter[13];
				14 : clk_out = counter[14];
				15 : clk_out = counter[15];
		endcase
	end
endmodule

module sin_look_up(address,duty_cycle);
input [7:0] address;
output reg [7:0] duty_cycle;

always @ *
	begin
		case(address[7:0])
			0 : duty_cycle = 127;
			1 : duty_cycle = 130;
			2 : duty_cycle = 133;
			3 : duty_cycle = 136;
			4 : duty_cycle = 139;
			5 : duty_cycle = 143;
			6 : duty_cycle = 146;
			7 : duty_cycle = 149;
			8 : duty_cycle = 152;
			9 : duty_cycle = 155;
			10 : duty_cycle = 158;
			11 : duty_cycle = 161;
			12 : duty_cycle = 164;
			13 : duty_cycle = 167;
			14 : duty_cycle = 170;
			15 : duty_cycle = 173;
			16 : duty_cycle = 176;
			17 : duty_cycle = 178;
			18 : duty_cycle = 181;
			19 : duty_cycle = 184;
			20 : duty_cycle = 187;
			21 : duty_cycle = 190;
			22 : duty_cycle = 192;
			23 : duty_cycle = 195;
			24 : duty_cycle = 198;
			25 : duty_cycle = 200;
			26 : duty_cycle = 203;
			27 : duty_cycle = 205;
			28 : duty_cycle = 208;
			29 : duty_cycle = 210;
			30 : duty_cycle = 212;
			31 : duty_cycle = 215;
			32 : duty_cycle = 217;
			33 : duty_cycle = 219;
			34 : duty_cycle = 221;
			35 : duty_cycle = 223;
			36 : duty_cycle = 225;
			37 : duty_cycle = 227;
			38 : duty_cycle = 229;
			39 : duty_cycle = 231;
			40 : duty_cycle = 233;
			41 : duty_cycle = 234;
			42 : duty_cycle = 236;
			43 : duty_cycle = 238;
			44 : duty_cycle = 240;
			45 : duty_cycle = 242;
			46 : duty_cycle = 243;
			47 : duty_cycle = 244;
			48 : duty_cycle = 245;
			49 : duty_cycle = 247;
			50 : duty_cycle = 248;
			51 : duty_cycle = 249;
			52 : duty_cycle = 249;
			53 : duty_cycle = 250;
			54 : duty_cycle = 251;
			55 : duty_cycle = 252;
			56 : duty_cycle = 252;
			57 : duty_cycle = 253;
			58 : duty_cycle = 253;
			59 : duty_cycle = 253;
			60 : duty_cycle = 254;
			61 : duty_cycle = 254;
			62 : duty_cycle = 254;
			63 : duty_cycle = 254;
			64 : duty_cycle = 254;
			65 : duty_cycle = 254;
			66 : duty_cycle = 253;
			67 : duty_cycle = 253;
			68 : duty_cycle = 253;
			69 : duty_cycle = 252;
			70 : duty_cycle = 252;
			71 : duty_cycle = 251;
			72 : duty_cycle = 250;
			73 : duty_cycle = 249;
			74 : duty_cycle = 249;
			75 : duty_cycle = 248;
			76 : duty_cycle = 247;
			77 : duty_cycle = 245;
			78 : duty_cycle = 244;
			79 : duty_cycle = 243;
			80 : duty_cycle = 242;
			81 : duty_cycle = 240;
			82  : duty_cycle = 239;
			83  : duty_cycle = 238;
			84  : duty_cycle = 236;
			85  : duty_cycle = 234;
			86  : duty_cycle = 233;
			87  : duty_cycle = 231;
			88  : duty_cycle = 229;
			89  : duty_cycle = 227;
			90  : duty_cycle = 225;
			91  : duty_cycle = 223;
			92  : duty_cycle = 221;
			93  : duty_cycle = 219;
			94  : duty_cycle = 217;
			95  : duty_cycle = 215;
			96  : duty_cycle = 212;
			97  : duty_cycle = 210;
			98  : duty_cycle = 208;
			99  : duty_cycle = 205;
			100 : duty_cycle = 203;
			101 : duty_cycle = 200;
			102 : duty_cycle = 198;
			103 : duty_cycle = 195;
			104 : duty_cycle = 192;
			105 : duty_cycle = 190;
			106 : duty_cycle = 187;
			107 : duty_cycle = 184;
			108 : duty_cycle = 181;
			109 : duty_cycle = 178;
			110 : duty_cycle = 176;
			111 : duty_cycle = 173;
			112 : duty_cycle = 170;
			113 : duty_cycle = 167;
			114 : duty_cycle = 164;
			115 : duty_cycle = 161;
			116 : duty_cycle = 158;
			117 : duty_cycle = 155;
			118 : duty_cycle = 152;
			119 : duty_cycle = 149;
			120 : duty_cycle = 146;
			121 : duty_cycle = 143;
			122 : duty_cycle = 149;
			123 : duty_cycle = 136;
			124 : duty_cycle = 133;
			125 : duty_cycle = 130;
			126 : duty_cycle = 127;
			127 : duty_cycle = 124;
			128 : duty_cycle = 121;
			129 : duty_cycle = 118;
			130 : duty_cycle = 115;
			131 : duty_cycle = 111;
			132 : duty_cycle = 108;
			133 : duty_cycle = 105;
			134 : duty_cycle = 102;
			135 : duty_cycle = 99;
			136 : duty_cycle = 96;
			137 : duty_cycle = 93;
			138 : duty_cycle = 90;
			139 : duty_cycle = 87;
			140 : duty_cycle = 84;
			141 : duty_cycle = 81;
			142 : duty_cycle = 78;
			143 : duty_cycle = 76;
			144 : duty_cycle = 73;
			145 : duty_cycle = 70;
			146 : duty_cycle = 67;
			147 : duty_cycle = 64;
			148 : duty_cycle = 62;
			149 : duty_cycle = 59;
			150 : duty_cycle = 56;
			151 : duty_cycle = 54;
			152 : duty_cycle = 51;
			153 : duty_cycle = 49;
			154 : duty_cycle = 46;
			155 : duty_cycle = 44;
			156 : duty_cycle = 42;
			157 : duty_cycle = 39;
			158 : duty_cycle = 37;
			159 : duty_cycle = 35;
			160 : duty_cycle = 33;
			161 : duty_cycle = 31;
			162 : duty_cycle = 29;
			163 : duty_cycle = 27;
			164 : duty_cycle = 25;
			165 : duty_cycle = 23;
			166 : duty_cycle = 21;
			167 : duty_cycle = 20;
			168 : duty_cycle = 18;
			169 : duty_cycle = 16;
			170 : duty_cycle = 15;
			171 : duty_cycle = 14;
			172 : duty_cycle = 12;
			173 : duty_cycle = 11;
			174 : duty_cycle = 10;
			175 : duty_cycle = 9;
			178 : duty_cycle = 7;
			179 : duty_cycle = 6;
			180 : duty_cycle = 5;
			181 : duty_cycle = 5;
			182 : duty_cycle = 4;
			183 : duty_cycle = 3;
			184 : duty_cycle = 2;
			185 : duty_cycle = 2;
			186 : duty_cycle = 1;
			187 : duty_cycle = 1;
			188 : duty_cycle = 1;
			189 : duty_cycle = 0;
			190 : duty_cycle = 0;
			191 : duty_cycle = 0;
			192 : duty_cycle = 0;
			193 : duty_cycle = 0;
			194 : duty_cycle = 0;
			195 : duty_cycle = 0;
			196 : duty_cycle = 1;
			197 : duty_cycle = 1;
			198 : duty_cycle = 1;
			199 : duty_cycle = 2;
			200 : duty_cycle = 2;
			201 : duty_cycle = 3;
			202 : duty_cycle = 4;
			203 : duty_cycle = 5;
			204 : duty_cycle = 5;
			205 : duty_cycle = 6;
			206 : duty_cycle = 7;
			207 : duty_cycle = 9;
			208 : duty_cycle = 10;
			209 : duty_cycle = 11;
			210 : duty_cycle = 12;
			211 : duty_cycle = 14;
			212 : duty_cycle = 15;
			213 : duty_cycle = 16;
			214 : duty_cycle = 18;
			215 : duty_cycle = 20;
			216 : duty_cycle = 21;
			217 : duty_cycle = 23;
			218 : duty_cycle = 25;
			219 : duty_cycle = 27;
			220 : duty_cycle = 29;
			221 : duty_cycle = 31;
			222 : duty_cycle = 33;
			223 : duty_cycle = 35;
			224 : duty_cycle = 37;
			225 : duty_cycle = 39;
			226 : duty_cycle = 42;
			227 : duty_cycle = 44;
			228 : duty_cycle = 46;
			229 : duty_cycle = 49;
			230 : duty_cycle = 51;
			231 : duty_cycle = 54;
			232 : duty_cycle = 56;
			233 : duty_cycle = 59;
			234 : duty_cycle = 62;
			235 : duty_cycle = 64;
			236 : duty_cycle = 67;
			237 : duty_cycle = 70;
			238 : duty_cycle = 73;
			239 : duty_cycle = 76;
			240 : duty_cycle = 78;
			241 : duty_cycle = 81;
			242 : duty_cycle = 84;
			243 : duty_cycle = 87;
			244 : duty_cycle = 90;
			245 : duty_cycle = 93;
			246 : duty_cycle = 96;
			247 : duty_cycle = 99;
			248 : duty_cycle = 102;
			249 : duty_cycle = 105;
			250 : duty_cycle = 108;
			251 : duty_cycle = 111;
			252 : duty_cycle = 115;
			253 : duty_cycle = 118;
			254 : duty_cycle = 121;
			255 : duty_cycle = 124;
		endcase
	end

endmodule
