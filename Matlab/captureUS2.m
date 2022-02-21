function [angle,US] = captureUS2
    instrreset;
    disp('Press Ctrl+C to stop collecting data!')
    s=serial('com7','baudrate',115200) ;fopen(s) ;%Open Com Port
    f = 20;%DataFrequency
    t=0;
    cnt = 1;
    aa=[0 0 0];
    ww=[0 0 0];
    AA = [0 0 0];
    tt = 0;
    a=[0 0 0]';
    w=[0 0 0]';
    A=[0 0 0]';
    for i = 1:5
        pause(1);
        beep
    end
    for i = 1:36
        US(i).myus = screencapture(0, [308,160,725,464]);
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
                aa=[aa;a'];
                ww = [ww;w'];
                AA = [AA;A'];
                tt = [tt;t];
                cnt=cnt+1;
                t=t+0.01;
                End = fread(s,3,'uint8');
        end
        pause(0.1);
    end
    fclose(s);
    
% for i = 1:30
%     imshow(US(i).myus)
% end
end