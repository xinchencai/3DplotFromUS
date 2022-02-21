clear;
clc;

% Set up arduino
a = arduino('COM5','Uno','Libraries','I2C');

% Set up sensor
LSM6DS3 = device(a,'I2CAddress',0x6A);

% Define variables
f=20;%DataFrequce
t=0;
cnt=1;
aa=[0 0 0];
ww=[0 0 0];
tt = 0;
a=[0 0 0]';
w=[0 0 0]';
gyroRange = 2000;
accelRange = 16;
XAXISacc  = 0x28; % x-axis acceleration value register
YAXISacc  = 0x2A; % y-axis acceleration value register
ZAXISacc  = 0x2C; % z-axis acceleration value register
XAXISgyr  = 0x22; % x-axis gyroscope value register
YAXISgyr  = 0x24; % y-axis gyroscope value register
ZAXISgyr  = 0x26; % z-axis gyroscope value register

% Set up arduino
% writeRegister(d, XAXISacc, 0x4C);
% writeRegister(d, YAXISacc, 0x4C);
% writeRegister(d, ZAXISacc, 0x4C);
% writeRegister(d, XAXISgyr, 0x4C);
% writeRegister(d, YAXISgyr, 0x4C);
% writeRegister(d, ZAXISgyr, 0x4C);

while(1)
    % Read data from sensor
    a(1) = calcAccel(readRegister(LSM6DS3,XAXISacc, 1,'int16'),accelRange);
    a(2) = calcAccel(readRegister(LSM6DS3,YAXISacc, 1,'int16'),accelRange);
    a(3) = calcAccel(readRegister(LSM6DS3,ZAXISacc, 1,'int16'),accelRange);
    w(1) = calcGyro(readRegister(LSM6DS3,XAXISgyr, 1,'int16'),gyroRange);
    w(2) = calcGyro(readRegister(LSM6DS3,YAXISgyr, 1,'int16'),gyroRange);
    w(3) = calcGyro(readRegister(LSM6DS3,ZAXISgyr, 1,'int16'),gyroRange);

    % Enter data into array
    aa = [aa;a'];
    ww = [ww;w'];
    tt = [tt;t];
    
    % Plot data
    if (cnt>(f/5)) %Plot in low frequce, 
        subplot(2,1,1);plot(tt,aa);title(['Acceleration = ' num2str(a') 'm2/s']);ylabel('m2/s');
        subplot(2,1,2);plot(tt,ww);title(['Gyro = ' num2str(w') 'ω/s']);ylabel('ω/s');        
        cnt=0;
        drawnow;
        if (size(aa,1)>5*f)%clear history data
            aa = aa(f:5*f,:);
            ww = ww(f:5*f,:);
            tt = tt(f:5*f,:);
        end
    end
    cnt=cnt+1;
    t=t+0.01;
end

% x_data=bitsra(xacc,2);
% y_data=bitsra(yacc,2);
% z_data=bitsra(zacc,2);

function val = calcAccel(x,accelRange)
    accel = bitsll(accelRange,1);
    val = x * 0.061 * accel / 1000;
end

function val = calcGyro(x,gyroRange)
    gyroRangeDivisor = uint8(gyroRange/125);
    if gyroRange == 245
        gyroRangeDivisor = 2;
    end
    val = x * 4.375 * double(gyroRangeDivisor) / 1000;
end