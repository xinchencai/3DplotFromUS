function T = findFile
    t = clock;
    time = findName(t);
    file = strcat('C:\Users\xinch\Downloads\6-axis Standard Software for Windows PC\PC Software _JY61 For WT61C BWT61 BWT61CL\PC Software _JY61 For WT61C BWT61 BWT61CL\Data\',time,'.txt');
    T = [];
    t(6) = floor(t(6));
    check = true;
    while(check)
        try
            T = readtable(file);
            check = false;
        catch
            if t(6) == 0
                t(6) = 59;
                if t(5) == 0
                    t(5) = 59;
                    if t(4) == 0
                        t(4) = 23;
                        t(3) = t(3) - 1;
                    else
                        t(4) = t(4) - 1;
                    end
                else
                    t(5) = t(5) - 1;
                end
            else        
                t(6) = t(6) - 1;
            end
        end
        time = findName(t);
        file = strcat('C:\Users\xinch\Downloads\6-axis Standard Software for Windows PC\PC Software _JY61 For WT61C BWT61 BWT61CL\PC Software _JY61 For WT61C BWT61 BWT61CL\Data\',time,'.txt');
    end
end