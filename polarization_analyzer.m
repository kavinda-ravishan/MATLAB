close all;
clear;
clc;

c = 10; %speed of EM wave
lambda = 1; %wave length
z = 0; %z=0 measure from a point with time
T = lambda/c; % c = Lambda/T -> T = Lambda/c
t = 0:T/100:4*T;% let time flow
%Amplitudes
Ex = 1;
Ey = 1;
% px - py = phase difference
px = 0;
py = pi/4;

omega = 2*pi*c/lambda; %2pi/T
k = 2*pi/lambda;

ex = real(Ex*exp( 1i*( omega*t - k*z + px ) ));
ey = real(Ey*exp( 1i*( omega*t - k*z + py ) ));

%figure(1),subplot(2,1,1),plot3(t,ex,t*0,'r',t,t*0,ey,'b',t,ex,ey,'g'),grid on,hold on;

%Jones vector
J1 = Ex*exp(1i*k*px);
J2 = Ey*exp(1i*k*py);

J = [ J1
      J2 ];

%normalized
%factor = (abs(J1)^2 + abs(J2)^2)^(0.5);
%J = J/factor; %normalized jones vector

%J_abs = (abs(J(1))^2 + abs(J(2))^2)^0.5; %for test, J_abs == 1


% x_polarizer = [ 1 0
%                 0 0 ];
% 
% y_polarizer = [ 0 0
%                 0 1 ];
%           
% output = x_polarizer*J
% output = y_polarizer*J

p_theta = 0;

for x = 0:1:360
    
    p_theta = x;
    p_rad = pi*p_theta/180;
    
    p_rad_l = 0;%p_rad*4;
    polarizer_l = [ cos(p_rad_l)^2            sin(p_rad_l)*cos(p_rad_l)
                    sin(p_rad_l)*cos(p_rad_l) sin(p_rad_l)^2         ];
              
%     polarizer_w2 = [ cos(p_rad)^2 - 1i*(sin(p_rad)^2)  2*sin(p_rad)*cos(p_rad)
%                      2*sin(p_rad)*cos(p_rad)           sin(p_rad)^2 - 1i*(cos(p_rad)^2) ];
%     polarizer_w2 = polarizer_w2*exp(-1i*pi/2);

    polarizer_w4 = [ cos(p_rad)^2 + 1i*(sin(p_rad)^2)  (1-1i)*sin(p_rad)*cos(p_rad)
                     (1-1i)*sin(p_rad)*cos(p_rad)      sin(p_rad)^2 + 1i*(cos(p_rad)^2) ];
    polarizer_w4 = polarizer_w4*exp(-1i*pi/4);

%     polarizer = [ 1 0
%                  0 1i];

    output = polarizer_l*polarizer_w4*J;
    
%    a = polarizer_w4*J;
%    output = polarizer_l*a;

    ex_o = real(exp( 1i*(omega*t - k*z ))*output(1));
    ey_o = real(exp( 1i*(omega*t - k*z ))*output(2));

%     t = 0:T/100:4*T;
%     figure(1),plot3(t,ex,t*0,'r',t,t*0,ey,'b',t,ex,ey,'g'),grid on,hold on;
%     t = 7*T:T/100:11*T;
%     figure(1),plot3(t,ex_o,t*0,'r',t,t*0,ey_o,'b',t,ex_o,ey_o,'g'),grid on,view(45,45),hold off;

    t = 0:T/100:4*T;
    figure(1),plot3(t,ex,ey,'r'),grid on,hold on;
    t = 7*T:T/100:11*T;
    figure(1),plot3(t,ex_o,ey_o,'r'),grid on,view(45,45),hold off;

    figure(2),plot(p_theta,(abs(output(1))^2+abs(output(2))^2)^0.5,'x'),hold on;
    
    pause(1/60);
end