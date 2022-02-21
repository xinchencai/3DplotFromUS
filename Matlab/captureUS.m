function [US,time] = captureUS
    time = [];
    j = 1;
    global cont;
    cont = true;
    for i = 1:5
        pause(1);
        beep
    end
    
    % Create UI window
    f = figure('Position', [10 10 10 10]);
    set(f,'WindowKeyPressFcn',@captureCallback);

    while(cont)
%     for i = 1:36
        US(j).myus = screencapture(0, [308,160,725,464]);
        time = [time;clock];
        j = j + 1;
        pause(0.1);
    end
    beep
%     for i = 1:length(US)
%         imshow(US(i).myus)
%     end
end