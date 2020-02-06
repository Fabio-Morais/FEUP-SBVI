%% ex:4
casa= imread('casa.tif');
figure(1), imshow(casa);

casa1= edge(casa, 'sobel',0.08);
figure(2), imshow(casa1);

%horizontal
casa2= edge(casa, 'prewitt',0.08);
figure(3), imshow(casa2);

%diagonal
casa3= edge(casa, 'roberts',0.08);
figure(4), imshow(casa3);

casa4= edge(casa, 'canny',0.2);
figure(5), imshow(casa4);

%% ex 5
poli= imread('poligono.tif');
poliEdge= edge(poli, 'canny',0.5);
imshow(poliEdge)
[H,T,R] = hough(poliEdge)
 P  = houghpeaks(H,2);
       imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
       xlabel('\theta'), ylabel('\rho');
       axis on, axis normal, hold on;
       plot(T(P(:,2)),R(P(:,1)),'s','color','white');
       % Find lines and plot them
       lines = houghlines(BW,T,R,P,'FillGap',5,'MinLength',7);
       figure, imshow(rotI), hold on