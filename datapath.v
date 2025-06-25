module datapath(clk,rst,regwr_sgnd,memwr_sgnd,jumpd,branchd,jalrd,alu_sgnd,imm_sgnd,result_sgnd,alu_maind,instrf,read_datam,datamem_rd,datamem_wr,pcf,instrd,memwr_sgnm,func3m,wr_dataw,pcw,alu_resultw,rd_final2w);
input clk,rst;
input regwr_sgnd,memwr_sgnd,jumpd,branchd,jalrd,alu_sgnd;
input [1:0] result_sgnd,imm_sgnd;
input [3:0] alu_maind;
input [31:0] read_datam,instrf;
output memwr_sgnm;
output [2:0] func3m;
output [31:0] datamem_rd,datamem_wr,pcf,instrd,wr_dataw,pcw,alu_resultw,rd_final2w;

//fetch stage
wire pc_sgne,stallf,stalld,flushd;
wire [31:0] pc_4f,pc_imme,pc_nextf,alu_resulte,pc_jalrf,pcd,pc_4d;
//decode stage
wire regwr_sgnw,flushe,regwr_sgne,memwr_sgne,jumpe,branche,jalre,alu_sgne,instr_auipc_e;
wire [1:0] result_sgne;
wire [2:0] func3e;
wire [3:0] alu_maine;
wire [4:0] wr_addrw,rd_addr1e,rd_addr2e,wr_addre;
wire [31:0] rd_data1d,rd_data2d,imm_extd,rd_data1e,rd_data2e,pce,imm_exte,pc_4e,instr_lui_e;
wire [31:0] instr_lui_d;
assign instr_lui_d = {instrd[31:12],12'b0} ;
//execute stage
wire [1:0] fwd1e,fwd2e;
wire zeroe,regwr_sgnm,takebranche;
wire [1:0] result_sgnm;
wire [4:0] wr_addrm;
wire [31:0] rd_final1e,rd_temp_final2e,rd_final2e,pc_lui_auipc,aui_lui_resulte,aui_lui_resultm,pc_4m,pcm,alu_resultm,rd_final2m;
//memory_write stage
wire [1:0] result_sgnw;
wire [31:0] read_dataw,pc_4w,aui_lui_resultw;


//start

//fetch stage

mux2 m2_1(pc_4f,pc_imme,pc_sgne,pc_nextf);                              
mux2 m2_2(pc_nextf,alu_resulte,jalre,pc_jalrf);                          
reset_ff rf(pc_jalrf,clk,rst,stallf,pcf);                               
adder a1(pcf,32'd4,pc_4f);     

pl_reg_fd plfd(instrf,instrd,pcf,pcd,pc_4f,pc_4d,stalld,flushd,clk);   
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//decode stage

reg_file rf1(clk,regwr_sgnw,instrd[19:15],instrd[24:20],wr_addrw,rd_data1d,rd_data2d,wr_dataw);      

pl_reg_de plde(clk,instrd[14:12],instr_lui_d,instrd[5],func3e,instr_lui_e,instr_auipc_e,
regwr_sgnd,result_sgnd,memwr_sgnd,jumpd,branchd,jalrd,alu_maind,alu_sgnd,rd_data1d,rd_data2d,pcd,instrd[19:15],instrd[24:20],instrd[11:7],imm_extd,pc_4d,flushe,
regwr_sgne,result_sgne,memwr_sgne,jumpe,branche,jalre,alu_maine,alu_sgne,rd_data1e,rd_data2e,pce,rd_addr1e,rd_addr2e,wr_addre,imm_exte,pc_4e);


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//execute stage

mux3 m3_1(rd_data1e,wr_dataw,alu_resultm,fwd1e,rd_final1e);                 
mux3 m3_2(rd_data2e,wr_dataw,alu_resultm,fwd2e,rd_temp_final2e);                
mux2 m2_3(rd_temp_final2e,imm_exte,alu_sgne,rd_final2e);                    

alu a5(rd_final1e,rd_final2e,alu_maine,alu_resulte,zeroe);               

adder a2(pce,imm_exte,pc_imme);                                              

adder ad3( instr_lui_e , pce , pc_lui_auipc) ;                               //{instr[31:12],12'b0} = instr_lui_e
mux2 mx2_3( pc_lui_auipc , instr_lui_e   ,instr_auipc_e, aui_lui_resulte );  //instr[5] =instr_auipc_e

branching_unit bu(func3e,zeroe, alu_resulte,takebranche);                    
assign pc_sgne = ((branche && takebranche) || jumpe || jalre) ? 1'b1 : 1'b0;

pl_reg_em plem(clk,func3e,aui_lui_resulte,regwr_sgne,result_sgne,memwr_sgne,wr_addre,pce,pc_4e,alu_resulte,rd_temp_final2e,
                   func3m,aui_lui_resultm,regwr_sgnm,result_sgnm,memwr_sgnm,wr_addrm,pcm,pc_4m,alu_resultm,rd_final2m);

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
							
//memory_write stage

pl_reg_mw plmw(clk,regwr_sgnm,result_sgnm,alu_resultm,read_datam,wr_addrm,pcm,pc_4m,rd_final2m,aui_lui_resultm,
                   regwr_sgnw,result_sgnw,alu_resultw,read_dataw,wr_addrw,pcw,pc_4w,rd_final2w,aui_lui_resultw);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////

//write_back stage

mux4 m4(alu_resultw,read_dataw,pc_4w,aui_lui_resultw,result_sgnw,wr_dataw);

////////////////////////////////////////////////////////////////////////////////////////////////////////////

hazard_unit hu(instrd[19:15],instrd[24:20],wr_addre,rd_addr2e,rd_addr1e,pc_sgne,result_sgne,wr_addrm,wr_addrw,regwr_sgnm,regwr_sgnw,stallf,stalld,flushd,flushe,fwd1e,fwd2e);


//////////////////////////////////////////////////////////////////////////////////////////


assign datamem_rd= alu_resultm;
assign datamem_wr= rd_final2m;

endmodule
