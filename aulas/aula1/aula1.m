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

%% Problema 7
Img_2_double=double(Img_2); %converte para double, Img_2 é uint8
Img_dicom_uint8 = uint8(Img_dicom); % converte para uint8, Img_dicom é uint16

Img_4_double=Img_2_double.*4; %multiplica a intensidade de cor por 4
Img_4=uint8(Img_4_double);
 
% Valores elevados de intensidade = branco; valores mais baixs = preto
figure(1),subplot(1,2,1),imshow(Img_2);
figure(1),subplot(1,2,2),imshow(Img_4);

figure(2),subplot(2,2,1),imshow(Img_2_double); % porque fica diferente do Img_2???
figure(2),subplot(2,2,2),imshow(Img_4_double);
figure(2),subplot(2,2,3),imshow(Img_dicom, []);
figure(2),subplot(2,2,4),imshow(Img_dicom_uint8); % porque fica mais claro?

%% Problema 8

% Quando se faz o cast "x=double(Img_2)" todos os valores que estão fora da gama de representação da nova classe serão
%truncados para o valor da gama admitida mais próximo.

a=[ -0.5 0.5; 0.75 1.5]; % double
b=uint8(a) %0.5-> 1; 1.5->2, arredonda
c=im2uint8(a)%1-> 255; 0-> 0; 0.5 -> 128; maior que 1 = 255, menor que 0= 0


d=uint8([ 25 50; 128 200]);
e=double(d) % fica igual ao de cima
f=im2double(d) % converte os valores para [0,1]; 0->0; 255-> 1; 128-> 0.5
g=mat2gray(d) % pega no maximo valor (200) e considera que é 1, no min(25) que é 0
g0=mat2gray(d, [0 255]) % define o 255 como max, parecido com o de cima


d = [ 25 50; 128 200];
e1=double(d) % fica igual
f1=im2double(d) %converte os valores para [0,1]; 0->0; 255-> 1; 128-> 0.5
g1=mat2gray(d) 


h=uint8( [ 25 50; 128 200]);
i=im2bw(h) % valores acima de 255/2 é 1, abaxio disso é 0
j=im2bw(h, 0.7) %valores abaixo de 0.7 é 0(preto), acima de 0.7 é 1(branco)


close all;
figure(1); imshow(Img_1);

Img_1_d= double(Img_1);% fica um tamanho grande demais
figure(2); imshow(Img_1_d);

Img_1_i2d= im2double(Img_1); %forma correta de converter para double
figure(3); imshow(Img_1_i2d);

Img_1_gray=mat2gray(Img_1)
figure(4); imshow(Img_1_gray);

Img_1_bw= im2bw(Img_1) % em binario
figure(5); imshow(Img_1_bw);


%% Problema 9
close all;

figure, imshow(Img_1);

%I2 = I(:,end:-1:1,:);           %# horizontal flip
%I3 = I(end:-1:1,:,:);           %# vertical flip
%I4 = I(end:-1:1,end:-1:1,:);    %# horizontal+vertical flip
Img_1_flipped = Img_1(end:-1:1, :);
figure, imshow(Img_1_flipped);

%image(RowStart:RowEnd,ColStart:ColEnd,:);
Img_1_cropped = Img_1(257:468, 257:468);
figure, imshow(Img_1_cropped);

%1:vertical:end, 1:horizontal:end
Img_1_subsampled = Img_1(1:1:end, 1:1:end); %rezise 
figure, imshow(Img_1_subsampled);

figure, plot(Img_1(256, :)); % mostra em grafico os valores da intensidade

%% Problema 10


%%%binary-> apenas 0 e 1, preto e branco.
%-------------------------------------------------------------------%

%%%indexed-> RED | GREEN | BLUE -> sao as 3 colunas que há
% single or double = [1,p]  p= length of the colormap; 1 para linha 1, 2
% para linha 2...etc
% uint8, logical, uint16 = [0, p-1], 0 para linha 1, 1 para linha 2...etc
%-------------------------------------------------------------------%
%%%grayscale-> os pixeis tem o valor da intensidade.
%single or double = [0,1]
%uint8=[0,255]
%uint16=[0, 65535]

%-------------------------------------------------------------------%

%%%truecolor


%% Problema 11


img_rgb=imread('pimentos.tif');
img_gray=rgb2gray(img_rgb); %% converte para grayscale
imshow(img_rgb); 
figure, imshow(img_gray);

close all;

red=img_rgb(:, :, 1); figure, imshow(red), title('RED');
green=img_rgb(:, :, 2); figure, imshow(green), title('GREEN');
blue=img_rgb(:, :, 3); figure, imshow(blue), title('BLUE');


red_modificada=imadjust(red, [0 0.5], [0 1]); figure, imshow(red_modificada);
img_rgb_modificada=cat(3,red_modificada, green,blue);
figure, imshow(img_rgb_modificada);

