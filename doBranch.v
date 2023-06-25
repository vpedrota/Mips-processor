module doBranch(
		zero, 
		flag,
		out
	);
	
	output out;
	input zero, flag;
	
	assign out = zero & flag;


endmodule