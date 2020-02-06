close all; clear all; clc;
i=2;
image= strcat('licensePlates/', int2str(i));
imgcell=im2double(imread(strcat(image,'_plate_detail.png')));
img=imresize(imgcell, [100, 600]);%resize the image
imggray = rgb2gray(img); % image to gray scale

imshow(imggray);
[r,c]=size(imggray);
fixedPoints=[1,1;1,r;c,1;c,r];
movingPoints=[1,8;1,74;600,18;600,92]; % problem-> has to be automatic

tform = fitgeotrans(movingPoints,fixedPoints,'projective');
img_registered = imwarp(imggray,tform,'OutputView',imref2d(size(imggray)));
figure,imshow(img_registered);