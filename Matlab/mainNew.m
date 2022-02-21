clear
clc

%% Define variables
P1=[];P2=[];Q=[];area=[];
areaA = 0;
areaMax = 0;
maxIdx = 0;
resy = 0;
lenx = 150;
leny = 90;
lenz = 40;
tolerance = 1;
US = struct;
vol0 = (4/3)*pi;

%% Import images into struct
for i = 1:len
    US(i).myus = imread(['SweepScan/' num2str(i) '.jpg']);
end

%% Capture US
[US,time] = captureThree;

%% Choose US images
[US,time] = chooseImages(US,time);
angle_arr = findAngle(time);
len = length(US);

%% findAngle
angle_arr = findAngle(time);
len = length(US);

%% Find US (Debugging script)
extArr = [1,floor(length(US)/2),length(US)-1];
for i = 1:3
    US2(i) = US(extArr(i));
end
angle_arr = [29.1907;6.6193;-14.7986];
P1 = []; P2 = []; P3 = []; P4 = [];
len = length(US2);

%% Define user input
for i = 1:len
    image('CData',US2(i).myus,'XData',[0 1],'YData',[0 1]);
    [line,x,y]=freehanddraw;
    x = x * lenx;
    y = y * leny;
    i5 = ones(length(x),1)*angle_arr(i)/180*pi;
    P1 = [P1;x,y,i5];
    [arr,idx(:,:,i)] = curveFitting(x,y);
    P2 = [P2;arr,i5];
end

%% Extract values (Debugging script)
USpt = arrayBreaker(P1);
P1 = [];
P2 = [];
extArr = [1,floor(length(USpt)/2),length(USpt)];
for i = 1:3
    i5 = ones(length(USpt(extArr(i)).myus(:,1)),1)*USpt(extArr(i)).myus(1,3);
    P1 = [P1;USpt(extArr(i)).myus(:,1),USpt(extArr(i)).myus(:,2),i5];
    [arr,idx(:,:,i)] = curveFitting(USpt(extArr(i)).myus(:,1),USpt(extArr(i)).myus(:,2));
    P2 = [P2;arr,i5];
end

%% Clear array
P = [];
Q = [];

%% Calculate volume
[Q,fitval] = addMorePoints(P2,idx);
Q = shiftCorrect(Q,fitval);
% fitval = [-49.482593883876640,-4.764154560245355,25.600494505494492;-0.033151491074223,-0.071290060411814,21.473311939850902;-17.120941074009473,1.297102372807298,35.609265993647190];
% Q = customPoly(Q,fitval);
[P(1,:),P(2,:),P(3,:)] = pol2cart(Q(:,3),Q(:,2),Q(:,1));

% Plot user input points
figure;
plot3(P(1,:),P(2,:),P(3,:));
hold on

% MVEE algorithm
[A , c] = MinVolEllipse(P, tolerance);
x_dist = sqrt(1/A(1,1));
y_dist = sqrt(1/A(2,2));
z_dist = sqrt(1/A(3,3));

% Plot ellipsoid
[X,Y,Z] = ellipsoid(c(1),c(2),c(3),x_dist,y_dist,z_dist);
% plot3(X,Y,Z,'r');
plot3(P3(:,1),P3(:,2),P3(:,3),'.')
hold off

% Calculate volume using MVEE
vol_mvee = vol0/sqrt(det(A));

% Calculate volume using trisurf
[TriIdx, vol_tri] = convhull(P');
figure; trisurf(TriIdx, P(1,:)', P(2,:)', P(3,:)');

% Calculate volume using bullet formula
x_dist_max = (max(P(1,:)) - min(P(1,:)));
y_dist_max = (max(P(2,:)) - min(P(2,:)));
z_dist_max = (max(P(3,:)) - min(P(3,:)));
vol_bul = x_dist_max*y_dist_max*z_dist_max*5*pi/24;

%% Correct plot (Debugging script)
[US,P1] = correctImages(US,P1,lenx,leny,1);
[P1,P2,P3,P4] = arrayFourBreaker(P1);

%% Check length
Pxlen = (max(P(1,:))-min(P(1,:)));
Pylen = (max(P(2,:))-min(P(2,:)));
Pzlen = (max(P(3,:))-min(P(3,:)));
P3xlen = (max(P3(:,1))-min(P3(:,1)));
P3ylen = (max(P3(:,2))-min(P3(:,2)));
P3zlen = (max(P3(:,3))-min(P3(:,3)));

%% Plot ground truth
Pxcenter = (max(P(1,:))+min(P(1,:)))/2;
Pycenter = (max(P(2,:))+min(P(2,:)))/2;
Pzcenter = (max(P(3,:))+min(P(3,:)))/2;
P3xcenter = (max(P3(:,1))+min(P3(:,1)))/2;
P3ycenter = (max(P3(:,2))+min(P3(:,2)))/2;
P3zcenter = (max(P3(:,3))+min(P3(:,3)))/2;
P3(:,1) = P3(:,1)-P3xcenter+Pxcenter;
P3(:,2) = P3(:,2)-P3ycenter+Pycenter;
P3(:,3) = P3(:,3)-P3zcenter+Pzcenter;

%% Plot results
t = 1:9;
t = 10-t;
MRI = 53950.2629242117;
figure;
hold on
plot(t,vol_alpha,'m');
% plot(t,vol_area,'y');
plot(t,vol_bul,'c');
plot(t,vol_mvee,'g');
plot(t,vol_tri,'b');
plot(t,ones(9)*MRI,'r')
hold off
xlabel('Every nth slice taken')
% xlabel('Number of slices taken')
ylabel('Volume calculated (mm^3)')
legend('Alphashape','Sum of area','Bullet formula','MVEE','Trisurf','Location','southeast')

error_alpha = (vol_alpha-MRI)/MRI*100;
% error_area = (vol_area-MRI)/MRI*100;
error_bul = (vol_bul-MRI)/MRI*100;
error_mvee = (vol_mvee-MRI)/MRI*100;
error_tri = (vol_tri-MRI)/MRI*100;

figure;
hold on
plot(t,error_alpha,'m');
% plot(t,vol_area,'y');
plot(t,error_bul,'c');
plot(t,error_mvee,'g');
plot(t,error_tri,'b');
plot(t,zeros(9),'r')
hold off
xlabel('Every nth slice taken')
% xlabel('Number of slices taken')
ylabel('% error compared to ground truth (%)')
legend('Alphashape','Sum of area','Bullet formula','MVEE','Trisurf','Location','southeast')

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