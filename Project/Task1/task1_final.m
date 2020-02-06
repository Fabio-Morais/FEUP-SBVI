clc
clear
close all
inc=1;

error_plate=zeros(1,10);

vetor_jaccard=zeros(40,1);
% Por a variável a 1 se quiser ver as diferenças
% Por a variável a 0 se não quiser ver as imagens
%   Verde -> deu mas não pertence ao GT
%   Rosa  -> Não deu mas pretence ao GT  
show_diff=0;

while inc<=40

    filename=sprintf('%d_plate.png',inc);
    
    im=imread(filename);
    rgbImage=im2double(im);

%%     Pré-processamento

    hsvImage = rgb2hsv(rgbImage);
    hImage = hsvImage(:, :, 1);
    sImage = hsvImage(:, :, 2);
    vImage = hsvImage(:, :, 3)*1.1;

%     t=> variável que indica os pontos a serem considerados
    thresh=0.35;
    t=vImage()>thresh & sImage<(1-thresh);

    gray=rgb2gray(rgbImage);

    gray1 = adapthisteq(gray,'clipLimit',0.05,'NumTiles',[27 35]);
    gray2=imsharpen(gray1,'Radius',0.5,'Amount',0.7);
    
    y=gray2.*t;
    
%%     Processamento da imagem

    y_bin=imbinarize(y,'global');
%     Remover algumas regiões pontuais(salt) e desagregar algumas regiões com fracas ligações 
    y_bin=imopen(y_bin,strel('line',5,90));
    y_bin=imopen(y_bin,strel('disk',1));
    [l_bin,n]=bwlabel(y_bin,4);
    props=regionprops(l_bin,'all');


%     Remover todas as regiões na zona superior da imagem, muito grandes,
%     muito pequenas ou com um formato pouco retangular
   [size_x,size_y]=size(y_bin);
    y_bin_pre=y_bin;
    for j=1:n
        if props(j).Area>11000 || props(j).Area<30 ...
           || props(j).BoundingBox(3)>270 || props(j).BoundingBox(4)>90 ...
           || (props(j).BoundingBox(3)<50 && props(j).BoundingBox(4)<20) ...
           || (props(j).Area/(props(j).BoundingBox(3)*props(j).BoundingBox(4))<0.35 && props(j).Area> 500) ...
           || (props(j).Centroid(2)<size_y*(0.3))
        
       y_bin(l_bin==j)=0;
        end
    end

%     "Fecha" a matrícula a preenche
    y_c1=imclose(y_bin,strel('line',21,0));
    y_c2=imclose(y_c1,strel('line',5,90));

    y_c_o=imopen(y_c2,strel('line',51,0));
    test=imopen(y_c_o,strel('line',19,90));
%%      Reconhecimento da matrícula 
    

    [labels,n]=bwlabel(test,4);
    s=regionprops(labels,'all');

    is_plate=zeros([n 1]);
    sens_med=0.28;
    sens_conc=0.3;
    j=0;
%     Procura por possíveis matrículas
    for i=1:n
        BB = s(i).BoundingBox;
        area=BB(3)*BB(4);
        fillarea=s(i).Area;
        conc=fillarea/area;
        if conc>(1-sens_conc)
                    
            if abs((BB(3)-215)/215)<sens_med && abs((BB(4)-45)/45)<=(sens_med*2.2)
                    is_plate(i,1)=1;
                    j=j+1;
                    val(j).area=area;
                    val(j).fillarea=fillarea;
                    val(j).conc=conc;
                    val(j).center=s(i).Centroid;
                    val(j).box=s(i).BoundingBox;
                    val(j).Orientation=s(i).Orientation;
                    val(j).Euler=s(i).EulerNumber;
                    val(j).Solidity=s(i).Solidity;
                    val(j).Extrema=s(i).Extrema;
                    val(j).val_x=((s(i).Extrema(3,1)-s(i).Extrema(8,1))+(s(i).Extrema(4,1)-s(i).Extrema(7,1)))/2;
                    val(j).val_y=((s(i).Extrema(6,2)-s(i).Extrema(1,2))+(s(i).Extrema(5,2)-s(i).Extrema(2,2)))/2;
               
            end
        end
    end
%     Caso haja mais que uma possibilidade
    if j>1
        points=zeros(j,1);
        z=1;
        
        while z<=j
            points(z,1)=(1-abs(val(z).area-8700)/8700)*0.25 + val(z).conc*0.45 +...
                        (2-(abs(val(j).val_x-215)/215)-abs((val(j).val_y-43)/43))*0.45 -...
                        abs(val(z).Orientation)*0.05 ...
                        +val(z).Solidity*0.1;
            z=z+1;
        end
        
        [maxi,pos]=max(points);
        i=1;
        for j=1:n
            if is_plate(j) ==1
                if pos~=i
                    is_plate(j)=0;
                end
                i=i+1;
            end
        end
    end



    filename=sprintf('%d_plate_mask.png',inc);
    plate_mask=imread(filename);
%       Remove todas as regiões que não são a matrícula
    for j=1:n
        if ~is_plate(j,1)
            test(labels==j)=0;
        end
    end
    vetor_jaccard(inc,1)=jaccard(test,plate_mask);
        
    inc=inc+1;
    

    if show_diff
        figure();
        imshowpair(test,plate_mask)
    end
end

%% Confirmação do Jaccard
% Considera erro todas as matriculas com um índice de Jaccard inferior a
% 0.5;
i=0;
for j=1:40
    if vetor_jaccard(j)<0.5
       i=i+1;
       error_plate(i)=j;
    else
        vetor_jaccard(j-i)=vetor_jaccard(j);
    end
end
max_jaccard=max(vetor_jaccard(1:40-i));
min_jaccard=min(vetor_jaccard(1:40-i));
mean_jaccard=mean(vetor_jaccard(1:40-i));
if i>0
    text1=sprintf('O algoritmo não conseguiu encontrar %d matrículas!\n',i);
else
    text1=sprintf('O algoritmo conseguiu encontrar todas as matrículas!\n');
end
disp(text1);
text=sprintf('Resultado do Algoritmo:\nMax:%.2f\nMin:%.2f\nMean:%.2f\n',max_jaccard,min_jaccard,mean_jaccard);
disp(text);




