function [points,idx] = curveFitting(x,y)
    % Declare variables
    tol = 1;
    min_val = 99999;
    idx = 0;
    
    % Draw elipse using MVEE
%     tic;
    arr = [x,y]';
    [A , c] = MinVolEllipse(arr, tol);
    area_draw = polyarea(x,y);
    x_center = ((max(x)-min(x))/2)+min(x);
    y_center = ((max(y)-min(y))/2)+min(y);

    x_dist = sqrt(1/A(1,1));
    y_dist = sqrt(1/A(2,2));
    t = linspace(-pi,pi,length(x));
    x1 = x_dist*cos(t)+c(1);
    y1 = y_dist*sin(t)+c(2);
    x_min = [];
    y_min = [];

    % Minimise distance between point drawn and point on elipse
    for i = 1:length(x)
        x = [x(2:length(x));x(1)];
        y = [y(2:length(y));y(1)];
        err = minDistErr([x1;y1],[x,y]');
        if err < min_val
            min_val = err;
            arr = [x,y]';
        end
    end

    % Minimise squareness
    min_val = 99999;
    for i = 0:10
        x_dist_2 = x_dist * (0.5+(i*0.1));
        for j = 0:10
            y_dist_2 = y_dist * (0.5+(j*0.1));
            for k = 0:50
                e = 0.5 + (0.02*k);
                x2 = real(x_dist_2*(cos(t).^e)+c(1));
                y2 = real(y_dist_2*(sin(t).^e)+c(2));
                x_shift = ((max(x2)-min(x2))/2)+min(x2)-x_center;
                y_shift = ((max(y2)-min(y2))/2)+min(y2)-y_center;
                x2 = x2 - x_shift;
                y2 = y2 - y_shift;
                area_expt = polyarea(x2,y2);
                err = (minDistErr([x2;y2],arr)+(10*abs(area_draw-area_expt)))/2;
                if err < min_val
                    idx = [i,j,k;x_dist_2,y_dist_2,e];
                    min_val = err;
                    x_min = x2;
                    y_min = y2;
                end
            end
        end
    end

    % Minimise linear tapering
    min_val = 99999;
    for i = 0:100
        tp = -1 + (0.02*i);
        x_tp = (tp*y_min/idx(2,2)+1).*x_min;
        area_expt = polyarea(x_tp,y_min);
        err = (minDistErr([x_tp;y_min],arr)+(10*abs(area_draw-area_expt)))/2;
        if err < min_val
            idx(3,:) = [i,tp,0];
            min_val = err;
            x_tp_min = x_tp;
        end
    end

    % Minimise circular bending
    min_val = 99999;
    for i = 0:100
        cb = -1 + (0.02*i);
        gamma = x_tp_min./(idx(2,2)/cb-y_min);
        x_cb = (idx(2,2)/cb-y_min).*sin(gamma);
        y_cb = (idx(2,2)/cb)-(idx(2,2)/cb-y_min).*cos(gamma);
        area_expt = polyarea(x_cb,y_cb);
        err = (minDistErr([x_cb;y_cb],arr)+(10*abs(area_draw-area_expt)))/2;
        if err < min_val
            idx(4,:) = [i,cb,0];
            min_val = err;
            x_cb_min = x_cb;
            y_cb_min = y_cb;
        end
    end

    % Return values;
    points = [x_cb_min;y_cb_min]';
    
    % Plot graph
%     hold on
%     image('CData',US,'XData',[0 1],'YData',[0 1]);
%     plot(arr(1,:),arr(2,:));
%     plot(x1,y1);
%     plot(x_cb_min,y_cb_min);
%     time = toc;
end