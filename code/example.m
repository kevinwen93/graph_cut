

im = imread('../data/4.png');
load('../data/u4.mat'); 
saveName = '../data/r4_444.png';

% make sure that you have successfully compiled gco library
addpath(genpath('gco-v3.0'));

%% Example: Unary Only 
[~, uLabel] = min(unary,[],3);
uImg = showLabeling(uLabel);

%% Example: MRF 
[height, width, numLabels] = size(unary); 
numSites = height*width;
% Create a graph object. 
h = GCO_Create(numSites, numLabels);

% Set unary cost. 
GCO_SetDataCost(h, int32(reshape(unary(:),numSites,numLabels))'); 

% Set pairwise label penalty.
GCO_SetSmoothCost(h, ones(numLabels)-diag(ones(1,numLabels))); 

%k function 

% Set affinity map and cost. 
aff = sparse(zeros(numSites));
aff = mrf2dLattice(aff,1,width,height,numSites,2);% Change this!!
[rows,cols] = find(aff)

for i=1:length(rows)
    aff(rows(i),cols(i)) = crf2dLattice(im,rows(i),cols(i),height,width,4,4,4);
end

GCO_SetNeighbors(h, aff);

% Run graph cut; alpha-expansion. 
GCO_Expansion(h);
mrfLabel = GCO_GetLabeling(h);
mrfLabel = reshape(mrfLabel,height,width);
GCO_Delete(h);

mrfImg = showLabeling(mrfLabel);

%% Compare Labelings
subplot(3,1,1); imshow(im); % input 
subplot(3,1,2); imshow(uImg); % unary only
subplot(3,1,3); imshow(mrfImg); % mrf 
saveas(gcf,saveName);