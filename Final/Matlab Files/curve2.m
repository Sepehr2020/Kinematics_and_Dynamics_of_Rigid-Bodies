function [v_linear,v_angular,alpha,acc_t,xpos,ypos,time,slope_final] = curve2(v_initial,length_ramp)

%initialize position and time
xpos = (0);
ypos = (0);
time = (0);
v_linear = (0);
v_angular = (0);
alpha = (0);
acc_t = (0);
time_total = 0;

radius = 0.0063; %meters

dt = 0.01; %time increment

k = 1;
while xpos < length_ramp %probably should use for loop here but i dont know the syntax

    slope = 1.85*xpos(k) - 0.65 ;

    [v_t, x, y, alpha(k), acc_t(k)] = curve_ramp(slope, v_initial, dt);
    
    %update x & y position
    xpos(k+1) = xpos(k) + x;
    ypos(k+1) = ypos(k) + y;
    
    v_linear(k) = v_t;
    v_angular(k) = v_t / radius;
    
    
    %set the initial velocity of the next ramp to be equal to the final
    %velocity of the previous ramp
    v_initial = v_t;
    
    time_total = time_total + dt;
   
    time(k+1) = time(k) + dt;
    k = k+1; %index increment
end
slope_final = slope;
%remove the last indicies because they exceed the length of the ramp
xpos(end) = []
ypos(end) = []
time(end) = []

