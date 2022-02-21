function P1 = linear2angle(P1)

    % P1(:,3) = P1(:,3)/40*36;
    % P1(:,3) = ceil(P1(:,3));
    angle = linspace(-30,30,36);
    angle = angle/180*pi;
    for i = 1: length(P1)
        P1(i,3) = angle(P1(i,3));
    end
    
end