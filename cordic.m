function [cos_val, sin_val,true_valuecos,true_valuesin] = cordic(theta_deg, n_iter)
    % Convert degrees to radians
    theta = (theta_deg*pi)/180;
    theta=fi(theta,1,17,16);
    fixed_atan_table=[];
    z_test=[];
    x_test=[];
    y_test=[];
    % Precompute arctangent table
    atan_table = atan(2.^-(0:n_iter-1));
    for i =1 :1:n_iter
   fixed_atan_table=[fixed_atan_table fi(atan_table(i),1, 17,16);];
    end
    
 
    % Initialize vector and angle
    x = 1.0;
    y = 0.0;
    x=fi(x,1,16,11);
    y=fi(y,1,16,11);
    z = theta;
    
    % CORDIC gain
    K = prod(1 ./ sqrt(1 + 2.^(-2 * (0:n_iter-1))));
    K = fi(K,1,16,11);
    
    %%true value
    true_valuecos= x*cos(theta)-y*sin(theta);
    true_valuesin=y*cos(theta)+x*sin(theta);
    
    % CORDIC Iteration Loop
    for i =0:1:n_iter-1
        z_test=[z_test ;bin(fi(z,1,17,16))]; 

       
    if(z>0)
     d=1;
    elseif (z==0)
     d=1;
    else
    d=-1;
    end
    z_test = [z_test ;  bin(fi(z,1,17,16)) ];
    x_new=x-(sign(y)*sign(d)*bitsra(y,i));    
    y_new=y+(sign(x)*sign(d)*bitsra(x,i));
    z=z-(sign(d)*fixed_atan_table(i+1));
       % x_new = x - d .* y .* 2^-i;
        %y_new = y + d .* x .* 2^-i;
        %z = z - d * fixed_atan_table(i+1);

        x = fi(x_new,1,14,11);
        y = fi(y_new,1,14,11);
        
        x_test=[x_test;bin(x)];
        y_test=[y_test;bin(y)];
    end
    
    % Compensate for CORDIC gain
   
    cos_val = x * K;
    sin_val = y * K;

end
