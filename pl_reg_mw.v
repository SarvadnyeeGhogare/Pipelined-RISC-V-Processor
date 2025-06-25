module pl_reg_mw(clk,regwr_sgnm,result_sgnm,alu_resultm,read_datam,wr_addrm,pcm,pc_4m,rd_final2m,aui_lui_resultm,regwr_sgnw,result_sgnw,alu_resultw,read_dataw,wr_addrw,pcw,pc_4w,rd_final2w,aui_lui_resultw);
input clk;
input regwr_sgnm;
input [1:0] result_sgnm;
input [4:0] wr_addrm;
input [31:0] alu_resultm,read_datam,pcm,pc_4m,rd_final2m,aui_lui_resultm;

output reg regwr_sgnw;
output reg [1:0] result_sgnw;
output reg [4:0] wr_addrw;
output reg [31:0] alu_resultw,read_dataw,pcw,pc_4w,rd_final2w,aui_lui_resultw;

initial
begin
{ regwr_sgnw,result_sgnw,alu_resultw,read_dataw,wr_addrw,pcw,pc_4w,rd_final2w,aui_lui_resultw } =0;
end

always@(posedge clk)
begin
{ regwr_sgnw,result_sgnw,alu_resultw,read_dataw,wr_addrw,pcw,pc_4w,rd_final2w,aui_lui_resultw } <= { regwr_sgnm,result_sgnm,alu_resultm,read_datam,wr_addrm,pcm,pc_4m,rd_final2m,aui_lui_resultm };
end

endmodule


