module Left2_26(data,odata);
 input [25:0] data;
 output reg [27:0] odata;
 
 always @(data)
 begin
		odata[27:2]<=data[25:0];
		odata[1:0]<=2'b00;
 end
endmodule