module Memory(
  input clk, rd, wr,
  input [7:0] WriteData,
  input [4:0] adr,
  output [7:0] ReadData
);
  
  
  
  
  //memory declarations
  reg [7:0] memData[0:31];
  reg [7:0] outReg;

  integer i;

  initial begin
    for(i = 0; i < 32; i = i+1)
      //memData[i] = 16'b0; 
      $readmemb( "mem_data.txt" ,memData,0 ,31 );   
  end

  always @(posedge clk)
    begin
        if(clk == 1'b1)
        begin
          if(wr == 1'b1)
            begin
              memData[adr] = WriteData;
              $writememb("mem_data.txt",memData,0 ,31);
            end
      
        end
      
    end

  always @(posedge rd, adr) // Async read
  begin
    if(rd == 1'b1) 
      begin
        outReg = memData[adr];
      end
  end
  
  assign ReadData =  outReg;

endmodule




