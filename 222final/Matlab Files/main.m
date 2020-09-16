clear all
clc


%track specifications as a modelled in solidworks
slope1 = -0.06;
slope2 = 0.08;
slope3 = -0.16;
slope4 = 0.004;
slope5 = -0.36;
slope6 = 0;
slope7 = 0.72;
slope8 = 0.027;


length1 = 0.476;

height1 = 0.033;
height2 = 0.0242;
height3 = 0.0506;
height4 = 0.065;
height5 = 0.011;
height6 = 0.0351;
height7 = 0.0413;


distance1 = 0.327;
distance2 = 0.312;
distance3 = 0.367;
distance4 = 0.0424;
distance5 = 0.0591;
distance6 = 0.0386;
distance7 = 0;

%ramp 1
[v_linear1,time1,xpos1,ypos1,acc_t1,alpha1,v_angular1] = ramp(slope1, 0, length1)

%impact
[v_impact] = impact(v_linear1(end))

%drop ramp1- ramp2
[time2, xpos2,ypos2,v_linear2,length2,v_angular2,alpha2,acc_t2] = drop(v_impact,slope1,slope2,height1,distance1);

xpos2 = xpos2 + xpos1(end);%adds previous final values to the next set of values so that theyll 
ypos2 = ypos2 + ypos1(end);%carry on from the last value recorded in the previous section
time2 = time2 + time1(end);

%ramp2 - we assume the intitial velocity to be 0 for most ramps due to the
%change in x-direction the x velocity goes to 0  and to account for
%bouncing we set the y velocity to 0
[v_linear3,time3,xpos3,ypos3,acc_t3,alpha3,v_angular3] = ramp(slope2, 0, length2);

xpos3 = xpos3 + xpos2(end);
ypos3 = ypos3 + ypos2(end);
time3 = time3 + time2(end);

%drop ramp2-curve
[time4, xpos4,ypos4,v_linear4,length4,v_angular4,alpha4,acc_t4] = drop(v_linear3(end),slope2,slope3,height2,distance2);

xpos4 = xpos4 + xpos3(end);
ypos4 = ypos4 + ypos3(end);
time4 = time4 + time3(end);

%curve section
[v_linear5,v_angular5,alpha5,acc_t5,xpos5,ypos5,time5,slope_curve] = curve2(0,length4)

xpos5 = xpos5 + xpos4(end);
ypos5 = ypos5 + ypos4(end);
time5 = time5 + time4(end);

%drop from curve to ramp4
[time6, xpos6,ypos6,v_linear6,length6,v_angular6,alpha6,acc_t6] = drop(v_linear5(end),slope_curve,slope4,height3,distance3);

xpos6 = xpos6 + xpos5(end);
ypos6 = ypos6 + ypos5(end);
time6 = time6 + time5(end);

%ramp4
[v_linear7,time7,xpos7,ypos7,acc_t7,alpha7,v_angular7] = ramp(slope4, 0, length6);

xpos7 = xpos7 + xpos6(end);
ypos7 = ypos7 + ypos6(end);
time7 = time7 + time6(end);

%drop ramp4-ramp5
[time8, xpos8,ypos8,v_linear8,length8,v_angular8,alpha8,acc_t8] = drop(v_linear7(end),slope4,slope5,height4,distance4);

xpos8 = xpos8 + xpos7(end);
ypos8 = ypos8 + ypos7(end);
time8 = time8 + time7(end);

%ramp5
[v_linear9,time9,xpos9,ypos9,acc_t9,alpha9,v_angular9] = ramp(slope5, 0, length8);

xpos9 = xpos9 + xpos8(end);
ypos9 = ypos9 + ypos8(end);
time9 = time9 + time8(end);

%drop ramp5 - ramp6
[time10, xpos10,ypos10,v_linear10,length10,v_angular10,alpha10,acc_t10] = drop(v_linear9(end),slope5,slope6,height5,distance5);

xpos10 = xpos10 + xpos9(end);
ypos10 = ypos10 + ypos9(end);
time10 = time10 + time9(end);

%ramp6- here as well as ramp final we take the x component of velocity from
%the previous ramp as the initial velocity for the next ramp becuase theres
%no change in direction
[v_linear11,time11,xpos11,ypos11,acc_t11,alpha11,v_angular11] = ramp(slope6, v_linear10(end) * cos(atan(slope5)), (0.476-length10));

xpos11 = xpos11 + xpos10(end);
ypos11 = ypos11 + ypos10(end);
time11 = time11 + time10(end);

%drop ramp6-7
[time12, xpos12,ypos12,v_linear12,length12,v_angular12,alpha12,acc_t12] = drop(v_linear11(end),slope6,slope7,height7,distance7);
xpos12 = xpos12 + xpos11(end);
ypos12 = ypos12 + ypos11(end);
time12 = time12 + time11(end);

%ramp7
[v_linear13,time13,xpos13,ypos13,acc_t13,alpha13,v_angular13] = ramp(slope7,0 , length12);

xpos13 = xpos13 + xpos12(end);
ypos13 = ypos13 + ypos12(end);
time13 = time13 + time12(end);


%ramp8
[v_linear14,time14,xpos14,ypos14,acc_t14,alpha14,v_angular14] = ramp(slope8, 0, 0.457);

xpos14 = xpos14 + xpos13(end);
ypos14 = ypos14 + ypos13(end);
time14 = time14 + time13(end);

%drop ramp8-ramp9
[time15 ,xpos15,ypos15,v_linear15,length15,v_angular15,alpha15,acc_t15] = drop(v_linear14(end),slope8,slope5,height6,distance6);

xpos15 = xpos15 + xpos14(end);
ypos15 = ypos15 + ypos14(end);
time15 = time15 + time14(end);

%ramp9
[v_linear16,time16,xpos16,ypos16,acc_t16,alpha16,v_angular16] = ramp(slope5,0 , length15);

xpos16 = xpos16 + xpos15(end);
ypos16 = ypos16 + ypos15(end);
time16 = time16 + time15(end);

%rampfinal
[v_linear17,time17,xpos17,ypos17,acc_t17,alpha17,v_angular17] = ramp(slope6,v_linear15(end) * cos(atan(slope5)), 0.457);

xpos17 = xpos17 + xpos16(end);
ypos17 = ypos17 + ypos16(end);
time17 = time17 + time16(end);

%puts together all the position arrays from each section into 1 array
ypos = [ypos1,ypos2,ypos3,ypos4,ypos5,ypos6,ypos7,ypos8,ypos9,ypos10,ypos11,ypos12,ypos13,ypos14,ypos15,ypos16,ypos17];
xpos = [xpos1,xpos2,xpos3,xpos4,xpos5,xpos6,xpos7,xpos8,xpos9,xpos10,xpos11,xpos12,xpos13,xpos14,xpos15,xpos16,xpos17];

%puts toether all the arrays for the other variables into 1 array each
time = [time1,time2,time3,time4,time5,time6,time7,time8,time9,time10,time11,time12,time13,time14,time15,time16,time17]
v_linear = [v_linear1,v_linear2,v_linear3,v_linear4,v_linear5,v_linear6,v_linear7,v_linear8,v_linear9,v_linear10,v_linear11,v_linear12,v_linear13,v_linear14,v_linear15,v_linear16,v_linear17]
v_angular = [v_angular1,v_angular2,v_angular3,v_angular4,v_angular5,v_angular6,v_angular7,v_angular8,v_angular9,v_angular10,v_angular11,v_angular12,v_angular13,v_angular14,v_angular15,v_angular16,v_angular17]
acc_t = [acc_t1,acc_t2,acc_t3,acc_t4,acc_t5,acc_t6,acc_t7,acc_t8,acc_t9,acc_t10,acc_t11,acc_t12,acc_t13,acc_t14,acc_t15,acc_t16,acc_t17]
alpha = [alpha1,alpha2,alpha3,alpha4,alpha5,alpha6,alpha7,alpha8,alpha9,alpha10,alpha11,alpha12,alpha13,alpha14,alpha15,alpha16,alpha17]

time_final = time(end)

%plots
figure('Name','x vs y')
plot (xpos,ypos)
figure('Name','linear velocity vs time')
plot (time,v_linear)
figure('Name','angular velocity vs time')
plot (time,v_angular)
figure('Name','linear accel vs time')
plot (time, acc_t)
figure('Name','angular accel vs time')
plot (time, alpha)