module pl_reg_em(clk,func3e,aui_lui_resulte,regwr_sgne,result_sgne,memwr_sgne,wr_addre,pce,pc_4e,alu_resulte,rd_final2e,
                     func3m,aui_lui_resultm,regwr_sgnm,result_sgnm,memwr_sgnm,wr_addrm,pcm,pc_4m,alu_resultm,rd_final2m);
input clk;
input regwr_sgne,memwr_sgne;
input [1:0] result_sgne;
input [2:0] func3e;
input [4:0] wr_addre;
input [31:0] pc_4e,pce,alu_resulte,rd_final2e;
input [31:0] aui_lui_resulte;

output reg regwr_sgnm,memwr_sgnm;
output reg [1:0] result_sgnm;
output reg [2:0] func3m;

output reg [4:0] wr_addrm;
output reg [31:0] pc_4m,pcm,alu_resultm,rd_final2m;
output reg [31:0] aui_lui_resultm;

							
initial 
begin
{ func3m,aui_lui_resultm,regwr_sgnm,result_sgnm,memwr_sgnm,wr_addrm,pcm,pc_4m,alu_resultm,rd_final2m } = 0;
end


always@(posedge clk)
begin
{ func3m,aui_lui_resultm,regwr_sgnm,result_sgnm,memwr_sgnm,wr_addrm,pcm,pc_4m,alu_resultm,rd_final2m } <=  { func3e,aui_lui_resulte,regwr_sgne,result_sgne,memwr_sgne,wr_addre,pce,pc_4e,alu_resulte,rd_final2e };
end
endmodule
