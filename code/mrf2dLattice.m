function aff=mrf2dLattice(aff, theta,width,height,numSites, mode)

if(mode == 1)      
    aff = aff + sparse(diag(ones(1,numSites-1),1));
else
 a = sparse(diag(ones(1,numSites-width),width) * theta);
 position = [height:height:numSites-height];
 b = zeros(1,numSites-1);
 b(position) = theta;
 c = ones(1,numSites-1)*theta-b;
 c = sparse(diag(c,1));
 
 aff = aff+a+c;
end
end