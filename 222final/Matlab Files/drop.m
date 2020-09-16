function [time, xpos,ypos,v_linear,length,v_angular,alpha,acc_t] = drop(v_initial,slope1,slope2,height,distance)
gravity = -9.81; %m/s;

theta1 = atan(slope1)%angle of the ramp it is leaving
theta2 = atan(slope2)%angle of the ramp it lands on

vy_initial = v_initial * sin(theta1)
vx_initial = v_initial * cos(theta1)


%found y with respect to x of the falling ball as it leaves the ramp using
%projectile motion with the initial velocities equal to the final
%velocities of the ramp the ball leaves from

%then we set the y offset of the quadratic modelled by the ball falling to
%be the vertical distance between the end of the first ramp to the second
%ramp. this way we can set it equal to the equation of the ramp it lands on
% as y = mx and solve for the intersection between the 2 which gives us the
% starting position on the next ramp after accounting for the rest of the
% length of the ramp

x_intercept = -(((vy_initial/vx_initial)-slope2) + sqrt((vy_initial/vx_initial)^2 + slope2^2 - 2*(vy_initial/vx_initial)*slope2 - 2*gravity*height/(vx_initial^2)) )/(gravity/(vx_initial^2))


%length of the next ramp will be the x-distance between the ends of both
%ramps + the x distance the ball travels, divided by the cos of the angle
length = (x_intercept + distance) / cos(theta2);
time_total = abs(x_intercept / vx_initial);

time = (0);
xpos = (0);
ypos = (0);
v_linear = (0);
v_angular = (0);
acc_t = (0);
alpha = (0);


dt = 0.01;
k = 1;


%find position and linear velocity acorss time increments
while time < time_total
    time(k+1) = time(k) + dt
    vy = vy_initial + gravity * time(k);
    v_linear(k) = sqrt(vy^2+vx_initial^2);
    
    %find x and y position using projectile motion
    xpos(k) = vx_initial * time(k)
    ypos(k) = (vy_initial * time(k)) + (gravity * time(k)^2 / 2)
    

    %set the angular velocity and acceleration = 0 for the time interval
    %that the ball is in the air
    v_angular(k) = 0;
    alpha(k) = 0;
    
    %linear acceleration is constant = gravity while the ball is falling
    acc_t(k) = gravity;
    
    k=k+1;
end
%remove last index to fix overcount
time(end) = [];
time(end) = [];
xpos(end) = [];
ypos(end) = [];
v_angular(end) = [];
acc_t(end) = [];
alpha(end) = [];
v_linear(end) = [];

