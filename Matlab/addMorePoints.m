function [P,fitval] = addMorePoints(P1,idx)
    P = P1;
    USpt = struct;
    tolerance = 1;

    for i = 1:3
        x_size(i) = idx(6,1,i);
        y_size(i) = idx(6,2,i);
        e(i) = idx(1,2,i);
        tp(i) = idx(3,2,i);
        cb(i) = idx(4,2,i);
        x_len(i) = idx(5,1,i);
        y_len(i) = idx(5,2,i);
    end
    
    % Get slices
    USpt = arrayBreaker(P);
    for i = 1:3
        angle(i) = USpt(i).myus(1,3);
    end
%     for i = 1:length(P(:,1))
%         if(P(i,3)==P(1,3))
%             arr1 = [arr1;P(i,1:2)];
%         elseif(P(i,3)==P(length(P(:,1)),3))
%             arr3 = [arr3;P(i,1:2)];
%         else
%             arr2 = [arr2;P(i,1:2)];
%         end
%     end
    
    % Find center
    for i = 1:3
        c(1,i)=mean([max(USpt(i).myus(:,1)),min(USpt(i).myus(:,1))]);
        c(2,i)=mean([max(USpt(i).myus(:,2)),min(USpt(i).myus(:,2))]);
    end
    center = c(:,2);
    
    % Quadratic fit
    fitval = ellipseFit(x_size',y_size',angle',c(2,:)');
    zerox = ellipseZero(fitval);
    
    % Get ave angle
    angle_ave_1 = (angle(2)-angle(1))/20;
    angle_ave_2 = (angle(2)-angle(3))/20;

    % Get ave length
    x_len_ave_1 = abs((x_size(2)-x_size(1))/20);
    x_len_ave_2 = abs((x_size(2)-x_size(3))/20);
    y_len_ave_1 = abs((y_size(2)-y_size(1))/20);
    y_len_ave_2 = abs((y_size(2)-y_size(3))/20);
    
    % Generate superellipse
    for i = 1:19
        zang1 = angle(2) - (angle_ave_1*i);
        [x_len_1,y_len_1] = ellipseAngle(zang1,fitval);
%         x_len_1 = x_size(2)-(x_len_ave_1*i);
%         y_len_1 = y_size(2)-(y_len_ave_1*i);
        ellipse = superEllipse(x_len(2),y_len(2),e(2),tp(2),cb(2),center,x_len_1,y_len_1);
        z1 = ones(length(ellipse(:,1)),1) * zang1;
        P = [P;ellipse,z1];
    end

    for i = 1:19
        zang1 = angle(2) - (angle_ave_2*i);
        [x_len_1,y_len_1] = ellipseAngle(zang1,fitval);
%         x_len_1 = x_size(2)-(x_len_ave_2*i);
%         y_len_1 = y_size(2)-(y_len_ave_2*i);
        ellipse = superEllipse(x_len(2),y_len(2),e(2),tp(2),cb(2),center,x_len_1,y_len_1);
        z1 = ones(length(ellipse(:,1)),1) * zang1;
        P = [P;ellipse,z1];
    end

    zang = angle(1) - angle_ave_1;
    [x_len_2,y_len_2] = ellipseAngle(zang,fitval);
    
    while (x_len_2 > 0 && y_len_2 > 0)
%     while (zang < zerox(2) && zang > zerox(1))
%         x_len_2 = x_len_2-x_len_ave_1;
%         y_len_2 = y_len_2-y_len_ave_1;
        ellipse = superEllipse(x_len(1),y_len(1),e(1),tp(1),cb(1),center,x_len_2,y_len_2);
        z1 = ones(length(ellipse(:,1)),1) * zang;
        P = [P;ellipse,z1];
        zang = zang - angle_ave_1;
        [x_len_2,y_len_2] = ellipseAngle(zang,fitval);
    end

    zang = angle(3) - angle_ave_2;
    [x_len_2,y_len_2] = ellipseAngle(zang,fitval);

    while (x_len_2 > 0 && y_len_2 > 0)
%     while (zang < zerox(2) && zang > zerox(1))
%         x_len_2 = x_len_2-x_len_ave_2;
%         y_len_2 = y_len_2-y_len_ave_2;
        ellipse = superEllipse(x_len(3),y_len(3),e(3),tp(3),cb(3),center,x_len_2,y_len_2);
        z1 = ones(length(ellipse(:,1)),1) * zang;
        P = [P;ellipse,z1];
        zang = zang - angle_ave_2;
        [x_len_2,y_len_2] = ellipseAngle(zang,fitval);
    end
end