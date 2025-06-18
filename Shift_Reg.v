/*
  Shift_Reg #(.FIXED_POINT ())
  (
  .input_data ,
  .shift_value,
  .output_shift
  );

*/

module  Shift_Reg #(parameter FIXED_POINT =16)
  (
  input     wire    [FIXED_POINT-1:0]    input_data ,
  input     wire    [3:0]                shift_value,
  output    wire    [FIXED_POINT-1:0]      output_shift
  );
  assign  output_shift  = (input_data >>> shift_value);
  
endmodule
