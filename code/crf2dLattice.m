function k = crf2dLattice(im, i, j, height,width,p,v,b)
    yi = mod(i, height);
    xi = floor(i/height)+1;
    yj = mod(j, height);
    if yi == 0
        yi = height;
    end
    if yj == 0
        yj = height;
    end
    xj = floor(j/height)+1; 
    if(xi > width)
        xi = width;
    end
    if(xj > width)
        xj = width;
    end
    imis = im(yi,xi,:);
    imjs = im(yj,xj,:);
    imi = zeros(1,3);
    imj = zeros(1,3);
    for h = 1:3
        imi(h) = imis(1,1,h);
        imj(h) = imjs(1,1,h);
    end
    
    k = p+v*exp(-b*sqrt(sum((imi-imj).^2)));
    
end