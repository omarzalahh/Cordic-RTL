/*
Function
__________
Reg the data to pervent combinational loob

Mapping
_______
Register  #(.FIXED_POINT ())  Instance Name
(
  .clk          (   )           ,
  .rst          (   )           ,
  .input_data   (   )           ,
  .enable       (   )           ,
  .output_data  (   )            
);
  
*/



module  Register  #(parameter FIXED_POINT =16  )
  (
  input     wire                      clk           ,
  input     wire                      rst           ,
  input     wire  [FIXED_POINT-1:0]   input_data    ,
  input     wire                      enable        ,
  output    reg   [FIXED_POINT-1:0]   output_data             
  );
  
  always@(posedge clk or negedge rst)
  begin
    if(!rst)
      begin
        output_data <=  'b0;
      end
    else
      begin
        if(enable)
        output_data <=  input_data; 
        else
          output_data <=  output_data;
      end
      
    
  end
endmodule