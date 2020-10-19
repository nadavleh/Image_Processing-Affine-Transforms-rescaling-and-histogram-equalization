%% Section 1

% Load the picture.
load wbarb;

%% 1.1. Save Barbara's picture as a jpg and bmp files.

% jpg file: 
% In addition to the instructions, it is necessary to normalize the values
% in 255. We could also use the function ind2rgb(X,map).
ImRGB(:,:,1) = X/255;
ImRGB(:,:,2) = X/255;
ImRGB(:,:,3) = X/255;
imwrite(ImRGB,'BarbaraJPG.jpg');

% bmp file:
ImBMP = uint8(X);
imwrite(ImBMP,'BarbaraBMP.bmp');


%% 1.2. Save Barbara's picture as a jpg file, at different quality.

% Saves the image in different qualities as .jpg file format.
imwrite(ImRGB,'BarbaraJPG_q1.jpg','jpg','Quality',1);
imwrite(ImRGB,'BarbaraJPG_q5.jpg','jpg','Quality',5);
imwrite(ImRGB,'BarbaraJPG_q15.jpg','jpg','Quality',15);
imwrite(ImRGB,'BarbaraJPG_q25.jpg','jpg','Quality',25);
imwrite(ImRGB,'BarbaraJPG_q100.jpg','jpg','Quality',100);

% Reads the saved images into matrices in Matlab.
q1 = imread('BarbaraJPG_q1.jpg');
q5 = imread('BarbaraJPG_q5.jpg');
q15 = imread('BarbaraJPG_q15.jpg');
q25 = imread('BarbaraJPG_q25.jpg');
q100 = imread('BarbaraJPG_q100.jpg');

% Shows the Pictures.
figure (1);
image(q1);
title('Quality = 1');
figure (2);
image(q5);
title('Quality = 5');
figure (3);
image(q15);
title('Quality = 15');
figure (4);
image(q25);
title('Quality = 25');
figure (5);
image(q100);
title('Quality = 100');

% Saves the matrices values into .mat file format.
save('JPG_Pictures','q1', 'q5', 'q15', 'q25', 'q100');
