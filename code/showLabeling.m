function img = showLabeling(pred)

labelColor = [
    128,  0,  0; % building
    128,128,  0; % tree
    128,128,128; % sky
    64,  0,128; % Car
    192,128,128; % sign
    128, 64,128; % road
    64, 64,  0; % Pedestrian
    64, 64,128; % fence
    192,192,128; % pole
    0,  0,192; % sidewalk
    0,128,192; % Cyclist
    ];

img = labelColor(pred(:),:);
img = reshape(img, [size(pred),3]);
img = uint8(img);
