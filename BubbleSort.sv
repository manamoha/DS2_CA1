module bubbleSort(
	input clk,
	input rst,
	input start,
	output done
);

	wire initCnt1, enCnt1, ldCnt2, enCnt2, co1, co2, selInd, rd, wr, ldR1, ldR2, lt, selWr;
	wire [4:0] Index1,Index1_pluse1, Index2, addr;
	wire [7:0] InData, OutData, R1Out, R2Out;	

	
	Counter1 C1(clk, , initCnt1, enCnt1, , co1, Index1);
	Add1 A1(Index1, Index1_pluse1);
	Counter2 C2(clk, ldCnt2, ,enCnt2, Index1_pluse1, co2, Index2);
	Mux #(5) M1(selInd, Index1, Index2, addr);
	Memory mem(clk, rd, wr, InData, addr,OutData);
	Reg R1(clk, ldR1, OutData, R1Out);
	Reg R2(clk, ldR2, OutData, R2Out);
	Comp cmp(R1Out, R2Out, lt);
	Mux #(8) M2(selWr, R1Out, R2Out, InData);
	Controller ctrl(clk, start, lt, co1, co2, initCnt1, ldCnt2, enCnt1, enCnt2, selInd, ldR1, ldR2, wr, rd, selWr, done);
	
endmodule
