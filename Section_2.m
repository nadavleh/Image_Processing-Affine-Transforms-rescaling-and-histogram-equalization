%% Section 2 - Zoom in.

% Load the picture and zoom into a small piece.
load wbarb;
imSmall=X(27:90,125:188);

% Zero - order interpolation.
Interp_0 = zeros(128);
Interp_0(2:2:end,2:2:end) = imSmall;
Interp_0(1:2:end,1:2:end) = imSmall;
Interp_0(1:2:end,2:2:end) = imSmall;
Interp_0(2:2:end,1:2:end) = imSmall;
figure(1);
image(Interp_0);
title('Interp 0');
colormap gray;

% First order interpolation.
Interp_1 = zeros(128);
Interp_1(2:2:end,2:2:end) = imSmall;
h = [0.25 0.5 0.25 ; 0.5 1 0.5 ; 0.25 0.5 0.25];
Interp_1 = conv2(Interp_1,h,'same');
figure(2);
image(Interp_1);
title('Interp 1');
colormap gray;

% Saves the matrices into .mat file format.
save('Interp_Matrices.mat','Interp_0','Interp_1');
