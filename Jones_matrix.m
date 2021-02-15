close all;
clear;
clc;

c = 10; %speed of EM wave
lambda = 1; %wave length
z = 0; %z=0 mesure from a point with time
T = lambda/c; % c = Lambda/T -> T = Lambda/c
t = 0:T/100:4*T;% let time flow
%Amplitudes
Ex = 1;
Ey = 1;
% px - py = phase difference
px = 0;
py = 0;

omega = 2*pi*c/lambda; %2pi/T
k = 2*pi/lambda;

ex = real(Ex*exp( 1i*( omega*t - k*z + px ) ));
ey = real(Ey*exp( 1i*( omega*t - k*z + py ) ));

%Jones vector
J1 = Ex*exp(1i*k*px);
J2 = Ey*exp(1i*k*py);

J = [ J1
      J2 ];


P = [ 1 0
      0 1i];

%Jones matrix of quarter wave plate
Quarter_wave_plate = exp(-1i*(pi/4))*P;

output = Quarter_wave_plate*J;

%Converting back to wave formula
ex_o = real(exp( 1i*(omega*t - k*z ))*output(1));
ey_o = real(exp( 1i*(omega*t - k*z ))*output(2));

%input wave
figure(1),plot3(t,ex,ey,'r'),grid on,view(45,45);

%output wave
figure(2),plot3(t,ex_o,ey_o,'r'),grid on,view(45,45);