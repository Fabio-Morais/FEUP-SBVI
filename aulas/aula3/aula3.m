%% Problema 1
Img_Mona= imread('mona.tif');
min_Img_Mona = min(min(Img_Mona));
fprintf('Min: %d\n',min_Img_Mona );
% a(:) -> vetorizaçao da matriz
% max(a(:))
max_Img_Mona = max(max(Img_Mona));
fprintf('Max: %d\n', max_Img_Mona);
figure(1),imhist(Img_Mona);

%imadjust -> IMG, [MIN, MAX], [], GAMMA
% min / 255 dá valores entre 0 e 1
Img_Mona_Linear = imadjust(Img_Mona, [double(min_Img_Mona)/255;double(max_Img_Mona)/255], [], 1);
figure(2),imhist(Img_Mona_Linear);
% Se gamma = 1 LINEAR, gamma<1 comprime os brancos, gamma > 1 comprime os pretos
% expande baixas intensidades 