clc;
clear;
close all;

c = 10; %speed of EM wave
lambda = 1; %wave length
z = 0;
T = lambda/c; % c = Lambda/T -> T = Lambda/c
t = 0;

omega = 2*pi*c/lambda; %2pi/T
k = 2*pi/lambda;

polPos = [0 90 45];

kval = zeros(4,1);

for i=1:1:3

    %Amplitudes
    Ex = 1;
    Ey = 1;
    % py - px = phase difference
    px = 0;
    py = T/4;

    ex = real(Ex*exp( 1i*(omega*(t + px) - k*z ) ));
    ey = real(Ey*exp( 1i*(omega*(t + py) - k*z ) ));

    %Jones vector
    J1 = Ex*exp(1i*omega*px);
    J2 = Ey*exp(1i*omega*py);

    J = [ J1
          J2 ];

    p_theta = polPos(i);
    p_rad = (pi*p_theta)/180;

    polarizer_l = [ cos(p_rad)^2           sin(p_rad)*cos(p_rad)
                    sin(p_rad)*cos(p_rad)  sin(p_rad)^2         ]; 
    
    output = polarizer_l*J;
    %normalized
    %factor = (abs(J1)^2 + abs(J2)^2)^(0.5);
    %J = J/factor; %normalized jones vector

     optical_element = [  2.2932-1.5626i   2.4381+1.7761i
                         -5.3029-33.3254i  6.94457+12.57i ];

    output = optical_element*output;

    [Theta_x, eox] = cart2pol( real(output(1)), imag(output(1)) );
    [Theta_y, eoy] = cart2pol( real(output(2)), imag(output(2)) );
    delta = Theta_y - Theta_x;

    s0 = (eox^2) + (eoy^2);
    s1 = (eox^2) - (eoy^2);
    s2 = 2*eox*eoy*cos(delta);
    s3 = 2*eox*eoy*sin(delta);

    S = sqrt((s1^2)+(s2^2)+(s3^2));
    
    s0 = s0/S;
    s1 = s1/S;
    s2 = s2/S;
    s3 = s3/S;
    
    kval(i) = (sqrt(s0+s1)/sqrt(s0-s1))*exp(-1i*atan(s3/s2));
end

kval(4) = (kval(2)-kval(3))/(kval(3)-kval(1));

Jnew = [kval(1)*kval(4) kval(2)
        kval(4)         1      ]


optical_element/optical_element(4);
