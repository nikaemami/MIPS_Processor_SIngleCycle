`timescale 1ns/1ns

module MIPS(clk, rst, inst_out, MD_out, alu_out, pc_out, Read2, MemRead, MemWrite);
	input [31:0] inst_out, MD_out;
	input clk, rst;
	output [31:0] alu_out, pc_out, Read2;
	output MemRead, MemWrite;
	wire [31:0] alu_out, pc_out, Read2;
	wire [2:0] ALU_control;
	wire sel_wr_2, sel_wr_1, RegWrite, sel_B, MemtoReg, branch, sel_data, sel_pc_1, pc_src, slt_sel, MemRead, MemWrite;
	datapath DP(MD_out, sel_wr_2, sel_wr_1, RegWrite, sel_B, ALU_control, MemtoReg, branch, sel_data, sel_pc_1, pc_src, clk, rst, inst_out, slt_sel, alu_out, pc_out, Read2);
	controller CT(inst_out,sel_wr_2, sel_wr_1, RegWrite, sel_B, MemRead, MemWrite, MemtoReg, branch, sel_data, sel_pc_1, pc_src, slt_sel, ALU_control);
endmodule