function P = customPoly(P1,fitval)
    P = [];

    % Get slices
    USpt = arrayBreaker(P1);
    for i = 1:length(USpt)
        angle(i) = USpt(i).myus(1,3);
    end
    
    % Resize
    for i = 1:length(USpt)
        xLenOld = max(USpt(i).myus(:,1))-min(USpt(i).myus(:,1));
        yLenOld = max(USpt(i).myus(:,2))-min(USpt(i).myus(:,2));
        [xLenNew,yLenNew] = ellipseAngle(angle(i),fitval);
        USpt(i).myus(:,1) = USpt(i).myus(:,1)/xLenOld*xLenNew;
        USpt(i).myus(:,2) = USpt(i).myus(:,2)/yLenOld*yLenNew;
        P = [P;USpt(i).myus];
    end
    
    % Reposition
    P = shiftCorrect(P,fitval);
end