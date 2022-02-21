function [newLenx,newLeny] = ellipseFit(theta,lenx,leny)
    a1 = -86.12;
    b1 = 0.4514;
    c1 = 49.91;
    
    newLenx = a1*theta.^2+b1*theta+c1;
    newLenx = newLenx/2;
    newLenx = newLenx/25*lenx;
    
    a2 = -0.0992;
    b2 = 0.4429;
    c2 = 44.59;
    hei = 35*tan(theta);
    
    newLeny = a2*hei.^2+b2*hei+c2;
    newLeny = newLeny/2;
    newLeny = newLeny/22.5*leny;
end