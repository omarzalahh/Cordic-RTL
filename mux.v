/*
Function
_________
Mux without reg output means only combinational always or assign statment


Mapping
_______
mux # ( .FIXED_POINT())
(
  .in1       ,
  .in2       ,
  .selection ,
  .output_mux
);


*/


module  mux # (parameter FIXED_POINT=16)
  (
    input     wire          [FIXED_POINT-1:0]     in1       ,
    input     wire          [FIXED_POINT-1:0]     in2       ,
    input     wire                                selection ,
    output    wire           [FIXED_POINT-1:0]     output_mux
  );
  
  assign output_mux = selection?  in2:in1;
  /*
  always@(*)
  begin
    if(selection)
      begin
        output_mux  = in2;
      end
    else
      begin
        output_mux = in1;
      end
  end
  */
endmodule
