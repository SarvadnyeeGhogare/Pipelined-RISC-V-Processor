module pl_reg_fd(instrf,instrd,pcf,pcd,pc_4f,pc_4d,stalld,flushd,clk);
input [31:0] instrf,pcf,pc_4f;
input stalld,flushd,clk;
output reg [31:0] instrd,pcd,pc_4d;

initial
begin
instrd = 0;
pcd = 0;
pc_4d = 0 ;
end

always@(posedge clk)
begin
if( flushd ) 
begin
instrd <= 0;
pcd <= 0;
pc_4d <= 0 ;
end 

else if ( ! stalld )
begin
instrd <= instrf;
pcd <= pcf ;
pc_4d <= pc_4f ;
end

end
endmodule

