close all;
clear;
clc;

s = 0;
e = 10*pi;

T = 2*pi;
t = s:pi/20:e;
theta = 0;
shift = pi/4;

frames = 100;
frameC = 0;

f = figure('Position', get(0, 'Screensize'));
filename = 'test.gif';

while 1
    y1 = sin(2*pi*(t/T) + theta);
    y2 = 0.75*sin(2*pi*(t/T) + theta-shift);
    
    theta = ((2*pi)/frames)*frameC;
    frameC = frameC+1;
    
    if frames == frameC
        theta = 0;
        break;
    end
    
    subplot(2,2,1);
    plot3(t,y1,t.*0);
    hold on;
    plot3(t,t.*0,y2);
    hold off;
    view(45,45);
    grid on;
    
    subplot(2,2,2);
    plot3(t,y1,t.*0);hold on;
    plot3(0,y1(1),0,'o');hold on;
    plot3(0,0,y2(1),'o');hold on;
    plot3(t,t.*0,y2);hold off;
    %axis([-1.1,1.1,-1.1,1.1,-1.1,1.1]);
    view(90,0);
    grid on;

    subplot(2,2,3);
    plot3(t,y1,y2);
    view(45,45);
    grid on;
    
    subplot(2,2,4);
    plot3(0,y1(1),y2(1),'o');hold on;
    plot3(t,y1,y2);hold off;
    %axis([-1.1,1.1,-1.1,1.1,-1.1,1.1]);
    view(90,0);
    grid on;
    
    %drawnow
    F = getframe(f);
    im = frame2im(F);
    [imind,cm] = rgb2ind(im,256); 
    % Write to the GIF File 
    if frameC == 1
        imwrite(imind,cm,filename,'gif','DelayTime',0.01, 'Loopcount',inf);
    else 
        imwrite(imind,cm,filename, 'gif','DelayTime',0.01,'WriteMode','append');
    end
end

% while 1
%     y1 = sin(2*pi*f*t + theta);
%     y2 = sin(2*pi*f*t - theta);
%     
%     theta = theta + ((2*pi)/10);
%     
%     if theta > 2*pi
%         theta = 0;
%     end
%     
%     subplot(3,1,1);
%     plot3(t,y1,0);
%     axis([s,e,-1.2,1.2]);
%     grid on;
%     
%     subplot(3,1,2);
%     plot3(t,y2,0);
%     axis([s,e,-1.2,1.2]);
%     grid on;
%     
%     subplot(3,1,3);
%     plot3(t,y1+y2,0);
%     axis([s,e,-1.2*2,1.2*2]);
%     grid on;
%     
%     pause(0.01);
% end
