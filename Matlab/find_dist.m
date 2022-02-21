function [xe,ye] = find_dist(ze,a,b,c)
    T = asin(ze/c);
    P = asin(0);
    xe = a*cos(T).*cos(P);
    P = acos(0);
    ye = b*cos(T).*sin(P);
end