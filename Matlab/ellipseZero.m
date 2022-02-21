function zerox = ellipseZero(fitval)
    
    % when length = 0
    zerox(1) = (-fitval(1,2)+sqrt(fitval(1,2)^2-4*fitval(1,1)*fitval(1,3)))/(2*fitval(1,1));
    zerox(2) = (-fitval(1,2)-sqrt(fitval(1,2)^2-4*fitval(1,1)*fitval(1,3)))/(2*fitval(1,1));
    if zerox(1)>zerox(2)
        temp = zerox(1);
        zerox(1) = zerox(2);
        zerox(2) = temp;
    end
end