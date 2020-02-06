%% TEMPLATES
clc;
clear;
close all;
%Alphabets
A=imread('template/A.bmp');B=imread('template/B.bmp');C=imread('template/C.bmp');
D=imread('template/D.bmp');E=imread('template/E.bmp');F=imread('template/F.bmp');
G=imread('template/G.bmp');H=imread('template/H.bmp');I=imread('template/I.bmp');
J=imread('template/J.bmp');K=imread('template/K.bmp');L=imread('template/L.bmp');
M=imread('template/M.bmp');N=imread('template/N.bmp');O=imread('template/O.bmp');
P=imread('template/P.bmp');Q=imread('template/Q.bmp');R=imread('template/R.bmp');
S=imread('template/S.bmp');T=imread('template/T.bmp');U=imread('template/U.bmp');
V=imread('template/V.bmp');W=imread('template/W.bmp');X=imread('template/X.bmp');
Y=imread('template/Y.bmp');Z=imread('template/Z.bmp');
%Natural Numbers
one=imread('template/1.bmp');two=imread('template/2.bmp');
three=imread('template/3.bmp');four=imread('template/4.bmp');
five=imread('template/5.bmp'); six=imread('template/6.bmp');
seven=imread('template/7.bmp');eight=imread('template/8.bmp');
nine=imread('template/9.bmp'); zero=imread('template/0.bmp');

%Creating Array
letter={A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, one, two, three, four, five, six, seven, eight, nine, zero};


%% CODE

file= fopen('result.txt','w');
fprintf("\nA executar");

for i=1:40
    fprintf(".");
    image= strcat('licensePlates/', int2str(i));
    imgcell=imread(strcat(image,'_plate_detail.png'));
    imgcell=im2double(imgcell);% converts o to double

    img=imresize(imgcell, [100, 600]);%resize the image
    
    imggray = rgb2gray(img); % image to gray scale
    im2 = medfilt2(imggray, [3,3]);% median filtering | remove noise from image
    
    T= graythresh(im2);% Otsu method, automatic thresholding
    imbw = imbinarize(im2,T);% binarize grayscale image by thresholding T
    imbw=imclose(imbw, strel('square',4));%dilation and erosion | remove the small black points on the object.
    im = edge(im2, 'canny',T);% find the edges
    %The edge function calculates the gradient using the derivative of a Gaussian filter
    im=imdilate(im, strel('rectangle',[2 2]));
    im=imclose(im, strel('rectangle',[2 5]));
    
    im=bwareaopen(im, 250);% remove small objects from binary image |
    %removes all connected components (objects) that have fewer than 250
    im = imfill(im,'holes');%Fill image regions and holes
    im2= im.*imbw;% gray scale image multiply by binary image
    im2=~im2;% complement image
    im2= im2.*im;% gray scale image multiply by this combinarion of operators
    %Now we have a correct fill image
    im2=bwareaopen(im2,600);
    [L,Ne]=bwlabel(im2);
    %L:  labels for the 8-connected objects found in im2
    % Ne:  number of connected objects found in im2
    out="";%reset the string
    bool=1;% reset the variable
    for n=1:Ne
        [r,c] = find(L==n);%  row and column coordinates of the object labeled "n"
        n1=im2(min(r):max(r),min(c):max(c));%crop the image
        holes = abs(bweuler(n1)-1);
        n1=imresize(n1,[42,24]);%resize to the same size of the templates
        [string, bool]=returnLetter(n1, bool,letter, holes);%return the correspondent letter
        out = strcat(out,string);%appends  string
    end
    
    fprintf(file, "%s\n", out);
end
fclose(file);
winopen('result.txt')