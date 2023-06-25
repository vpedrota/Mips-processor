module ClockManager  #(parameter N_COUNT = 25000000) 
(input reset, input clock, output reg clock_output);

initial

begin
	clock_output = 1;
end

integer count = 1;

always@(posedge clock)
	begin
		if (reset)
		begin
			count <= 0;
			clock_output <= 0;
		end
		else
		begin		
			if (count<N_COUNT)
			begin
				count <= count + 1;
			end
			else begin
				count <= 0;
				clock_output <= ~clock_output;
			end
		end
	end

endmodule