module pl_reg_de(clk,func3d,instr_lui_d,instr_auipc_d,func3e,instr_lui_e,instr_auipc_e,regwr_sgnd,result_sgnd,memwr_sgnd,jumpd,branchd,jalrd,alu_maind,alu_sgnd,rd_data1d,rd_data2d,pcd,rd_addr1d,rd_addr2d,wr_addrd,imm_extd,pc_4d,flushe,regwr_sgne,result_sgne,memwr_sgne,jumpe,branche,jalre,alu_maine,alu_sgne,rd_data1e,rd_data2e,pce,rd_addr1e,rd_addr2e,wr_addre,imm_exte,pc_4e);
				  
input clk,flushe;
input regwr_sgnd,memwr_sgnd,jumpd,branchd,jalrd,alu_sgnd;
input [1:0] result_sgnd;
input [3:0] alu_maind;
input [4:0] rd_addr1d,rd_addr2d,wr_addrd;
input [31:0] rd_data1d,rd_data2d,pcd,imm_extd,pc_4d;

output reg regwr_sgne,memwr_sgne,jumpe,branche,jalre,alu_sgne;
output reg [1:0] result_sgne;
output reg [3:0] alu_maine;
output reg [4:0] rd_addr1e,rd_addr2e,wr_addre;
output reg [31:0] rd_data1e,rd_data2e,pce,imm_exte,pc_4e;

input [2:0] func3d;
input [31:0] instr_lui_d; // instr[31:12]
input instr_auipc_d ;      //instr[5]

output reg [2:0] func3e;
output reg [31:0] instr_lui_e; 
output reg instr_auipc_e ; 

initial 
begin
{func3e,instr_lui_e,instr_auipc_e,regwr_sgne,result_sgne,memwr_sgne,jumpe,branche,jalre,alu_maine,alu_sgne,rd_data1e,rd_data2e,pce,rd_addr1e,rd_addr2e,wr_addre,imm_exte,pc_4e } = 0 ;
end

always@(posedge clk)
begin
if( flushe )
begin 
{func3e,instr_lui_e,instr_auipc_e,regwr_sgne,result_sgne,memwr_sgne,jumpe,branche,jalre,alu_maine,alu_sgne,rd_data1e,rd_data2e,pce,rd_addr1e,rd_addr2e,wr_addre,imm_exte,pc_4e } <= 0 ;
end
else
begin
{func3e,instr_lui_e,instr_auipc_e,regwr_sgne,result_sgne,memwr_sgne,jumpe,branche,jalre,alu_maine,alu_sgne,rd_data1e,rd_data2e,pce,rd_addr1e,rd_addr2e,wr_addre,imm_exte,pc_4e } <= {func3d,instr_lui_d,instr_auipc_d,regwr_sgnd,result_sgnd,memwr_sgnd,jumpd,branchd,jalre,alu_maind,alu_sgnd, rd_data1d,rd_data2d,pcd,rd_addr1d,rd_addr2d,wr_addrd,imm_extd,pc_4d } ;
end
end

endmodule
