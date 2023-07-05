module MUX_3 #(parameter N = 32) (
	input [N - 1: 0] data1, data2, data3,
	input [1:0] flag, 
	output [N - 1: 0] data_out
);

	 assign data_out = (flag == 2'b00) ? data1 :
                      (flag == 2'b01) ? data2 :
                                           data3;

endmodule