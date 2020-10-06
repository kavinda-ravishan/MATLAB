close all;
clear;
clc;

c = 10; %speed of EM wave
lambda = 1; %wave length

z = 0;
T = lambda/c; % c = Lambda/T -> T = Lambda/c
%t = 0:T/100:T;

Ex = 1;
Ey = 1;

% px - py = phase difference
py = 0;
px = T/4;

omega = 2*pi*c/lambda; %2pi/T
k = 2*pi/lambda;

while 1
    for x = 0:100
        t = T*x/100 : T/100 : 5*T + T*x/100 ;

        ex = real(Ex*exp( 1i*(omega*(t + px) - k*z ) ));
        ey = real(Ey*exp( 1i*(omega*(t + py) - k*z ) ));

        plot3(t,ex,t*0,'r',t,t*0,ey,'b',t,ex,ey,'g'),grid on,view(90,0);
        %axis([-2,2,-2,2,-2,2]);
        pause(1/60);
    end
end