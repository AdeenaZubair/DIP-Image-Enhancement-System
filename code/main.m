clc;
clear;
close all;

%% -------------------------------
% 1. Image Acquisition (Lab 01)
% -------------------------------
img = imread('/MATLAB Drive/mountain1.jpg');

% Convert to grayscale
gray = rgb2gray(img);

figure, imshow(gray), title('Original Grayscale');

% Display info
disp('Resolution:');
disp(size(gray));

disp('Data Type:');
disp(class(gray));

disp('Matrix Sample:');
disp(gray(1:5,1:5));

%% -------------------------------
% 2. Sampling & Quantization (Lab 02)
% -------------------------------

% Scaling
scale1 = imresize(gray, 0.5);
scale2 = imresize(gray, 0.25);
scale3 = imresize(gray, 1.5);
scale4 = imresize(gray, 2);

figure;
subplot(2,2,1), imshow(scale1), title('0.5 Scale');
subplot(2,2,2), imshow(scale2), title('0.25 Scale');
subplot(2,2,3), imshow(scale3), title('1.5 Scale');
subplot(2,2,4), imshow(scale4), title('2 Scale');

% Quantization
q8 = gray;
q4 = floor(double(gray)/16)*16;
q2 = floor(double(gray)/64)*64;

figure;
subplot(1,3,1), imshow(uint8(q8)), title('8-bit');
subplot(1,3,2), imshow(uint8(q4)), title('4-bit');
subplot(1,3,3), imshow(uint8(q2)), title('2-bit');

%% -------------------------------
% 3. Transformations (Lab 03)
% -------------------------------

% Rotation
r30 = imrotate(gray,30);
r60 = imrotate(gray,60);
r90 = imrotate(gray,90);

figure;
subplot(1,3,1), imshow(r30), title('30°');
subplot(1,3,2), imshow(r60), title('60°');
subplot(1,3,3), imshow(r90), title('90°');

% Translation
t = affine2d([1 0 0; 0 1 0; 50 30 1]);
translated = imwarp(gray, t);

figure, imshow(translated), title('Translated');

% Shearing
s = affine2d([1 0.5 0; 0.5 1 0; 0 0 1]);
sheared = imwarp(gray, s);

figure, imshow(sheared), title('Sheared');

%% -------------------------------
% 4. Intensity Transformations (Lab 04)
% -------------------------------

% Negative
negative = 255 - gray;

% Log transformation
log_img = uint8(255 * log(1 + double(gray)) / log(256));

% Gamma
gamma1 = imadjust(gray, [], [], 0.5);
gamma2 = imadjust(gray, [], [], 1.5);

figure;
subplot(2,2,1), imshow(negative), title('Negative');
subplot(2,2,2), imshow(log_img), title('Log');
subplot(2,2,3), imshow(gamma1), title('Gamma 0.5');
subplot(2,2,4), imshow(gamma2), title('Gamma 1.5');

%% -------------------------------
% 5. Histogram Processing (Lab 05)
% -------------------------------

figure;
imhist(gray);
title('Original Histogram');

% Histogram Equalization
eq = histeq(gray);

figure, imshow(eq), title('Equalized Image');

figure;
imhist(eq);
title('Equalized Histogram');

%% -------------------------------
% 6. Final Pipeline
% -------------------------------

function out = process_image(img)
    gray = rgb2gray(img);
    eq = histeq(gray);
    out = imadjust(eq, [], [], 0.5); % gamma correction
end

final = process_image(img);

figure, imshow(final), title('Final Enhanced Image');
