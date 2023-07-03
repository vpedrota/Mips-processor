module MUX_2
#(parameter N = 32) 
(input [N - 1: 0] data1, data2, input flag, output [N - 1: 0] data_out);

	assign data_out = (flag == 0) ? data1 : data2;

endmodule