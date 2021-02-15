close all;
clear;
clc;

c = 10; %speed of EM wave
lambda = 1; %wave length

z = 0;
T = lambda/c; % c = Lambda/T -> T = Lambda/c
t = 0:T/100:T;

Eax = cos(pi/12);
Eay = sin(pi/12);

E = sqrt((Eax^2)+(Eay^2));

Ex = Eax/E;
Ey = Eay/E;

% px - py = phase difference
py = 0;
px = 0;

omega = 2*pi*c/lambda; %2pi/T
k = 2*pi/lambda;

f = figure('Position', get(0, 'Screensize'));
filename = 'Beat_lengths .gif';

[X,Y,Z] = sphere;
figure(1),subplot(2,1,1),sphere,view(50,10),axis equal,hold on;
figure(1),subplot(2,1,2),grid on;

i=1;
for px = linspace(0,2*pi,100)

    ex = real(Ex*exp( 1i*( omega*t - k*z + px ) ));
    ey = real(Ey*exp( 1i*( omega*t - k*z + py ) ));
    
    delta = py-px;

    s0 = (Ex^2) + (Ey^2);
    s1 = (Ex^2) - (Ey^2);
    s2 = 2*Ex*Ey*cos(delta);
    s3 = 2*Ex*Ey*sin(delta);
    
    figure(1),subplot(2,1,1),plot3(s1,s2,s3,'.','Color','black','MarkerSize',10);
    title('Poincare sphere'),xlabel('S1'),ylabel('S2'),zlabel('S3');
    hold on;
    
    figure(1),subplot(2,1,2),plot(ex,ey,'black');
    title('Polarization ellipse'),xlabel('x'),ylabel('y'),grid on;
    
    %drawnow
    F = getframe(f);
    im = frame2im(F);
    [imind,cm] = rgb2ind(im,256); 
    % Write to the GIF File 
    if i == 1
        imwrite(imind,cm,filename,'gif','DelayTime',0.01, 'Loopcount',inf);
    else 
        imwrite(imind,cm,filename, 'gif','DelayTime',0.01,'WriteMode','append');
    end
    
    pause(1/60);
    i=i+1;
end

figure (1),hold off;