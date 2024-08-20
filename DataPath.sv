//5 bit counter
module Counter1(input clk, ld, init, EnCnt,input [4:0] PI, output logic co, output logic [4:0] PO);
	logic [5:0] cnt = 5'b0;

	always @(posedge clk) begin
		if(init)
			cnt <=5'b0;
		if(ld)
			cnt <= PI;
		else if(EnCnt) 
			cnt <= cnt +1;
	end
	assign co = &{cnt[4:0]};
	assign PO = cnt[4:0];
endmodule



module Counter2(input clk, ld, init, EnCnt,input [4:0] PI, output logic co, output logic [4:0] PO);
	logic [5:0] cnt = 5'b0;

	always @(posedge clk) begin
		if(init)
			cnt <=5'b0;
		if(ld)
			cnt <= PI;
		else if(EnCnt) 
			cnt <= cnt +1;
	end
	assign co = cnt[5];
	assign PO = cnt[4:0];
endmodule


//8 bit register
module Reg(input clk, ld, input [7:0] InData, output logic[7:0] OutData);
	always @(posedge clk) begin
		if(ld) OutData <= InData;
	end 
endmodule



//8 bit comparator
module Comp (input [7:0] a, b, output lt);
	assign lt = (a<b)? 1 : 0;
endmodule



//memory
// module Memory(input clk, rst, rd, wr, input [4:0] adr, input [7:0] InData, output logic [7:0] OutData);
// 	logic [7:0] mem [31:0];

// 	always @(posedge clk)begin
// 		if(wr) mem[adr] <= InData;
// 	end

// 	always @(posedge clk)begin
// 		if(rd) OutData <= mem[adr];
// 	end
// endmodule



//2 to 1 mux
module Mux #(parameter BIT_SIZE) (input sel, input [BIT_SIZE-1 : 0] in1, in2, output [BIT_SIZE-1 : 0] out);
	assign out = (~sel) ? in1 : in2 ;
endmodule

//add +1
module Add1 (input [4:0] inp, output [4:0] out);
	assign out = inp + 1;
endmodule










