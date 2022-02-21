function plot_all (US,P, c, len, lenz, layer, x_dist, y_dist, z_dist)
    % Calculate axial length of each ellipse layer
    xe = [];ye = [];
    for i = 1:len
        if rem(i-1,layer)==0
            ze = i-(len/2)-0.5;
            [a,b]=find_dist(ze,x_dist,y_dist,z_dist);
            xe = [xe,a];
            ye = [ye,b];
        end
    end
    
    % Plot 2d slices
    k = 1;
    l = 1;
    for i = 1:len
        if rem(i-1,layer)==0
            t = -2*pi:0.1:2*pi;
            x_elp = xe(l)*cos(t)+c(1);
            y_elp = ye(l)*sin(t)+c(2);
            if k == 1
                figure;
            end
            subplot(3,2,k);
            image('CData',US(i).myus,'XData',[0 len],'YData',[0 len])
            hold on
            plot(x_elp,y_elp,'g');
            x1 = []; y1 = [];
            for j = 1:length(P(:,1))
                if P(j,3) == i/len*lenz
                    x1 = [x1,P(j,1)];
                    y1 = [y1,P(j,2)];
                end
            end
            plot(x1,y1,'.');
            if length(x1) > length(x_elp) 
                fit = mean(goodnessOfFit([x1(1:length(x_elp));y1(1:length(y_elp))]',[x_elp;y_elp]','NRMSE'));
            elseif length(x1) < length(x_elp)
                fit = mean(goodnessOfFit([x1;y1]',[x_elp(1:length(x1));y_elp(1:length(y1))]','NRMSE'));
            else
                fit = mean(goodnessOfFit([x1;y1]',[x_elp;y_elp]','NRMSE'));
            end
            my_str = strcat('Fitness index: ',num2str(fit));
            uicontrol('Style','text','Position',find_pos(k),'String',my_str);
            hold off
            k = k + 1;
            if k > 6
                k = 1;
            end
        l = l + 1;    
        end
    end
end