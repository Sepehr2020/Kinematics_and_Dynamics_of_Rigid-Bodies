function [v_final] = impact(v_initial)

%Mass moment of inertia of the gate that the marble impacts
m = 0.025; %kg
h = 0.0493;%metres
w = 0.025;
I = (1/12)*(m)*(4*h^2 + w^2);

% mass of the marble
mb = 0.036;

%Coefficient of restitution determined from experimentation
e = 0.424;

v_final = ((mb*v_initial*h) - ((v_initial*I*e)/h))/((mb*h)+(I/h));






