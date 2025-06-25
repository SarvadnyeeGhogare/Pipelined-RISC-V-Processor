module controller(op,func3,func7,result_sgn,memwr_sgn,alu_sgn,imm_sgn,regwr_sgn,alu_main,branch,jump,jalr);
input [6:0] op;
input [2:0] func3;
input func7;
output memwr_sgn,alu_sgn,regwr_sgn,jalr,branch,jump;
output [1:0] result_sgn,imm_sgn;
output [3:0] alu_main;

wire branch,jump;
wire [1:0] alu_wire;

main_decoder md(op,result_sgn,memwr_sgn,alu_sgn,imm_sgn,regwr_sgn,alu_wire,branch,jalr,func3,jump);
alu_decoder ad(op,func3,func7,alu_wire,alu_main);

endmodule
