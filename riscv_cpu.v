module riscv_cpu(instr,clk,rst,pc,read_data,wr_data,memwr_sgnm,datamem_rd,datamem_wr,func3m,pcw,alu_resultw,rd_final2w);
input [31:0] instr,read_data;
input clk,rst;
output memwr_sgnm;
output [2:0] func3m;
output [31:0] pc;
output [31:0] datamem_rd,datamem_wr,wr_data,pcw,alu_resultw,rd_final2w;

wire alu_sgn,regwr_sgn,memwr_sgn,branch,jump,jalr;
wire [1:0] result_sgn,imm_sgn;
wire [3:0] alu_main;
wire [31:0] instrd;
wire [31:0] pc_internal;  // internal signal from datapath

controller c(instrd[6:0],instrd[14:12],instrd[30],result_sgn,memwr_sgn,alu_sgn,imm_sgn,regwr_sgn,alu_main,branch,jump,jalr);

datapath dp(clk,rst,regwr_sgn,memwr_sgn,jump,branch,jalr,alu_sgn,imm_sgn,result_sgn,alu_main,instr,read_data,datamem_rd,datamem_wr,
pc_internal,instrd,memwr_sgnm,func3m,wr_data,pcw,alu_resultw,rd_final2w);

assign pc = pc_internal;  // connect datapath pc to module output


endmodule
