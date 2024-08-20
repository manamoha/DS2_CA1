module Controller(input clk, start, lt, co1, co2, output logic initCnt1, ldCnt2, enCnt1, enCnt2, selInd, ldR1, ldR2, wr, rd, selWr, done);
    
    logic[3:0] ps, ns;
    parameter[3:0] idle = 4'd0, InitCounter1 = 4'd1, InitCounter2 = 4'd2, ChooseIndex1 = 4'd3,
    LoadR1 = 4'd4, ChooseIndex2 = 4'd5, LoadR2 = 4'd6, Comperator = 4'd7, Write1 = 4'd8,
    Write2 = 4'd9, Counter2 = 4'd10, GenCarry2 = 4'd11, Counter1 = 4'd12, GenCarry1 = 4'd13, DoneState = 4'd14 ;


    always @(posedge clk)begin
        ps <= ns;
    end

    always @(start, co1, co2, ps,lt)begin
        case(ps)
            idle : ns <= start ? InitCounter1 : idle;
            InitCounter1 : ns <= InitCounter2;
            InitCounter2 : ns <= ChooseIndex1;
            ChooseIndex1 : ns <= LoadR1;
            LoadR1 : ns <= ChooseIndex2;
            ChooseIndex2 : ns <= LoadR2;
            LoadR2 : ns <= Comperator;
            Comperator: ns <= lt ? Write1 : Counter2;
            Write1 : ns <= Write2;
            Write2 : ns <= Counter2;
            Counter2 : ns <= GenCarry2;
            GenCarry2 : ns <= co2 ? Counter1 : ChooseIndex1;
            Counter1 : ns <= GenCarry1;
	    GenCarry1 : ns <= co1 ? DoneState : InitCounter2;
            DoneState : ns <= idle;
	    default: ns <= idle;
        endcase
    end

    always @(start, co1, co2, ps,lt)begin
        initCnt1<=0; ldCnt2<=0; enCnt1<=0; enCnt2<=0; ldR1<=0; ldR2<=0; wr<=0; rd<=0; done<=0;

        case(ns)

            InitCounter1 : initCnt1 <= 1;
            InitCounter2 : ldCnt2 <= 1;
            ChooseIndex1 : begin
                selInd <= 0;
                rd <= 1;
            end
            LoadR1 : ldR1 <= 1;
            ChooseIndex2 : begin
                selInd <= 1;
		rd <= 1;
                //ldR1 <= 0;
            end
            LoadR2 : ldR2 <= 1;
            Write1 : begin
                wr <= 1;
                selWr <= 0;
            end
            Write2 : begin
		wr <= 1;
                selInd <= 0;
                selWr <= 1;
            end
            Counter2 : begin
                rd <= 1;
                //wr <= 0;
                enCnt2 <= 1;
            end
            Counter1 : enCnt1 <= 1;
            DoneState : done <= 1;
        endcase
    end
endmodule