function [v_final,x,y,alpha,acc_t] = curve_ramp(slope, v_initial,time)
%CONSTANTS%
gravity = 9.81; %m/s;
mass = 0.036; %kg;
radius = 0.0063; %meters

%FINDING THE MOMENT BASED ON THE SLOPE%
theta = atan(slope);
I = (2/5)*mass*radius*radius + mass*radius*radius;
moment = mass*gravity*radius*(-sin(theta))*0.5;

%FINDING TANGENTIAL ACCELERATION BASED ON THE MOMENT AND INERTIA%
alpha = moment/I;
acc_t = alpha*radius;

%equations of motion    
v_final = v_initial + acc_t * time;
position = (v_initial + v_final) * time / 2;
x = position * abs(cos(theta));
y = position * sin(theta);
