`timescale 1ns/1ns

module DataMem(clk, Adr, Write_Data, MemRead, MemWrite, Read_Data);
	input [31:0] Adr, Write_Data;
	input clk, MemRead, MemWrite;
	output [31:0] Read_Data;
	reg [31:0] Read_Data;
	reg [31:0] Memory[1000:2005];
	initial begin
		$readmemb("data_mem.txt", Memory, 32'd1000);
	end
	always@(posedge clk)begin
		if(MemWrite)begin
			Memory[Adr] <= Write_Data;
		end
	end
	assign Read_Data = MemRead?Memory[Adr]:Read_Data;
	
endmodule

module InstMem(Adr, Instruction);
	input [31:0] Adr;
	output [31:0] Instruction;
	reg [31:0] Instruction;
	reg [31:0] R[0:60];
	initial begin
		$readmemb("Inst_data.txt", R);
	end
	assign Instruction = R[Adr];
endmodule

module TB_MIPS();
	reg clk=0, rst=0;
	wire [31:0] alu_out, pc_out, Read2, inst_out, MD_out;
	wire MemRead, MemWrite;
	DataMem Memory_data(clk, alu_out, Read2, MemRead, MemWrite, MD_out);
	InstMem Instruct(pc_out, inst_out);
	MIPS mip(clk, rst, inst_out, MD_out, alu_out, pc_out, Read2, MemRead, MemWrite);
	always #20 clk<=~clk;
	initial begin
		rst=1;
		#21 rst=0;
		#6700 $stop;
	end
endmodule
