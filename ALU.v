module ALU(
		input [3:0] ALU_ctr, 
		input [31:0] data1, data2, 
		output Zero, 
		output reg [31:0] ALU_output);

 always @ (data1,data2,ALU_ctr)
 begin
    case(ALU_ctr)
		  4'd0: ALU_output <= data1&data2;
		  4'd1: ALU_output <= data1|data2;
		  4'd2: ALU_output <= data1+data2;
		  4'd3: ALU_output <= (data1!=data2) ? 0: 1;
		  4'd4: ALU_output <= (data1>data2) ? 0: 1;
		  4'd4: ALU_output <= (data1<data2) ? 0: 1;
		  4'd6: ALU_output <= data1-data2;
		  4'd7: ALU_output <= data1<data2 ? 1:0;
		  4'd12:ALU_output <= ~(data1|data2);
		  4'd8: ALU_output <= data1*data2;
		  4'd9: ALU_output <= data1/data2;
		  default: ALU_output <= 0;
  endcase
 end
 
 assign Zero = (ALU_output==0);
endmodule