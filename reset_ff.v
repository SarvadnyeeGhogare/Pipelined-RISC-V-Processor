module reset_ff(in,clk,rst,clr,out);          //d_ff
input [31:0] in;
input clk,rst,clr;
output reg [31:0] out;

initial begin
out = 0;
end

always@(posedge clk)
begin
if(rst) out <= 32'd0;
else if(! clr) out <= in;
end

endmodule
