clear
clc

%% Define variables
P1=[];P=[];area=[];
areaA = 0;
lenx = 58.53/0.3311;
leny = lenx;
% leny = 93.95/0.4167;
lenz = [7.43; 10.42; 13.42; 16.41; 19.40; 22.40; 25.39; 28.39; 31.38; 34.37; 37.37; 40.36; 43.36; 46.35; 49.34; 52.34; 55.33];
tolerance = 1;
US = struct;
vol0 = (4/3)*pi;
len = 17;

%% Import images into struct
for i = 1:len
    US(i).myus = imread(['Phantom MRI/MRI' num2str(i) '.jpg']);
end

%% Define user input
for i = 1:len
    image('CData',US(i).myus,'XData',[0 1],'YData',[0 1]);
    [line,x,y]=freehanddraw;
    x = x * lenx;
    y = y * leny;
    areaA = polyarea(x,y); 
    area = [area;areaA];
    i5 = ones(length(x),1);
    i5 = i5 * lenz(i);
    P1 = [P1;x,y,i5];
end
%% Calculate volume
% Get array
n = 1;
P = P1';
i = 1;

% Plot user input points
figure;
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

% Calculate volume using sum of area
vol_area(i) = 0;
for j = 1:length(area)
    if rem(j-1,n)==0
        vol_area(i) = vol_area(i) + area(j);
    end
end
vol_area(i) = vol_area(i)/len*(lenz(length(lenz))-lenz(1))*n;

% Calculate volume using MVEE
vol_mvee(i) = vol0/sqrt(det(A));

% Calculate volume using trisurf
[TriIdx, vol_tri(i)] = convhull(P');
figure; trisurf(TriIdx, P(1,:)', P(2,:)', P(3,:)');

% Calculate volume using bullet formula
x_dist_max = (max(P(1,:)) - min(P(1,:)));
y_dist_max = (max(P(2,:)) - min(P(2,:)));
z_dist_max = (max(P(3,:)) - min(P(3,:)));
vol_bul(i) = x_dist_max*y_dist_max*z_dist_max*5*pi/24;

% Calculate volume using alphashape
shp = alphaShape(P(1,:)',P(2,:)',P(3,:)',15,'HoleThreshold',15);
vol_alpha(i) = volume(shp);

% Clear array
P = [];

%% Plot experimental results
figure;
subplot(3,2,1);
plot_surf (US,P1, c, len, lenx, leny, lenz, 1, x_dist, y_dist, z_dist);
title('36 frames')
subplot(3,2,2);
plot_surf (US,P2, c, len, lenx, leny, lenz, 2, x_dist, y_dist, z_dist);
title('18 frames')
subplot(3,2,3);
plot_surf (US,P3, c, len, lenx, leny, lenz, 4, x_dist, y_dist, z_dist);
title('9 frames')
subplot(3,2,4);
plot_surf (US,P4, c, len, lenx, leny, lenz, 9, x_dist, y_dist, z_dist);
title('4 frames')
subplot(3,2,5);
plot_ellipse (US,P1, c, len, lenx, leny, lenz, 1, x_dist, y_dist, z_dist);
title('MVEE')
subplot(3,2,6);
plot_ellipse (US,P1, c, len, lenx, leny, lenz, 1, x_dist, y_dist, z_dist);
title('Bullet formula')

%% 
% Finite Element Analysis
% DT = delaunayTriangulation(P3(:,1), P3(:,2), P3(:,3));
% tetramesh(DT);
% camorbit(20,0)