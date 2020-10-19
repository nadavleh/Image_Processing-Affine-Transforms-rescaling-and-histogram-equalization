%% Section 4 - Histogram and Tension.

% Load the picture.
load wbarb;

%% 4.1 - Makes an histogram and calculates the mean value and the standard deviation. 
figure(1);
hist(X(:),256);
title('Original Image Histogram');

mu_4_1 = mean(X(:));
Sigma_4_1 = std(X(:));

%% 4.2 - standardization.

mu_4_2 = [50 50 200 200 160];
Sigma_4_2 = [10 100 10 100 70];

for n = 1:5
    NewImage(:,:,n) = (X - mu_4_1)*Sigma_4_2(n)/Sigma_4_1 + mu_4_2(n);
    Temp = NewImage(:,:,n);
    
    figure(2*n);
    hist(Temp(:),256);
    title(['Expected value = ',num2str(mu_4_2(n)),', Standard Deviation = ',num2str(Sigma_4_2(n))]);
    figure(2*n+1);
    image(NewImage(:,:,n));
    title(['Expected value = ',num2str(mu_4_2(n)),', Standard Deviation = ',num2str(Sigma_4_2(n))]);
    colormap gray;
end


%% 4.3 - Uniform Histogram.

%% 4.3 Option A: Discreet Solution.
NormX = round(X*256/192);
[MatIm(:,1), MatIm(:,2)] = sort(NormX(:));

for ii = 1:256  
    MatIm(256*(ii-1)+1:256*(ii)) = ii;
end

[Val, Index] = sort(MatIm(:,2));
MatIm(:,1) = MatIm(Index,1);
UniIm = reshape(MatIm(:,1),256,256);

figure;
imagesc(uint8(UniIm));
title('Uniform Distribution');
colormap gray(256)
figure;
hist(UniIm(:),256);
title('Uniform Distribution Histogram');


%% 4.3 Option B: Analitical Solution.
%{
% Converts type from double to unsigned integer of 8 bit.
Im = uint8(X);
[m, n] = size(Im);

% Initialize output image matrix.
EqualizedIm = zeros(m,n);

% Image histogram of 255 bins/pixel_num is the prob. Density function.
figure(12);
imhist(Im);
ProbIm = imhist(Im)/(n*m);

% Define the function between variables as in theory.
T = round(255*cumsum(ProbIm));

for ii = 1:m
    for jj = 1:n
        % Every value in image A would be equal to the cumulative sum of
        % X's pdf up to X=x, that is x = Im(i,j).        
        EqualizedIm(ii,jj) = T(Im(ii,jj)+1);
    end
end

% Display two images side by side, full screen. 
out = [Im zeros(256,2) EqualizedIm];
figure(13);
figure('units','normalized','outerposition',[0 0 1 1]);
imagesc(out);
colormap gray
set(gcf,'MenuBar','none');
set(gca,'DataAspectRatioMode','auto');
set(gca,'Position',[0 0 1 1]);

% Display histograms.
figure(14);
subplot(1,2,1);
histogram(Im,256);
xlabel('Pixel Intensity');
ylabel('Pixel Count');
title('Input Image Histogram');
subplot(1,2,2);
histogram(EqualizedIm,256);
xlabel('Pixel Intensity');
ylabel('Pixel Count');
title('Equalized Image Histogram');
%}

%% 4.4 - Normal Histogram.
%% 4.4 Option A: Discreet Solution.
NormX = round(X*256/192);
[MatIm_4_4(:,1), MatIm_4_4(:,2)] = sort(NormX(:));

% Temporary value that were found suitable for the original image.
Mu_4_4 = 128;
Sigma_4_4 = 44.337;
Counter = 0;

for ii = 1:256      
    % PDF function for normal distribution.
    PDF = round(256*256*((Sigma_4_4*((2*pi)^0.5))^-1) * exp(-((ii-Mu_4_4)^2)/(2*Sigma_4_4*Sigma_4_4)));
    
    MatIm_4_4(ii+Counter:ii+Counter+PDF,1) = ii;
    Counter = Counter + PDF;
end

[Temp, Index] = sort(MatIm_4_4(:,2));
MatIm_4_4(:,1) = MatIm_4_4(Index,1);
NormalDis = reshape(MatIm_4_4(:,1),256,256);

% Using Section's 4.2 formula to change the standard deviation and the mean value. 
NormalDis = (NormalDis - Mu_4_4)*sqrt(70)/Sigma_4_4 + 160;

figure;
imagesc(uint8(NormalDis));
title('Normal Distribution');
colormap gray(256)
figure;
hist(NormalDis(:),256);
title('Normal Distribution Histogram: \sigma~70^{0.5}, \mu=160');

%% 4.4 Option B: Analitical Solution.
%{
Im = X;
Im = uint8(Im);
[m, n] = size(Im);
EqualizesIm = zeros(m,n);
NormalizedIm = zeros(m,n);
mu_4_2 = 160; Sigma_4_2 = 70^0.5;
 
% image histogram of 255 bins/pixel_num is the prob. density function
figure(15);
ProbIm = imhist(Im)/(m*n);

%define the function between variables as in theory
T = round(255*cumsum(ProbIm));
 
for ii = 1:m
    for jj=1:n
        % Every value in image A would be equal to the cumulative sum of
        % X's pdf up to X=x,that is x = im(i,j). 
        EqualizesIm(ii,jj)=T(Im(ii,jj)+1);
    end
end

for ii = 1:m
    for jj = 1:n
        % Every value in image A would be equal to the cumulative sum of
        % X's pdf up to X = x, that is x = im(i,j).        
        NormalizedIm(ii,jj) = norminv(EqualizesIm(ii,jj)/255,mu_4_2,Sigma_4_2);
    end
end

% Display two images side by side, full screen.
out = [Im zeros(256,2) EqualizesIm zeros(256,2) NormalizedIm];
figure(16);
figure('units','normalized','outerposition',[0 0 1 1]);
clf;
imagesc(out);
colormap gray;
set(gcf,'MenuBar','none');
set(gca,'DataAspectRatioMode','auto');
set(gca,'Position',[0 0 1 1]);

% Display Histograms
figure(17);
subplot(1,3,1);
histogram(Im,256);
xlabel('Pixel Intensity');
ylabel('Pixel Count');
title('Input Image Histogram');
subplot(1,3,2);
histogram(EqualizesIm,256);
xlabel('Pixel Intensity');
ylabel('Pixel Count');
title('Equalized Image Histogram');
subplot(1,3,3);
histogram(NormalizedIm,256);
xlabel('Pixel Intensity');
ylabel('Pixel Count');
title('Normalized Image Histogram');
%}