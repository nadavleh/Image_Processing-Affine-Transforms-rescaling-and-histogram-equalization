%% Section 3 - Rotating an image at 36 degrees in 10 iterations.
% This code rotates a picture around its middle point, in 360 degrees in 10
% iterations (every iterations is 36 degrees), Regardless of the image's and
% the zoom's size.
% We gave here 2 options for rotationg the image. Option 1 use the
% matlab function 'sub2ind' so that we could use the indexes as our grid.
% Option 2 use loops for the implementaion, which is not recommended in matlab. 

% Load the picture and zoom into a small piece.
load wbarb;
imSmall=X(27:90,125:188); 


[PicRows, PicCols] = size(X);
[SmallRows, SmallCols] = size(imSmall);

% Makes a full size matrix with the small picture in the middle.
ImC = zeros(PicRows, PicCols);
ImC( round((PicRows-SmallRows)/2):round((PicRows+SmallRows)/2)-1 ,round((PicCols-SmallCols)/2):round((PicCols+SmallCols)/2)-1 ) = imSmall;

% Sets the origin point at the middle and creating the x&y grid.
Origin = size(ImC)/2;
x = (-Origin(1)+1:Origin(1));
xx = ones(length(x),1)*x;
y = (-Origin(2)+1:Origin(2))';
yy = y*ones(1,length(y));

% Converts the linear coordinates to polar.
ImC_R = (xx.^2+yy.^2).^0.5;
ImC_Theta = atan2(yy,xx);

colormap gray;
tic
%% Option A - Using Sub2ind Matlab function
% The 'for' loop does 10 iterations of rotate and plot. 
for ii = 0:10
    
    % Adds the desired angle to the initial state angel and computes the
    % x&y new coordinates after the rotate.
    ImC_Theta_round = ImC_Theta + ii*pi/5;
    xx_round = round(ImC_R.*cos(ImC_Theta_round)) + Origin(1);
    yy_round = round(ImC_R.*sin(ImC_Theta_round)) + Origin(2);
    
    % Clears wrong values created because of the rotation (located outside
    % the image).
    xx_round = (xx_round(:,:)>0).*(xx_round(:,:)<257).*xx_round;
    xx_round = xx_round + ~xx_round;
    yy_round = (yy_round(:,:)>0).*(yy_round(:,:)<257).*yy_round;
    yy_round = yy_round + ~yy_round;
    
    % Converts the values into indexes and makes replacement according to
    % the indexes.
    ImCPlot = ImC(sub2ind(size(ImC),yy_round(:),xx_round(:)));
    ImCPlot = reshape(ImCPlot, PicRows, PicCols);
    
    %ImCPlot_R(:,:,1) = uint8(ImCPlot);
    %ImCPlot_R(:,:,2) = uint8(ImCPlot);
    %ImCPlot_R(:,:,3) = uint8(ImCPlot);
    
    % Plots the images and pause for 1 sec.
    imagesc(ImCPlot);
    %image(ImCPlot_R);
    title(['Rotation of: ', num2str(ii*36), ' Degrees']);
    pause(1);
end

%{
%% Option B - Using Loops
% Does everything the same as option A except for the placement (uses loops
% instead).
for ii = 0:10

    ImC_Theta_round = ImC_Theta + ii*pi/5;
    xx_round = round(ImC_R.*cos(ImC_Theta_round)) + Origin(1);
    yy_round = round(ImC_R.*sin(ImC_Theta_round)) + Origin(2);
    
    xx_round = (xx_round(:,:)>0).*(xx_round(:,:)<257).*xx_round;
    xx_round = xx_round + ~xx_round;
    yy_round = (yy_round(:,:)>0).*(yy_round(:,:)<257).*yy_round;
    yy_round = yy_round + ~yy_round;
    


    for jj = 1:256
        for kk = 1:256    
            ImCPlot(jj,kk) = ImC(xx_round(jj,kk),yy_round(jj,kk));           
        end
    end
      
    imagesc(ImCPlot);
    pause(1);
end
%}

