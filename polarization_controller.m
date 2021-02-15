close all;
clear;
clc;

c = 10; %speed of EM wave
lambda = 1; %wave length
z = 0; %z=0 mesure from a point with time
T = lambda/c; % c = Lambda/T -> T = Lambda/c
t = 0:T/100:T;% let time flow
%Amplitudes
Ex = 1;
Ey = 1;
% px - py = phase difference
px = 0;
py = 0;%pi/4;

omega = 2*pi*c/lambda; %2pi/T
k = 2*pi/lambda;

ex = real(Ex*exp( 1i*( omega*t - k*z + px ) ));
ey = real(Ey*exp( 1i*( omega*t - k*z + py ) ));

%Jones vector
J1 = Ex*exp(1i*omega*px);
J2 = Ey*exp(1i*omega*py);

J = [ J1
      J2 ];

%normalized
factor = (abs(J1)^2 + abs(J2)^2)^(0.5);
J = J/factor; %normalized jones vector

[Theta_x, eox] = cart2pol( real(J(1)), imag(J(1)) );
[Theta_y, eoy] = cart2pol( real(J(2)), imag(J(2)) );
delta = Theta_y - Theta_x;

s0 = (eox^2) + (eoy^2);
s1 = (eox^2) - (eoy^2);
s2 = 2*eox*eoy*cos(delta);
s3 = 2*eox*eoy*sin(delta);

p_theta_w4_1 = 0;
p_theta_w2_2 = 0;
p_theta_w4_3 = 0;

p_rad1 = (pi*p_theta_w4_1)/180;
p_rad2 = (pi*p_theta_w2_2)/180;
p_rad3 = (pi*p_theta_w4_3)/180;


polarizer_w4_1 = [ cos(p_rad1)^2 + 1i*(sin(p_rad1)^2)  (1-1i)*sin(p_rad1)*cos(p_rad1)
                   (1-1i)*sin(p_rad1)*cos(p_rad1)      sin(p_rad1)^2 + 1i*(cos(p_rad1)^2) ];
polarizer_w4_1 = polarizer_w4_1*exp(-1i*pi/4);

polarizer_w2_2 = [ cos(p_rad2)^2 - sin(p_rad2)^2  2*sin(p_rad2)*cos(p_rad2)
                   2*sin(p_rad2)*cos(p_rad2)      sin(p_rad2)^2 - cos(p_rad2)^2 ];
polarizer_w2_2 = polarizer_w2_2*exp(-1i*pi/2);

polarizer_w4_3 = [ cos(p_rad3)^2 + 1i*(sin(p_rad3)^2)  (1-1i)*sin(p_rad3)*cos(p_rad3)
                   (1-1i)*sin(p_rad3)*cos(p_rad3)      sin(p_rad3)^2 + 1i*(cos(p_rad3)^2) ];
polarizer_w4_3 = polarizer_w4_3*exp(-1i*pi/4);

output = polarizer_w4_3*polarizer_w2_2*polarizer_w4_1*J;

ex_o = real(exp( 1i*(omega*t - k*z ))*output(1) );
ey_o = real(exp( 1i*(omega*t - k*z ))*output(2) );

[Theta_x, eox] = cart2pol( real(output(1)), imag(output(1)) );
[Theta_y, eoy] = cart2pol( real(output(2)), imag(output(2)) );
delta = Theta_y - Theta_x;

s0 = (eox^2) + (eoy^2);
s1 = (eox^2) - (eoy^2);
s2 = 2*eox*eoy*cos(delta);
s3 = 2*eox*eoy*sin(delta);


plot3(t,ex_o,t*0,'r',t,t*0,ey_o,'b',t,ex_o,ey_o,'g','LineWidth',2),axis([-1,1,-1,1,-1,1]),grid on,view(90,0);
%figure(2),plot3(t,ex,ey,'g','LineWidth',2),grid on,view(90,0);