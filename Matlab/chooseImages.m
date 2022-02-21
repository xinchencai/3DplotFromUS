function [US2,time2] = chooseImages(US,time)

    global myStruct;
    global myTime;
    global checker;
    myStruct = US;
    myTime = time;
    checker = 1;
    f = figure;
    imshow(US(checker).myus)
%     set(f,'WindowKeyPressFcn',@(hObject, event) spaceCallback(hObject, event));
    set(f,'WindowKeyPressFcn',@spaceCallback);
    uiwait;
    US2 = myStruct;
    time2 = myTime;
    
end