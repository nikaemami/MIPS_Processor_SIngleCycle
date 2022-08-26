`timescale 1ns/1ns

`define  Add 6'b000001
`define  Sub 6'b000010
`define  And 6'b000100
`define  Or 6'b001000
`define  Slt 6'b010000

`define  R_TYPE 6'd0
`define  Addi 6'd1
`define  Slti 6'd2
`define  Lw 6'd3
`define  Sw 6'd4
`define  Beq 6'd5
`define  J 6'd6
`define  Jr 6'd7
`define  Jal 6'd8

`define RT 2'd0
`define SLA 2'd1
`define SB 2'd2

module ALU_controller(ALUOP, alu_function, ALU_control);
	input [1:0] ALUOP;
	input [5:0] alu_function;
	output [2:0] ALU_control;
	reg [2:0] ALU_control;
	always @(ALUOP, alu_function)begin
		if(ALUOP == `RT)
			case(alu_function)
				`Add:ALU_control = 3'd0;
				`Sub:ALU_control = 3'd1;
				`And:ALU_control = 3'd2;
				`Or:ALU_control = 3'd3;
				`Slt:ALU_control = 3'd4;
			endcase
		else if(ALUOP == `SLA)
			ALU_control = 3'd0;
		else if(ALUOP == `SB)
			ALU_control = 3'd1;
	end
endmodule

module main_controller(ctrl_in, sel_wr_2, sel_wr_1, RegWrite, sel_B, ALUOP, MemRead, MemWrite, MemtoReg, branch, sel_data, sel_pc_1, pc_src, slt_sel);
	input [31:0]ctrl_in;
	output sel_wr_2, sel_wr_1, RegWrite, sel_B, MemRead, MemWrite, MemtoReg, branch, sel_data, sel_pc_1, pc_src, slt_sel;
	output [1:0] ALUOP;
	reg sel_wr_2, sel_wr_1, RegWrite, sel_B, MemRead, MemWrite, MemtoReg, branch, sel_data, sel_pc_1, pc_src, slt_sel;
	reg [1:0] ALUOP;
	always@(ctrl_in) begin
		if(ctrl_in[31:26] == `R_TYPE & ctrl_in[5:0] == `Slt)begin
			{sel_wr_2, sel_wr_1, RegWrite, sel_B, MemRead, MemWrite, branch, pc_src, slt_sel} = 9'b101000001; ALUOP=2'b00;end
		else
			begin{sel_wr_2, sel_wr_1, RegWrite, sel_B, MemRead, MemWrite, MemtoReg, branch, sel_data, pc_src, slt_sel} = 11'b10100000100;ALUOP=2'b00;end
		case(ctrl_in[31:26])
			`Addi:begin{sel_wr_2, sel_wr_1, RegWrite, sel_B, MemRead, MemWrite, MemtoReg, branch, sel_data, pc_src, slt_sel} = 11'b00110000100; ALUOP=2'b01;end
			`Slti:begin{sel_wr_2, sel_wr_1, RegWrite, sel_B, MemRead, MemWrite, MemtoReg, branch, pc_src, slt_sel} = 10'b0011001001;ALUOP=2'b10;end
			`Lw:begin{sel_wr_2, sel_wr_1, RegWrite, sel_B, MemRead, MemWrite, MemtoReg, branch, sel_data, pc_src, slt_sel} = 11'b00111010100;ALUOP=2'b01;end
			`Sw:begin{RegWrite, sel_B, MemRead, MemWrite, branch, pc_src} = 6'b010100;ALUOP=2'b01;end
			`Beq:begin{RegWrite, sel_B, MemRead, MemWrite, branch, pc_src} = 6'b000010;ALUOP=2'b10;end
			`J:begin{RegWrite, MemRead, MemWrite, branch, sel_pc_1, pc_src} = 6'b000011;end
			`Jr:begin{RegWrite, MemRead, MemWrite, branch, sel_pc_1, pc_src} = 6'b000001;end
			`Jal:begin{sel_wr_1, RegWrite, MemRead, MemWrite, branch, sel_data, sel_pc_1, pc_src, slt_sel} = 9'b110000110;end
		endcase
	end
endmodule