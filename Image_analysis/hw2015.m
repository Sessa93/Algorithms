clc;
close all;
clear all;

%% Image loading

im = imread('Image.JPG');
binaryIm = im;
imshow(binaryIm)
hold on;

%% Affine Rectification

% Parallel line 8 points

[xp,yp] = getpts;
plot(xp,yp,'or','MarkerSize',12);
hold on;

l11 = [xp(1) yp(1) 1];
l12 = [xp(2) yp(2) 1];
l1 = cross(l11,l12);
l1 = l1/l1(3);

l21 = [xp(3) yp(3) 1];
l22 = [xp(4) yp(4) 1];
l2 = cross(l21,l22);
l2 = l2/l2(3);

% l1 and l2 are parallel in the real world
% v1 is the first vanishing point
v1 = cross(l1,l2);
v1 = v1/v1(3);

l31 = [xp(5) yp(5) 1];
l32 = [xp(6) yp(6) 1];
l3 = cross(l31,l32);
l3 = l3/l3(3);

l41 = [xp(7) yp(7) 1];
l42 = [xp(8) yp(8) 1];
l4 = cross(l41,l42);
l4 = l4/l4(3);

v2 = cross(l3,l4);
v2 = v2/v2(3);

%% Calculate the image of the line at the infinity

l_inf = cross(v1,v2);
l_inf = l_inf/l_inf(3);

H_r = [1 0 0; 0 1 0; l_inf];
tform = maketform('projective',H_r');
projImg = imtransform(binaryIm,tform);
figure('Name','Geometry: Real parallelism restored','NumberTitle','off');
imshow(projImg);

hold on;

% We transoform also the lines and points that we have individuated

p1 = [tformfwd(tform,xp(1),yp(1)),1];
p2 = [tformfwd(tform,xp(2),yp(2)),1];
p3 = [tformfwd(tform,xp(3),yp(3)),1];
p4 = [tformfwd(tform,xp(4),yp(4)),1];
p5 = [tformfwd(tform,xp(5),yp(5)),1];
p6 = [tformfwd(tform,xp(6),yp(6)),1];
p7 = [tformfwd(tform,xp(7),yp(7)),1];
p8 = [tformfwd(tform,xp(8),yp(8)),1];

l1 = [tformfwd(tform, l1(1), l1(2)), 1];
l2 = [tformfwd(tform, l2(1), l2(2)), 1];
l3 = [tformfwd(tform, l3(1), l3(2)), 1];
l4 = [tformfwd(tform, l4(1), l4(2)), 1];

l1 = l1/l1(3);
l2 = l2/l2(3);
l3 = l3/l3(3);
l4 = l4/l4(3);

line([p1(1),p2(1)],[p1(2),p2(2)],'LineWidth',5);
line([p3(1),p4(1)],[p3(2),p4(2)],'LineWidth',5);
line([p5(1),p6(1)],[p5(2),p6(2)],'LineWidth',5);
line([p7(1),p8(1)],[p7(2),p8(2)],'LineWidth',5);


%% Metrics reconstruction

% Take 2 pairs of orthogonal lines (eg l1, l3 and l2, l4)

syms s1 s2
eqn1 = l1(1)*l3(1)*s1 + (l1(1)*l3(2) + l1(2)*l3(1))*s2 + l1(2)*l3(2) == 0;
eqn2 = l2(1)*l4(1)*s1 + (l2(1)*l4(2) + l2(2)*l4(1))*s2 + l2(2)*l4(2) == 0;
[A,b] = equationsToMatrix([eqn1, eqn2],[s1,s2]);
X = double(linsolve(A,b));

S = [X(1) X(2); X(2) 1];
P = chol(S);
H_s = [P,[0;0]; 0, 0,1];

tform2 = maketform('projective',H_s');
invform = fliptform(tform2);
projImg = imtransform(projImg,invform);
figure('Name','Geometry: Real metrics restored','NumberTitle','off');
imshow(projImg);



