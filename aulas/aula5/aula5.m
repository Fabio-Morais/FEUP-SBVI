%% ex: 4
Img_Ruido = imread('imp_digital_ruido.tif');
Img_Ruido_Imerode = imerode(Img_Ruido, strel('square',3));
figure(1), imshow(Img_Ruido);
figure(2), imshow(Img_Ruido_Imerode);

Img_Ruido_Imdilate = imdilate(Img_Ruido_Imerode, strel('square',3));
figure(3), imshow(Img_Ruido_Imdilate);

x = imclose(Img_Ruido_Imdilate, strel('square',3));
figure(4), imshow(x);

%% ex: 5
close all;
Texto_Ruido = imread('text_broken.tif');
im_imgclose=imclose(Texto_Ruido, strel('square',3));
im_imgclose2=imdilate(Texto_Ruido, strel('square',3));
figure(5), imshow(Texto_Ruido);
figure(6), imshow(im_imgclose);
figure(7), imshow(im_imgclose2);

%% ex:6
bubbleImg = imread('bubbles.tif');
bubbleImgFinal = imdilate(bubbleImg, strel('disk',1));
bubbleImgFinal = bubbleImgFinal - bubbleImg;
figure(8), imshow(bubbleImgFinal);

bubbleImgFinal = imdilate(bubbleImg, strel('square',3));
bubbleImgFinal2 = imerode(bubbleImg, strel('square',3));
bubbleImgFinal3 = bubbleImgFinal - bubbleImgFinal2;
figure(9), imshow(bubbleImgFinal3);

%% ex: 9
basesMadeira = imread('bases_madeira.tif');
figure(10), imshow(basesMadeira);
basesMadeira2=imopen(basesMadeira, strel('disk',20));
figure(11), imshow(basesMadeira2);



basesMadeira3=basesMadeira-basesMadeira2;

figure(12), imshow(basesMadeira3);

basesMadeira4=imopen(basesMadeira3, strel('disk',17));
figure(13), imshow(basesMadeira4);


%% EX:10

angioImg= imread('angio.tif');
figure(14), imshow(angioImg);

angioImg2=imopen(angioImg, strel('disk',10));
figure(15), imshow(angioImg2);

angioImg3=angioImg-angioImg2;
figure(16), imshow(angioImg3);


angioImg4=imbothat(angioImg, strel('disk',10));
figure(17), imshow(angioImg4);

%% EX:11

angioImgbottomHat= imbothat(angioImg, strel('disk',10));
figure(18), imshow(angioImgbottomHat);

angioImgSum= angioImg4 + angioImg;
figure(19), imshow(angioImgSum);



