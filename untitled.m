clear;
clc;
theta_deg=30;
n_iter=15;
fixed = [];
binary=[];
[cos_val, sin_val,true_valuecos,true_valuesin] = cordic(theta_deg, n_iter)
  atan_table = atan(2.^-(0:n_iter-1));
  atann_table= (atan_table);  
%for i =1 :1:n_iter
 % fixed=[fixed fi(atan_table(i),1, 17,16);];
  % binary=[binary ;bin(fixed(i))];
%end
%val=bin2dec(binary);
%arc=atan_table(1)
%val2=val/2^16