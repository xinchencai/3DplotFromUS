x_dist_max(1) = (max(P1(:,1)) - min(P1(:,1)));
y_dist_max(1) = (max(P1(:,2)) - min(P1(:,2)));
z_dist_max(1) = (max(P1(:,3)) - min(P1(:,3)));

x_dist_max(2) = (max(P2(:,1)) - min(P2(:,1)));
y_dist_max(2) = (max(P2(:,2)) - min(P2(:,2)));
z_dist_max(2) = (max(P2(:,3)) - min(P2(:,3)));

x_dist_max(3) = (max(P3(:,1)) - min(P3(:,1)));
y_dist_max(3) = (max(P3(:,2)) - min(P3(:,2)));
z_dist_max(3) = (max(P3(:,3)) - min(P3(:,3)));

x_dist_max(4) = (max(P4(:,1)) - min(P4(:,1)));
y_dist_max(4) = (max(P4(:,2)) - min(P4(:,2)));
z_dist_max(4) = (max(P4(:,3)) - min(P4(:,3)));

x_dist_max = x_dist_max';
y_dist_max = y_dist_max';
z_dist_max = z_dist_max';