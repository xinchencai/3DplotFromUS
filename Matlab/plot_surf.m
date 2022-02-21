function plot_surf (US,P, c, len, lenx, leny, lenz, layer, x_dist, y_dist, z_dist)
    area = 0;
    area_max = 0;
    index = 0;
    index2 = 0;
    
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
    
    % Find ellipse with largest area 
    j = 1;
    for i = 1:len
        % Find area
        if rem(i-1,layer)==0
            area = pi * xe(j) * ye(j);
            if area > area_max
                area_max = area;
                index = i;
                index2 = j;
            end
            j = j + 1;
        end
    end
    
    % Plot ellipse
    image('CData',US(index).myus,'XData',[0 lenx],'YData',[0 leny])
    hold on
    
    % Plot user points
    x1 = []; y1 = [];
    for j = 1:length(P(:,1))
        if P(j,3) == index/len*lenz
            x1 = [x1,P(j,1)];
            y1 = [y1,P(j,2)];
        end
    end
    [TriIdx, area_poly] = convhull(x1',y1');
    plot(x1,y1,'.');
    plot(x1(TriIdx),y1(TriIdx),'g');
    hold off
end