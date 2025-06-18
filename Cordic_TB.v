module  Cordic_TB  ();
  
parameter FIXED_POINT=14;


reg clk_tb        ;
reg                       rst_tb         ;
reg   [16:0]   theta_rad_tb   ;
reg   [FIXED_POINT-1:0]   data_in_x_tb   ;
reg   [FIXED_POINT-1:0]   data_in_y_tb   ;
reg                        enable_in_tb  ;
reg                        load_data_tb  ;
reg    [3:0]               Shift_value_tb ;
wire   [FIXED_POINT-1:0]   data_out_x_tb  ;
wire   [FIXED_POINT-1:0]   data_out_y_tb ;

reg [3:0] i;

initial
begin
  forever #250 clk_tb = ~clk_tb;
end

initial 
begin
initialization();
DATA(); 
#1000000
 $stop;
end

task DATA;
  begin
  @(posedge clk_tb)
    begin
      load_data_tb  =1'b0;
      enable_in_tb  =1'b1;
   end  
   @(posedge clk_tb)
    begin
      load_data_tb  =1'b1;
      enable_in_tb  =1'b1;
   end  
  repeat (13) 
  begin
    @(posedge clk_tb );
    Shift_value_tb  = Shift_value_tb +1'b1;
        load_data_tb  =1'b1;
      enable_in_tb  =1'b1;
  
  end  
   //repeat (15) 
   // begin
/*   @(posedge clk_tb)
    load_data_tb = 1'b1;
    enable_in_tb=1'b1;
       @(posedge clk_tb)
    load_data_tb = 1'b0;
    enable_in_tb=1'b1;
    Shift_value_tb='b0;
       @(posedge clk_tb)
    load_data_tb = 1'b0;
    enable_in_tb=1'b1;
    Shift_value_tb='b01;
    //Shift_value_tb=Shift_value_tb+1'b1;
 // end*/
 
  end
endtask
task initialization ;
  begin
    clk_tb=0;
    rst_tb=1;
    i=0;
    data_in_x_tb='b00100000000000;
    data_in_y_tb='b0;
    enable_in_tb=1'b0;
    load_data_tb=1'b0;
    Shift_value_tb='b0;
    theta_rad_tb=17'b01000011000001011;
    #1
    rst_tb=0;
    #1
    rst_tb=1;
  end
endtask










Cordic DUT
(
.clk  (clk_tb),
.rst  (rst_tb),
.theta_rad(theta_rad_tb),
.data_in_x(data_in_x_tb),
.data_in_y(data_in_y_tb),
.enable_in(enable_in_tb),
.load_data(load_data_tb),
.Shift_value(Shift_value_tb),
.data_out_x(data_out_x_tb),
.data_out_y(data_out_y_tb)

);













endmodule
