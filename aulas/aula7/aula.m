%% ex 4
cito_suavizada=imread('cito-suavizada.tif');
cito_suavizada_bin= imbinarize(cito_suavizada);
figure(1), imshow(cito_suavizada);
figure(2), imshow(cito_suavizada_bin);

cito_suavizada_bin_64= imbinarize(cito_suavizada, 80/254);
figure(3), imshow(cito_suavizada_bin_64);
cito_suavizada_bin_128= imbinarize(cito_suavizada, 128/254);
figure(3), imshow(cito_suavizada_bin_128);

cito_suavizada_bin_somado= 0.5*cito_suavizada_bin_64+ 0.5*cito_suavizada_bin_128;
figure(4), imshow(cito_suavizada_bin_somado);

