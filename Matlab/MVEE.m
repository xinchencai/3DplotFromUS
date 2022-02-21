clear
clc
% Define variables
P = [];
len = 36;
lenx = 40;
leny = 40;
lenz = 50;
US = struct;

% Import images into struct
for i = 1:len
    US(i).myus = imread(['Frames/US' num2str(i) '.png']);
end

% Define user input
for i = 1:len
    image('CData',US(i).myus,'XData',[0 1],'YData',[0 1]);
    [line,x,y]=freehanddraw;
%     [x,y] = ginput(len);
    x = x * lenx;
    y = y * leny;
    i5 = ones(length(x),1);
    i5 = i5 * i / len * lenz;
    P = [P;x,y,i5];
end
P = P';
tolerance = 1;

% Calculate axial distances
% x_dist= (max(P(1,:)) - min(P(1,:)))/2;
% y_dist= (max(P(2,:)) - min(P(2,:)))/2;
% z_dist= (max(P(3,:)) - min(P(3,:)))/2 + 0.1;

% Plot user input points
plot3(P(1,:),P(2,:),P(3,:),'.');
hold on

% MVEE algorithm
[A , c] = MinVolEllipse(P, tolerance);
x_dist = sqrt(1/A(1,1));
y_dist = sqrt(1/A(2,2));
z_dist = sqrt(1/A(3,3));

% Plot ellipsoid
[X,Y,Z] = ellipsoid(c(1),c(2),c(3),x_dist,y_dist,z_dist);
plot3(X,Y,Z,'r');
hold off

% Calculate volume of ellipsoid
vol0 = (4/3)*pi;
vol = vol0/sqrt(det(A));

% Plot graphs
P = P';
plot_all (US, P, c, len, lenz, 1, x_dist, y_dist, z_dist);