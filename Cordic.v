//fixed 14 2 for deciaml and 12 for fractional
//The atan is 17 fixed , 16 for fractional and 1 for deciaml

/*
Function
_________
Cordic is to change point to another point using angler phase 
x_new = x_old*cos(ceta) - y_old*sin(ceta);
y_new = y_old*cos(ceta) + x_old*sin(ceta);

but we dont have the duribality to take all that angles
so we will take another way take cos ceta comman and the tan we will remove it and but 2^-i after some nuymber of ireteration we will reach our value

x_new = x_old - d* y_old*2^-i;
y_new = y_old + d x_old*2^-i;


--------------------------------------------
Mapping
________

Cordic  (.FIXED_POINT())    Instance Name
(
.clk        (  )         ,
.rst        (  )         ,
.theta_rad  (  )         ,
.data_in_x  (  )         ,
.data_in_y  (  )         ,
.enable_in  (  )         ,
.load_data  (  )         ,
.Shift_value(  )         ,
.data_out_x (  )         ,
.data_out_y (  )      
);

*/
module  Cordic  #(parameter FIXED_POINT =14)
(
input             wire                        clk         ,
input             wire                        rst         ,
input       wire signed   [16:0]   theta_rad   ,
input       wire signed   [FIXED_POINT-1:0]   data_in_x   ,
input       wire signed   [FIXED_POINT-1:0]   data_in_y   ,
input             wire                        enable_in   ,
input             wire                        load_data   ,
input             wire    [3:0]               Shift_value ,
output      wire signed   [FIXED_POINT-1:0]   data_out_x  ,
output      wire signed   [FIXED_POINT-1:0]   data_out_y  
);
//Internal Signals for mapping
  wire signed  [16:0]   z;
  wire  signed [16:0]             tan_internal;
  wire  signed [16:0]             tan_alu;
  wire  signed [16:0]             tan_reg;
  wire  signed [FIXED_POINT-1:0]  x_internal;
  wire  signed [FIXED_POINT-1:0]  x_outreg;
  wire  signed [FIXED_POINT-1:0]  x_outshift;
  wire  signed [FIXED_POINT-1:0]  y_internal;   
  wire  signed [FIXED_POINT-1:0]  y_outreg;  
  wire  signed [FIXED_POINT-1:0]  y_outshift;  

atan  #(.FIXED_POINT(17) ,.DEPTH_ITERATION (15))  U0_atan
(
 .address(Shift_value),         
 .output_rom(z)
);

/*
Angle
______
*/
mux # ( .FIXED_POINT(17))  U0_MUX_tan
  (
    .in1       (theta_rad),
    .in2       (tan_alu),
    .selection (load_data),
    .output_mux (tan_internal)
  );
  Register  #( .FIXED_POINT(17)) U0_REG_tan
  (
  .clk         (clk)  ,
  .rst         (rst)  ,
  .input_data  (tan_internal)  ,
  .enable (enable_in),
  .output_data (tan_reg)            
  );
  
  ALU #(.FIXED_POINT (17)) U0_ALU_tan
(
.OPERAND_A  (tan_reg),
.OPERAND_B  (z),
.ADD_SUB    (~tan_reg[16]),
.ALU_OUT    (tan_alu)
);


//For x  data
mux # ( .FIXED_POINT(FIXED_POINT))  U0_MUX_X
(
  .in1       (data_in_x),
  .in2       (data_out_x),
  .selection (load_data),
  .output_mux (x_internal)
);
Register  #( .FIXED_POINT(FIXED_POINT)) U0_REG_X
(
  .clk         (clk)  ,
  .rst         (rst)  ,
  .input_data  (x_internal)  ,
  .enable (enable_in),
  .output_data (x_outreg)            
);  
Shift_Reg #(.FIXED_POINT (FIXED_POINT)) U0_ShiftReg_x
(
  .input_data (x_outreg),
  .shift_value(Shift_value),
  .output_shift(x_outshift)
);
ALU #(.FIXED_POINT (FIXED_POINT)) U0_ALU_X
(
  .OPERAND_A  (x_outreg),
  .OPERAND_B  (y_outshift),
  .ADD_SUB    (~tan_reg[16]),
  .ALU_OUT    (data_out_x)
);


//For y  data
  mux # ( .FIXED_POINT(FIXED_POINT))  U0_MUX_y
  (
    .in1       (data_in_y),
    .in2       (data_out_y),
    .selection (load_data),
    .output_mux (y_internal)
  );
Register  #( .FIXED_POINT(FIXED_POINT)) U0_REG_y
  (
  .clk         (clk)  ,
  .rst         (rst)  ,
  .input_data  (y_internal)  ,
  .enable (enable_in),
  .output_data (y_outreg)            
  );
  
  Shift_Reg #(.FIXED_POINT (FIXED_POINT)) U0_ShiftReg_y
  (
  .input_data (y_outreg),
  .shift_value(Shift_value),
  .output_shift(y_outshift)
  );
  
  ALU #(.FIXED_POINT (FIXED_POINT)) U0_ALU_y
(
.OPERAND_A  (y_outreg),
.OPERAND_B  (x_outshift),
.ADD_SUB    (tan_reg[16]),
.ALU_OUT    (data_out_y)
);


endmodule
