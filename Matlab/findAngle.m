function angle = findAngle(a)
    T = findFile;

    angle = [];
%     startApp = table2array(T(1,2));
    for j = 1:length(a(:,1))
        len = height(T);
        start = duration(a(j,4),a(j,5),floor(a(j,6)),(a(j,6)-floor(a(j,6)))*1000);
        for i = 1:len
            now = table2array(T(1,2));
            if now >= start
                angle = [angle;table2array(T(1,9))];
                break
            end
            T(1,:) = [];
        end
    end
end