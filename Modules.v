`define S0 3'd0
`define S1 3'd1
`define S2 3'd2
`define S3 3'd3
`define S4 3'd4

module ALU(A, B, ALU_control, ALU_out, zero, negative);
	input [31:0]A, B;
	input [2:0] ALU_control;
	output [31:0] ALU_out;
	output zero, negative;
	reg zero, negative;
	reg [31:0] ALU_out;
	always@(A, B, ALU_control) begin
		case(ALU_control)
			`S0:ALU_out = A+B;
			`S1:ALU_out = A-B;
			`S2:ALU_out = A&B;
			`S3:ALU_out = A|B;
			`S4:negative = A<B?1'b1:1'b0;
		endcase
	end
	assign zero = A==B?1'b1:1'b0;
endmodule

module mux2to1_5(A, B, Sel, Out);
	input [4:0] A, B;
	input Sel;
	output [4:0] Out;
	assign Out = (~Sel)?A:
		 (Sel)?B:5'bx;
endmodule

module mux2to1_32(A, B, Sel, Out);
	input [31:0] A, B;
	input Sel;
	output [31:0] Out;
	assign Out = (~Sel)?A:
		 (Sel)?B:32'bx;
endmodule

module Sign_extend_26(Input, Output);
	input [25:0]Input;
	output [31:0]Output;
	assign Output = {6'b0, Input};
endmodule

module Sign_Extend(Input, Output);
	input [15:0] Input;
	output [31:0] Output;
	assign Output = {16'd0, Input};
endmodule

module Shift_Left_2(Input, Output);
	input [31:0]Input;
	output [31:0]Output;
	assign Output = {Input[29:0], 2'd0};
endmodule

module adder_32(A, B, Sum);
	input [31:0]A, B;
	output [31:0]Sum;
	assign Sum = A+B;
endmodule

module Register_File(clk, rst, Read_Reg1, Read_Reg2, Write_Reg, Write_Data, RegWrite, Read1, Read2);
	input [4:0] Read_Reg1, Read_Reg2, Write_Reg;
	input [31:0] Write_Data;
	input RegWrite, clk, rst;
	output [31:0] Read1, Read2;
	reg [0:31][31:0] registers;
	integer n;
	always@(posedge clk, posedge rst)begin
		if(rst)
			for(n=0; n<32; n = n+1)begin
				registers[n] <= 32'b0;
			end
		if(RegWrite)begin
			registers[Write_Reg][31:0] <= Write_Data;
		end
	end
	assign Read1 = registers[Read_Reg1][31:0];
	assign Read2 = registers[Read_Reg2][31:0];
endmodule

module PC(clk, rst, Input, Output);
	input [31:0] Input;
	input clk, rst;
	output [31:0] Output;
	reg [31:0] Output;
	always@(posedge clk)begin
		if(rst) 
			Output <= 32'b0;
		else Output <= Input;
	end
endmodule
