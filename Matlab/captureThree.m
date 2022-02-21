function [US,time] = captureThree
    time = [];
    
    % Create UI window
    f = figure('Position', [10 10 10 10]);

    for i = 1:3
        set(f,'WindowKeyPressFcn',@captureOneCallback);
        uiwait;
        US(i).myus = screencapture(0, [308,160,725,464]);
        time = [time;clock];
        beep;
    end
    close;
%     for i = 1:length(US)
%         imshow(US(i).myus)
%     end
end