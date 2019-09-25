disp("problema 1 a 3")

Img_1 = imread('C:\Users\fabio\Desktop\matlab\aula1\mona.tif');
Img_2 = imread('C:\Users\fabio\Desktop\matlab\aula1\lua.bmp');
Img_dicom = dicomread('C:\Users\fabio\Desktop\matlab\aula1\Chest_XRay.dcm');%lê para variavel
Info_dicom = dicominfo('C:\Users\fabio\Desktop\matlab\aula1\Chest_XRay.dcm');%armazena informaçao
disp("bits per pixel "+Info_dicom.BitDepth);
a=size(Img_1);%tamanho da Img_1
disp("size Img_1: "+ a(1)+" - "+a(2));
b=size(Img_2);
disp("size Img_2: "+ b(1)+" - "+b(2));
c=size(Img_dicom);
disp("size Img_dicom: "+ c(1)+" - "+c(2));

%% Problema 4
imshow(Img_1);%mostra imagem
imshow(Img_2);
%permite abrir as 2 imagens ao mesmo tempo
imshow(Img_1), figure, imshow(Img_2);
%subplot(nº linhas, nº colunas, posiçao)
%ex: 2,2,3 => fica na 2º linha, 1º coluna
figure, subplot(1,2,1), imshow(Img_1);
subplot(1,2,2), imshow(Img_2);

close all; % fecha todas as imagens abertas
figure(1), subplot(2,2,1),imshow(Img_dicom); %A gama de valores é menor do que o esperado.
%A gama é de 0 a 1000, porem ele espera de 0 a ~65000, entao coloca tudo a
%preto
figure(1), subplot(2,2,2),imshow(Img_dicom, []);
figure(1), subplot(2,2,3),imshow(Img_dicom, [0 255]);
figure(1), subplot(2,2,4),imshow(Img_dicom, [255 1023]);

%% Problema 5
disp("problema 5")

close all;
imtool(Img_1)%abre me modo tool

%% Problema 6
disp("problema 6")
%grava num ficheiro
imwrite(Img_2, 'C:\Users\fabio\Desktop\matlab\aula1\lua.tif')%guarda ficheiro
imwrite(Img_1, 'C:\Users\fabio\Desktop\matlab\aula1\mona.jpeg', 'Quality',10)
% 'Quality',50 -> altera a qualidade


imfinfo('C:\Users\fabio\Desktop\matlab\aula1\mona.jpeg')

imwrite(Img_dicom, 'C:\Users\fabio\Desktop\matlab\aula1\micro_radiografia.tif');
