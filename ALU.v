/*
Function
_______
It's for add and subtract operand A and operand B depends on the signal add or sub to make equation x-(d)y*2^-i
                                                                                                    y+(d)x*2^-i
d is the sign of the new angle shift we did try to go back to the point we need to go to
-------------------------------------------------------------------------------------------------------------------

Mapping
_______
  ALU #(.FIXED_POINT ())
(
.OPERAND_A  (   ),
.OPERAND_B  (   ),
.ADD_SUB    (   ),
.ALU_OUT    (   )
);

*/
module  ALU #(parameter FIXED_POINT =16)
(
input   wire      [FIXED_POINT-1:0]    OPERAND_A  ,
input   wire      [FIXED_POINT-1:0]    OPERAND_B  ,
input   wire                           ADD_SUB    ,
output  reg      [FIXED_POINT-1:0]    ALU_OUT  
);
//wire       [FIXED_POINT-1:0]     registeroutput;

always @(*)
begin
  if(ADD_SUB)
    ALU_OUT=OPERAND_A-OPERAND_B;
  else
    ALU_OUT=OPERAND_A+OPERAND_B;
end

//assign ALU_OUT =(enable)?  registeroutput:'b0;



endmodule

