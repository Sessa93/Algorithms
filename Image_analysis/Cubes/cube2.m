close all;
clear all;
clc;

%% Reading the image, get the points

im_c = imread('cube.jpeg');
imshow(im_c);

hold on;

[x,y] = getpts;
plot(x,y,'or','MarkerSize',12);

a=[x(1) y(1) 1]';
b=[x(2) y(2) 1]';
c=[x(3) y(3) 1]';
e=[x(4) y(4) 1]';

hold on;