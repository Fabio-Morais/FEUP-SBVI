%% TEMPLATES
    
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
x=2;
for i=x:x
    fprintf(".");
    image= strcat('licensePlates/', int2str(i));
    imgcell=imread(strcat(image,'_plate_detail.png'));
    imshow(imgcell);
    imgcell=imsharpen(imgcell);
    %figure,imshow(imgcell);
    imgcell=imadjust(imgcell,[.2 .3 0; .6 .7 1],[]);
    %figure,imshow(imgcell);
    img=imresize(imgcell, [100, 600]);%resize the image
    imggray = rgb2gray(img); % image to gray scale
    
    %imshow(imggray);
    im2 = medfilt2(imggray, [3,3]);% median filtering | remove noise from image
    T= graythresh(im2);% Otsu method, automatic thresholding 
    imbw = imbinarize(im2,T);% binarize grayscale image by thresholding T
    
    %Codigo Beto
    %imbw=imcomplement(imbw);
    data=corner(imbw);
    im=im2;
    im=im2double(im);
    r_data=data(:,1);
    c_data=data(:,2);
    min_colm=min(c_data);
    
    idx1=find(c_data==min_colm);
    ver1=[min_colm,r_data(idx1(1))];
    max_colm=max(c_data);
    idx2=find(c_data==max_colm);
    ver2=[r_data(idx2(1)),max_colm];
    min_row=min(r_data);
    idx3=find(r_data==min_row);
    ver3=[min_row,c_data(idx3(1))];
    max_row=max(r_data);
    idx4=find(r_data==max_row);
    ver4=[max_row,c_data(idx4(1))];
    %fixedPoints=[1 size(im,1);size(im,2) size(im,1);size(im,2) 1;1 1]
    %movingPoints=[ver1;ver2;ver4;ver3]
    
%     BW2 = bwmorph(imbw,'skel');
%     figure
%     imshow(BW2)
   
    gray=rgb2gray(img);
    gray1 = adapthisteq(gray,'clipLimit',0.1,'NumTiles',[480/20 640/20]);
    y_bin=imbinarize(gray1,'global');
    y_bin=imopen(y_bin,strel('line',5,90));
    y_bin=imopen(y_bin,strel('disk',1));
    y_c1=imclose(y_bin,strel('line',21,0));
    y_c2=imclose(y_c1,strel('line',5,90));
    y_c_o=imopen(y_c2,strel('line',33,0));
    test=imopen(y_c_o,strel('line',19,90));
    
    imbw2=imclose(imbw,strel('disk',5));

%     subplot(2,2,1), imshow(imgcell)
%     subplot(2,2,2), imshow(imggray)
%     subplot(2,2,3), imshow(imbw)
%     subplot(2,2,4), imshow(test)

    immostrar=imbw;
    img2=imcomplement(imbw);
    %img2=imbw;
    %img2=imclose(img2,strel('line',17,90));
    bw = ~bwareaopen(~imbw, 50);
    cmask = imclose(bw, strel('diamond', 200));
    imshow(bw);
    cornermask = cmask & ~bw;
    %cornermask = bwareaopen(cornermask, 2);
    %cornermask=imclose(cornermask,strel('line',200,90));
    cornermask=imerode(cornermask,strel('square',5));
    img2=imclose(img2, strel('diamond', 20));
    img2=imerode(img2,strel('line',4,90));
    %img2=imcomplement(imgcornermas2);
    figure,imshow(img2);
    
    
    data=corner(cornermask);
    r_data=data(:,1);
    c_data=data(:,2);
    min_colm=min(c_data);
    
    idx1=find(c_data==min_colm);
    ver1=[min_colm,r_data(idx1(1))];
    max_colm=max(c_data);
    idx2=find(c_data==max_colm);
    ver2=[r_data(idx2(1)),max_colm];
    min_row=min(r_data);
    idx3=find(r_data==min_row);
    ver3=[min_row,c_data(idx3(1))];
    max_row=max(r_data);
    idx4=find(r_data==max_row);
    ver4=[max_row,c_data(idx4(1))];
    
    [r,c]=size(cornermask);
    fixedPoints=[1,1;1,r;c,1;c,r];
    movingPoints=[ver1(1) ver1(2)-20;ver3(1) ver3(2)+10;ver4;ver2];
    %imshow(imgcell);
    tform = fitgeotrans(movingPoints,fixedPoints,'projective');
    img_registered = imwarp(imggray,tform,'OutputView',imref2d(size(imggray)));
    img_registered=imopen(img_registered,strel('line',17,90));
    img_registered=imsharpen(img_registered);
    %figure, imshow(img_registered);
    
%     imshow(cornermask);
%     imshow(cornermask);
%     hold on;
%     data=corner(immostrar);
%     x=data(:,1);
%     y=data(:,2);
%     plot(x,y,'o');
%     set(gca, 'XTick', 1:length(y), 'XTickLabel', x)
%     hold off;
    
    [r,c]=size(imggray);
    fixedPoints=[1,1;1,r;c,1;c,r];
    movingPoints=[1,8;1,74;600,18;600,92];

    tform = fitgeotrans(movingPoints,fixedPoints,'projective');
    img_registered = imwarp(imggray,tform,'OutputView',imref2d(size(imggray)));
    %figure, imshow(img_registered);
    
    
    %%%%%%%%%%%%%%%%%%%%
    im = edge(im2, 'canny',0.45);% find the edges 
    %The edge function calculates the gradient using the derivative of a Gaussian filter
    im=imdilate(im, strel('line',9,0));   
    im=imdilate(im, strel('square',2));    
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
        n1=imresize(n1,[42,24]);%resize to the same size of the templates
        [string, bool]=returnLetter(n1, bool,letter);%return the correspondent letter 
        out = strcat(out,string);%appends  string
    end
    fprintf(file, "%s\n", out);
end
fclose(file);
%winopen('result.txt')