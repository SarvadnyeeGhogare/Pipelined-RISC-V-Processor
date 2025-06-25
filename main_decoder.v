module main_decoder(op,result_sgn,memwr_sgn,alu_sgn,imm_sgn,regwr_sgn,alu_wire,branch,jalr,func3,jump);

input [6:0] op;
input [2:0] func3;
output memwr_sgn,alu_sgn,regwr_sgn;
output [1:0] result_sgn,imm_sgn;
output [1:0] alu_wire;
output branch,jalr,jump;

reg [11:0] controls;

always @(*)
begin
case(op)
7'b0000011 : controls = 12'b1_00_1_0_01_00_0_0_0 ; //lw
7'b0100011 : controls = 12'b0_01_1_1_00_00_0_0_0 ; //sw
7'b0110011 : controls = 12'b1_xx_0_0_00_10_0_0_0 ; //r_type
7'b0010011 : controls = 12'b1_00_1_0_00_10_0_0_0 ; //i_type
7'b0110111 : controls = 12'b1_xx_0_0_11_xx_0_0_0 ; //lui 
7'b0010111 : controls = 12'b1_xx_0_0_11_xx_0_0_0 ; //AuiPC
7'b1100111 : controls = 12'b1_00_1_0_10_00_1_0_0 ; // jalr
7'b1101111 : controls = 12'b1_11_0_0_10_00_0_1_0 ; // jal
7'b1100011 : controls = 12'b0_10_0_0_00_01_0_0_1 ; //branch 
default    : controls = 12'b0_00_0_0_00_00_0_0_0 ; // ???
endcase
end


assign {regwr_sgn,imm_sgn,alu_sgn,memwr_sgn,result_sgn,alu_wire,jalr,jump,branch} = controls;

endmodule
