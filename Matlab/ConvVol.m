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
    i5 = i5 * i / 36 * lenz;
    P = [P;x,y,i5];
end

% Plot user input points
% plot3(P(1,:),P(2,:),P(3,:),'.');
% hold on

% Convhull algorithm
[TriIdx, V] = convhull(P);
trisurf(TriIdx, P(:,1), P(:,2), P(:,3));