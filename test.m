close all;
clear;
clc;

Ey = 0.1:0.01:10;
Ex = 1;

EyEx = ( (Ey.^2) + (Ex.^2) ).^0.5;

y = Ey./EyEx;
x = Ex./EyEx;

plot(y/x);