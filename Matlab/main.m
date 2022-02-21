clear;
clc;

%%
% Sample data (Debug)
file = strcat('210304184454.txt');
T = readtable(file);
time = table2array(T(:,2));
time = milliseconds(time - time(1));
accel = table2array(T(:,3:5));
waccel = table2array(T(:,6:8));
angle = table2array(T(:,9:11));

%%
% Get data
timenow = [];
timenow = [timenow;clock];
df = findData(time);

%%
% Calibrate IMU
cal = calibrateGravity(df);

%%
% Get calibration data (Debug)
df = [accel(1:1000,:),waccel(1:1000,:),angle(1:1000,:)];
cal = calibrateGravity(df);
df2 = [accel(1001:3271,:),waccel(1001:3271,:),angle(1001:3271,:)];
[grav,gravmag] = calcGravity(cal,df2);
df3(:,1:3) = df2(:,1:3) - grav;

%%
% Plot data
figure;
hold on
plot(time(1001:3271),df2(:,1),'DisplayName','x');
plot(time(1001:3271),df2(:,2),'DisplayName','y');
plot(time(1001:3271),df2(:,3),'DisplayName','z');
legend('Location','southwest')
hold off

%%
% Get displacement
time_ave = (time(length(time))- time(1001))/(length(time)-1002);
% time_arr = linspace(1,time(length(time)),length(df3(:,i)));
for i = 1:3
%     vel(:,i) = cumtrapz(time_arr, df3(:,i));
%     disp(:,i) = cumtrapz(time_arr, vel(:,i));
    disp(:,i) = iomega(df3(:,i), time_ave, 3, 1);
%     disp(:,i) = iomega(df2(:,i), time_ave, 3, 1);
end


%%
% Get grf
prompt = "What is the patient's mass?";
mass = input(prompt);
force = [];
for i = 1: length(df3(:,1))
%     forcea = norm(df3(i,:))*mass;
    forcea = norm(df2(i,1:3))*mass;
    force = [force;forcea];
end

%%
% Plot data
figure;
hold on
plot(time(1001:3271),disp(:,1),'DisplayName','x');
plot(time(1001:3271),disp(:,2),'DisplayName','y');
plot(time(1001:3271),disp(:,3),'DisplayName','z');
% plot(time_arr,disp(:,1),'DisplayName','x');
% plot(time_arr,disp(:,2),'DisplayName','y');
% plot(time_arr,disp(:,3),'DisplayName','z');
legend('Location','southwest')
hold off