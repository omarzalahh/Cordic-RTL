/*
Function
_________
Rom for saving 15 number of iretrations of the tanceta ...2^-i

Mapping :
_________


atan  #(.FIXED_POINT() ,.DEPTH_ITERATION ())  Instance Name
(
 .address(),         
 .output_rom()
);
  
*/

module  atan  #(parameter FIXED_POINT  =17 ,//1 decimal and 16 for fixed
                          DEPTH_ITERATION =15)
(
 input      wire     [3:0]               address ,         
 output     wire     [FIXED_POINT-1:0]   output_rom
);
  
  wire [FIXED_POINT-1:0] Arc_Tan_Table [DEPTH_ITERATION-1:0];
  
    assign     Arc_Tan_Table[0] = 'b01100100100010000;  //(45/360)*2^17 , Note the stored values are in Q(17,17), Note: the values are normalized
    assign     Arc_Tan_Table[1] = 'b00111011010110010;
    assign     Arc_Tan_Table[2] = 'b00011111010110111;
    assign     Arc_Tan_Table[3] = 'b00001111111010110;
    assign     Arc_Tan_Table[4] = 'b00000111111111011;
    assign     Arc_Tan_Table[5] = 'b00000011111111111;
    assign     Arc_Tan_Table[6] = 'b00000010000000000;
    assign     Arc_Tan_Table[7] = 'b00000001000000000;
    assign     Arc_Tan_Table[8] = 'b00000000100000000;
    assign     Arc_Tan_Table[9] = 'b00000000010000000;
    assign     Arc_Tan_Table[10] = 'b00000000001000000;
    assign     Arc_Tan_Table[11] = 'b00000000000100000;
    assign     Arc_Tan_Table[12] = 'b00000000000010000;
    assign     Arc_Tan_Table[13] = 'b00000000000001000;
    assign     Arc_Tan_Table[14] = 'b00000000000000100;
  //Output read from rom using address
    assign  output_rom  = Arc_Tan_Table [address]; 
  
endmodule
