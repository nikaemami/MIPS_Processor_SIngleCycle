`timescale 1ns/1ns

module controller(ctrl_in,sel_wr_2, sel_wr_1, RegWrite, sel_B, MemRead, MemWrite, MemtoReg, branch, sel_data, sel_pc_1, pc_src, slt_sel, ALU_control);
	input [31:0] ctrl_in;
	output sel_wr_2, sel_wr_1, RegWrite, sel_B, MemRead, MemWrite, MemtoReg, branch, sel_data, sel_pc_1, pc_src, slt_sel;
	output [2:0] ALU_control;
	wire sel_wr_2, sel_wr_1, RegWrite, sel_B, MemRead, MemWrite, MemtoReg, branch, sel_data, sel_pc_1, pc_src, slt_sel;
	wire [2:0] ALU_control;
	wire [1:0] ALUOP;
	ALU_controller alu_ctrl(ALUOP, ctrl_in[5:0], ALU_control);
	main_controller ctrl(ctrl_in,sel_wr_2, sel_wr_1, RegWrite, sel_B, ALUOP, MemRead, MemWrite, MemtoReg, branch, sel_data, sel_pc_1, pc_src, slt_sel);
endmodule