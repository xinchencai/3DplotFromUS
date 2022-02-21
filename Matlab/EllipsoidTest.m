clear
clc

% Define variables
a = 10; b = 10; c = 10;
vol_calc = 4/3 * pi * a * b * c;

% Calculate 2d slices of ellipsoid
t = linspace(0,2*pi,22);
p = linspace(0,pi,22);
[T,P] = meshgrid(t,p);
xe = a*cos(T).*cos(P) + 2 * rand( 22, 22 ,'double') - 1;
ye = b*cos(T).*sin(P) + 2* rand( 22, 22 ,'double') - 1;
ze = c*sin(T) + 2 * rand( 22, 22 ,'double') - 1;

P = [xe(:),ye(:),ze(:)];
tolerance = 1;
plot3 (P(:,1),P(:,2),P(:,3),'.')
hold on;

[A , c] = MinVolEllipse(P', tolerance);
x_dist = sqrt(1/A(3,3));
y_dist = sqrt(1/A(2,2));
z_dist = sqrt(1/A(1,1));

[X,Y,Z] = ellipsoid(c(1),c(2),c(3),x_dist,y_dist,z_dist);
plot3(X,Y,Z,'r');
hold off;

vol0 = (4/3)*pi;
vol = vol0/sqrt(det(A));
