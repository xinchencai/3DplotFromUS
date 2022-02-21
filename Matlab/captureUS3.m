function [anglea,angleb,US] = captureUS2
    instrreset;
    disp('Press Ctrl+C to stop collecting data!')
    s=serial('com7','baudrate',115200) ;fopen(s) ;%Open Com Port
    f = 20;%DataFrequency
    t=0;
    cnt = 1;
    anglea = 0; angleb = 0;
    a=[0 0 0]';
    w=[0 0 0]';
    A=[0 0 0]';
    
    test = 0;
    while test == 0
        Head = fread(s,2,'uint8');
        if (Head(1)~=uint8(85))
            continue;
        end    
        switch(Head(2))
            case 81 
                a = fread(s,3,'int16')/32768*16 ;     
                End = fread(s,3,'uint8');
            case 82 
                w = fread(s,3,'int16')/32768*2000 ;    
                End = fread(s,3,'uint8');
            case 83 
                A = fread(s,3,'int16')/32768*180;
                cnt=cnt+1;
                t=t+0.01;
                End = fread(s,3,'uint8');
                anglea = A(1)/180*pi;
                test = 1;
        end
    end
    for i = 1:5
        pause(1);
        beep
    end
    for i = 1:36
        US(i).myus = screencapture(0, [308,160,725,464]);
        pause(0.1);
    end
    
    beep;
    pause(10);
    test = 0;
    while test == 0
        Head = fread(s,2,'uint8');
        if (Head(1)~=uint8(85))
            continue;
        end    
        switch(Head(2))
            case 81 
                a = fread(s,3,'int16')/32768*16 ;     
                End = fread(s,3,'uint8');
            case 82 
                w = fread(s,3,'int16')/32768*2000 ;    
                End = fread(s,3,'uint8');
            case 83 
                A = fread(s,3,'int16')/32768*180;
                cnt=cnt+1;
                t=t+0.01;
                End = fread(s,3,'uint8');
                angleb = A(1)/180*pi;
                test = 1;
        end
    end
    
    fclose(s);
    
%     angle = (abs(anglea) + abs(angleb))/length(US);
    beep
    
% for i = 1:30
%     imshow(US(i).myus)
% end
end