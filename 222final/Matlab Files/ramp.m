function [v_linear,time,xpos,ypos,acc,alphat,v_angular] = ramp(slope, v_initial,length_ramp)
%CONSTANTS%
gravity = 9.81; %m/s;
mass = 0.036; %kg;
radius = 0.0063; %meters

%FINDING THE MOMENT BASED ON THE SLOPE%
theta = atan(slope);
I = (2/5)*mass*radius*radius + mass*radius*radius;
moment = mass*gravity*radius*(-sin(theta))

%use initial velocity to solve for time if slope is 0
if slope == 0
    acc_t = 0;
    alpha = 0;
    v_final = v_initial;
    time_final = length_ramp/v_final;
   
else
%FINDING TANGENTIAL ACCELERATION BASED ON THE MOMENT AND INERTIA%
alpha = moment/I
acc_t = alpha*radius

    %determines the final velocity and time of the ramp
    %multiplies by +- 1 to denote positive/negative direction depending on
    %the sign of the slope
v_final = sqrt(abs(v_initial^2 + (acc_t * length_ramp))) * (-slope/abs(slope))
time_final = (v_final - v_initial) / acc_t
end

%initialize time/pos
time = (0);
xpos = (0);
ypos = (0);
v_linear = (0);
v_angular = (0);

dt = 0.01;
k = 1;
while time(k) <= time_final
    
    %increment time by dt
    time(k+1) = time(k) + dt;
    
    %velocity at time t
    v_linear(k) = time(k) * acc_t + v_initial;
    
    %multiplies by +- 1 to denote positive/negative direction depending on
    %the sign of the slope
    xpos(k) = v_linear(k) * time(k) * cos(theta)
    
    %makes sure y is always going down regardless of poitive or negatvie slope
    ypos(k) = v_linear(k) * time(k) * sin(theta);
    
    v_angular(k) = v_linear(k) / radius;
    
    acc(k) = acc_t;
    alphat(k) = alpha;
    
    k = k+1;
end

%remove last indecies to make up for overcount
time(end) = [];
time(end) = [];
xpos(end) = [];
ypos(end) = [];
v_linear(end) = [];
v_angular(end) = [];
acc(end) = [];
alphat(end) = [];




