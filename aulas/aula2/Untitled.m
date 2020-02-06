
%% problema 2
clear x y
syms x y
eqns = [ -15 == (0.8*x) - (0.8*y), 0.8*x+ 0.8*y==195];
S = solve(eqns);
sol = [S.x; S.y]

%% Matlab 
%problema 3
Img= imread('Lena.tif');
Img_Rotate= imrotate(Img, -30,'bilinear');
imshow(Img_Rotate)