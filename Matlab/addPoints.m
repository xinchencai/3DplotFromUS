function P = addPoints(P1,len)
    P = P1;

    arr1 = [];
    arr2 = [];
    tolerance = 1;
    slices = len-1;

    % Get first and last slice
    for i = 1:length(P(:,1))
        if(P(i,3)==P(1,3))
            arr1 = [arr1;P(i,1:2)];
        elseif(P(i,3)==P(length(P(:,1)),3))
            arr2 = [arr2;P(i,1:2)];
        end
    end

    % Get ave angle
    angle_ave = abs(P(1,3)-P(length(P(:,1)),3))/slices;
    zang1 = P(1,3);
    zang2 = P(length(P(:,1)),3);
    if(P(1,3)<P(length(P(:,1)),3))
        angle_ave = 0 - angle_ave;
    end
    % if(P(1,3)<P(length(P(:,1)),3))


    % MVEE algorithm
    [A1 , c1] = MinVolEllipse(arr1', tolerance);
    [A2 , c2] = MinVolEllipse(arr2', tolerance);

    % Define ellipse
    x_dist_1 = sqrt(1/A1(1,1)) - 2;
    y_dist_1 = sqrt(1/A1(2,2)) - 2;
    x_dist_2 = sqrt(1/A2(1,1)) - 2;
    y_dist_2 = sqrt(1/A2(2,2)) - 2;
    t = -pi:0.1:pi;

    x2 = x_dist_2 * cos(t) + c2(1);
    y2 = y_dist_2 * sin(t) + c2(2);

    % Generate ellipse
    while (x_dist_1 > 0 && y_dist_1 > 0)
        c1 = c1 - 2;
        x1 = x_dist_1 * cos(t) + c1(1);
        y1 = y_dist_1 * sin(t) + c1(2);
        zang1 = zang1 + angle_ave;
        z1 = ones(1,length(x1)) * zang1;
        P = [P;[x1',y1',z1']];
        x_dist_1 = x_dist_1 - 2;
        y_dist_1 = y_dist_1 - 2;
    end

    while (x_dist_2 > 0 && y_dist_2 > 0)
        c2 = c2 - 2;
        x2 = x_dist_2 * cos(t) + c2(1);
        y2 = y_dist_2 * sin(t) + c2(2);
        zang2 = zang2 - angle_ave;
        z2 = ones(1,length(x1)) * zang2;
        P = [P;[x2',y2',z2']];
        x_dist_2 = x_dist_2 - 2;
        y_dist_2 = y_dist_2 - 2;
    end
end