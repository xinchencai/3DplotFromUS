function name = findName(time)
    yy = int2str(time(1) - 2000);
    
    if time(2)/10 < 1
        mm = strcat('0',int2str(time(2)));
    else
        mm = int2str(time(2));
    end
    
    if time(3)/10 < 1
        dd = strcat('0',int2str(time(3)));
    else
        dd = int2str(time(3));
    end
    
    if time(4)/10 < 1
        hh = strcat('0',int2str(time(4)));
    else
        hh = int2str(time(4));
    end
    
    if time(5)/10 < 1
        min = strcat('0',int2str(time(5)));
    else
        min = int2str(time(5));
    end
    
    time(6)=floor(time(6));
    if time(6)/10 < 1
        ss = strcat('0',int2str(time(6)));
    else
        ss = int2str(time(6));
    end
    
    name = strcat(yy,mm,dd,hh,min,ss);
end