clear;
clc;

tol = 1;
err = 0;
min = 99999;
idx = 0;

US = imread('SweepScan/13.jpg');

image('CData',US,'XData',[0 1],'YData',[0 1]);
[line,x,y]=freehanddraw;

arr = [x,y]';
[A , c] = MinVolEllipse(arr, tol);
area_draw = polyarea(x,y);

x_dist = sqrt(1/A(1,1));
y_dist = sqrt(1/A(2,2));
t = linspace(-pi,pi,length(x));
x1 = x_dist*cos(t)+c(1);
y1 = y_dist*sin(t)+c(2);
x_min = [];
y_min = [];

% min = 99999;
% x1 = x1 - c(1);
% y1 = y1 - c(2);
% for i = 0:10
%     x2 = x1 * (0.5+(i*0.1));
%     for j = 0:10
%         y2 = y1 * (0.5+(j*0.1));
%         for k = 0:99
%             angle = pi/99*k;
%             x3 = x2.*cos(angle)- y2.*sin(angle)+c(1); % Rotate x
%             y3 = x2.*sin(angle)+ y2.*cos(angle)+c(2); % Rotate y
%             err = immse([x3;y3],arr);
%             if err < min
%                 min = err;
%                 x_min = x3;
%                 y_min = y3;
%             end
%         end
%     end
% end
% x1 = x1 + c(1);
% y1 = y1 + c(2);

min = 99999;
for i = 0:20
    x_dist_2 = x_dist * (0.5+(i*0.1));
    for j = 0:20
        y_dist_2 = y_dist * (0.5+(j*0.1));
        for k = 0:100
            e = 0.5 + (0.01*k);
            x2 = real(x_dist_2*(cos(t).^e)+c(1));
            y2 = real(y_dist_2*(sin(t).^e)+c(2));
            area_expt = polyarea(x2,y2);
            err = abs(area_draw-area_expt);
            if err < min
                idx = [i,j,k;x_dist_2,y_dist_2,e];
                min = err;
                x_min = x2;
                y_min = y2;
            end
        end
    end
end

hold on
image('CData',US,'XData',[0 1],'YData',[0 1]);
plot(arr(1,:),arr(2,:));
plot(x1,y1);
plot(x_min,y_min);