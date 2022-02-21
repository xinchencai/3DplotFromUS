function [US2,P2] = correctImages(US,P,lenx,leny,n)
    
    % Declare variables
    global myStruct;
    global myUS;
    global checker;
    myStruct = US;
    checker = 1;
    P2 = [];
    list = [];
    j = 1;
    k = 1;
    
    % Check removed slices
    for i = 1:length(US)
        if rem(i-1,n)~=0
            myStruct(k) = [];
        else
            k = k + 1;
        end
    end
        
    % Shift array
    P(:,1) = P(:,1)/lenx;
    P(:,2) = P(:,2)/leny;
    
    % Split array into struct
    for i = 1:length(P)
        if i == 1
            list = [list;P(i,:)];
        elseif P(i,3) == P(i-1,3)
            list = [list;P(i,:)];
        else
            myUS(j).myus = list;
            j = j + 1;
            list = [];
            list = [list;P(i,:)];
        end
    end

    myUS(j).myus = list;
    list = [];
    
    % Show images and plot
    f = figure;
    hold on;
    image('CData',myStruct(checker).myus,'XData',[0 1],'YData',[0 1]);
    plot(myUS(checker).myus(:,1),myUS(1).myus(:,2),'.');
    hold off;
    set(f,'WindowKeyPressFcn',@correctCallback);
    uiwait;
    
    % Shift array
    for i = 1:length(myUS)
        P2 = [P2;myUS(i).myus];
    end
    P2(:,1) = P2(:,1)*lenx;
    P2(:,2) = P2(:,2)*leny;
    US2 = myStruct;
    
end