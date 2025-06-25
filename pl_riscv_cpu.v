module pl_riscv_cpu(clk,rst,ext_memwr_sgn,ext_datamem_wr,ext_datamem_rd,datamem_rd,datamem_wr,memwr_sgn,read_data,wr_data,pcw,alu_resultw,rd_final2w);
input clk,rst;
input ext_memwr_sgn;
input [31:0] ext_datamem_wr,ext_datamem_rd;
output memwr_sgn;
output [31:0] datamem_rd,datamem_wr,read_data,wr_data,pcw,alu_resultw,rd_final2w;

 
wire [31:0] instr,pc;
wire [2:0] store,func3m;
wire memwr_sgn_cpu;
wire [31:0] datamem_rd_cpu,datamem_wr_cpu;

riscv_cpu rc1(instr,clk,rst,pc,read_data,wr_data,memwr_sgn_cpu,datamem_rd_cpu,datamem_wr_cpu,func3m,pcw,alu_resultw,rd_final2w);
instr_mem im(pc,instr);
data_mem dm(clk, memwr_sgn,store,datamem_rd, datamem_wr,read_data);

assign store = (ext_memwr_sgn && rst) ? 3'b010 : func3m;
assign memwr_sgn = (ext_memwr_sgn && rst) ? 1 : memwr_sgn_cpu ;
assign datamem_wr = (ext_memwr_sgn && rst) ? ext_datamem_wr : datamem_wr_cpu ;
assign datamem_rd = rst ? ext_datamem_rd : datamem_rd_cpu;

endmodule
