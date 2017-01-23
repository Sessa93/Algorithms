clear all;
close all;
clc;

%% Read the image and get the visible points

im_c = imread('bluecube.jpg');
imshow(im_c);

hold on;

[x,y] = getpts;
plot(x,y,'or','MarkerSize',12);

hold on;

a = [x(1), y(1), 1]';
b = [x(2), y(2), 1]';
c = [x(3), y(3), 1]';
d = [x(4), y(4), 1]';
e = [x(5), y(5), 1]';
f = [x(6), y(6), 1]';

%% Finding vanishing points and uknown point

vab = cross(cross(a,b), cross(d,e));
vbc = cross(cross(b,c), cross(e,f));
vaf = cross(cross(a,f), cross(c,d));

vab = vab/vab(3);
vbc = vbc/vbc(3);
vaf = vaf/vaf(3);

g = cross(cross(vab,f), cross(vbc,d));
g = g/g(3);

h = cross(cross(vaf,e), cross(vab,c));
h = h/h(3);

plot(g(1),g(2),'xr','MarkerSize',12);
hold on
plot(h(1),h(2),'xr','MarkerSize',12);
hold on
