module hazard_unit
(input[4:0] Rs1D,Rs2D,RdE,Rs2E,Rs1E,
input pc_sgne,
input [1:0] result_sgne,
input[4:0] RdM,RdW,
input regwr_sgnm,regwr_sgnw,
output  stallf,stalld,flushd,flushe,
output[1:0] fwd1e,fwd2e);


        assign fwd1e = (((Rs1E==RdM)&& regwr_sgnm )&&(Rs1E !=0))?2'b10:(((Rs1E==RdW) && regwr_sgnw )&& (Rs1E !=0))?2'b01:2'b00;    //for forwarding when regiter to read is not written yet so take it from that stage where it is available i.e memory or write
        assign fwd2e = (((Rs2E==RdM)&& regwr_sgnm )&&(Rs2E !=0))?2'b10:(((Rs2E==RdW) && regwr_sgnw )&& (Rs2E !=0))?2'b01:2'b00;
        wire lwstall;
        assign lwstall   = (result_sgne[0]) && ((Rs1D==RdE)||(Rs2D==RdE)); //for load as load instr takes too time to write value in register so , not available to read, incase if we want to read that reg so stall it, ie hold up operation until data is availabel
        assign stallf    = lwstall;
        assign stalld    = lwstall;
        assign flushd    = pc_sgne;                                       //for branch to wash out the variables in d and e stage
        assign flushe    = lwstall || pc_sgne;                      


endmodule
