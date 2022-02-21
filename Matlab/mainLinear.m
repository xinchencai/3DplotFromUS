clear
clc

%% Define variables
P1=[];P2=[];P3=[];P4=[];P=[];area=[];
areaA = 0;
lenx = 150;
leny = 90;
lenz = 40;
tolerance = 1;
US = struct;
vol0 = (4/3)*pi;
len = 36;

%% Import images into struct
for i = 1:len
%     US(i).myus = imread(['LinearScan/' num2str(i) '.jpg']);
    US(i).myus = imread(['Frames/US' num2str(i) '.png']);
end

%% Capture US
[anglea,angleb,US] = captureUS3;
angle = (abs(anglea) + abs(angleb))/length(US);
angle = 2/180*pi;

%% Choose US images
[US,time] = chooseImages(US,time);
angle_arr = findAngle(time);
len = length(US);

%% Define user input
for i = 1:len
    image('CData',US(i).myus,'XData',[0 1],'YData',[0 1]);
    [line,x,y]=freehanddraw;
%     [x,y] = ginput(len);
    x = x * lenx;
    y = y * leny;
    areaA = polyarea(x,y); 
    area = [area;areaA];
    i5 = ones(length(x),1);
    i5 = i5 * i / len * lenz;
%     i5 = i5 - 27 + (i - 1) * angle;
    P1 = [P1;x,y,i5];
    if rem(i-1,2)==0
        P2 = [P2;x,y,i5];
    end
    if rem(i-1,4)==0
        P3 = [P3;x,y,i5];
    end
    if rem(i-1,9)==0
        P4 = [P4;x,y,i5];
    end
end

%% Calculate volume
Px = arrayStructBreaker(P1);
for i = 1:length(Px)
    % Get array
%     if i == 1
%         n = 1;
% %         P = P1';
%         [P(1,:),P(2,:),P(3,:)] = pol2cart(P1(:,3),P1(:,1),P1(:,2));
%     elseif i == 2
%         n = 2;
% %         P = P2';
%         [P(1,:),P(2,:),P(3,:)] = pol2cart(P2(:,3),P2(:,1),P2(:,2));
%     elseif i == 3
%         n = 4;
% %         P = P3';
%         [P(1,:),P(2,:),P(3,:)] = pol2cart(P3(:,3),P3(:,1),P3(:,2));
%     elseif i == 4
%         n = 9;
% %         P = P4';
%         [P(1,:),P(2,:),P(3,:)] = pol2cart(P4(:,3),P4(:,1),P4(:,2));
%     end
    n = i;
    P = Px(i).myP';
    
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
    vol_area(i) = vol_area(i)/len*lenz*n;
    
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
    shp = alphaShape(P(1,:)',P(2,:)',P(3,:)',15,'HoleThreshold',9999);
    vol_alpha(i) = volume(shp);
    
    % Clear array
    P = [];
end

%% Plot results
t = 1:9;
t = 10-t;
tt = [5,5,6,7,8,10,14,20,40];
MRI = 53950.2629242117;
figure;
hold on
plot(tt,vol_alpha,'m','DisplayName','Alphashape');
plot(tt,vol_area,'y','DisplayName','Sum of area');
plot(tt,vol_bul,'c','DisplayName','Bullet formula');
plot(tt,vol_mvee,'g','DisplayName','MVEE');
plot(tt,vol_tri,'b','DisplayName','Trisurf');
plot(tt,ones(9,1)*MRI,'r','DisplayName','MRI')
hold off
% xlabel('Every nth slice taken')
xlabel('Number of slices taken')
ylabel('Volume calculated (mm^3)')
legend('Location','southeast')

error_alpha = (vol_alpha-MRI)/MRI*100;
error_area = (vol_area-MRI)/MRI*100;
error_bul = (vol_bul-MRI)/MRI*100;
error_mvee = (vol_mvee-MRI)/MRI*100;
error_tri = (vol_tri-MRI)/MRI*100;

figure;
hold on
plot(tt,error_alpha,'m','DisplayName','Alphashape');
plot(tt,error_area,'y','DisplayName','Sum of area');
plot(tt,error_bul,'c','DisplayName','Bullet formula');
plot(tt,error_mvee,'g','DisplayName','MVEE');
plot(tt,error_tri,'b','DisplayName','Trisurf');
plot(tt,zeros(9,1),'r','DisplayName','MRI')
hold off
% xlabel('Every nth slice taken')
xlabel('Number of slices taken')
ylabel('% error compared to ground truth (%)')
legend('Location','southeast')

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