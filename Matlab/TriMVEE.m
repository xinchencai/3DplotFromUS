hold on;

% [TriIdx, vol_tri] = convhull(P3);
% trisurf(TriIdx, P3(:,1), P3(:,2), P3(:,3), 'FaceAlpha', 0, 'EdgeColor', 'g');

P = P4';

plot3(P(1,:),P(2,:),P(3,:),'.');

[A , c] = MinVolEllipse(P, tolerance);
x_dist = sqrt(1/A(1,1));
y_dist = sqrt(1/A(2,2));
z_dist = sqrt(1/A(3,3));
[X,Y,Z] = ellipsoid(c(1),c(2),c(3),x_dist,y_dist,z_dist);
plot3(X,Y,Z,'r');

x_dist_max = (max(P(1,:)) - min(P(1,:)));
y_dist_max = (max(P(2,:)) - min(P(2,:)));
z_dist_max = (max(P(3,:)) - min(P(3,:)));

x_dist_ave = min(P(1,:));
y_dist_ave = min(P(2,:));
z_dist_ave = min(P(3,:));
   
plotcube([x_dist_max,y_dist_max,z_dist_max],[x_dist_ave,y_dist_ave,z_dist_ave],0,[0,0,0])
   
hold off;