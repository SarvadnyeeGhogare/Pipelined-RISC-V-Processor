module branching_unit (
    input [2:0] func3,
    input       zero,
	 input [31:0] alu_result,
    output reg  branch
);

initial begin
    branch = 1'b0;
end

always @(*) begin
    casez (func3)
        3'b0?0: branch =    zero; 
        3'b0?1: branch =   !zero; 
        3'b1?1: branch =   !alu_result[31];
		  3'b1?0: branch =    alu_result[31]; 
		  
        default: branch = 1'b0;
    endcase
end

endmodule
