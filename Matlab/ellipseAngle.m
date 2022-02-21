function [newLenx,newLeny] = ellipseAngle(theta,fitval)
    newLenx = fitval(1,1)*theta.^2+fitval(1,2)*theta+fitval(1,3);
    
    hei = 35*tan(theta);
    
    newLeny = fitval(2,1)*hei.^2+fitval(2,2)*hei+fitval(2,3);

end