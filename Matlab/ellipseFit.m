function fitval = ellipseFit(lenx,leny,angles,centy)
    fitx = fit(angles,lenx,'poly2');
    
    hei = 35*tan(angles);
    
    fity = fit(hei,leny,'poly2');
    
    fitdist = fit(angles,centy,'poly2');
    
    fitval = [fitx.p1,fitx.p2,fitx.p3;
              fity.p1,fity.p2,fity.p3;
              fitdist.p1,fitdist.p2,fitdist.p3];
end