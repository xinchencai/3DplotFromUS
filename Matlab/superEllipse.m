function ellipse = superEllipse(x_len,y_len,e,tp,cb,c,x_size,y_size)
    t = -pi:0.1:pi;
    
    x1 = real(x_len*(cos(t).^e)+c(1));
    y1 = real(y_len*(sin(t).^e)+c(2));
    x1 = x1/x_len*x_size;
    y1 = y1/y_len*y_size;
    x_shift = ((max(x1)-min(x1))/2)+min(x1)-c(1);
    y_shift = ((max(y1)-min(y1))/2)+min(y1)-c(2);
    x1 = x1 - x_shift;
    y1 = y1 - y_shift;
    x_tp = (tp*y1/y_len+1).*x1;
    gamma = x_tp./(y_len/cb-y1);
    x2 = (y_len/cb-y1).*sin(gamma);
    y2 = (y_len/cb)-(y_len/cb-y1).*cos(gamma);
    x2 = real(x2);
    y2 = real(y2);
    
    ellipse = [x2;y2]';