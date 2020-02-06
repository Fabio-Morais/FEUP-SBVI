function [string,bool] = returnLetter(img, indiceImg, letter, holes)
    %initialize variables 
    template= letter{1};
    max= corr2(template,img);
    %max representing the similarity between 2 images in relation with their respective pixel intensity.
    indice=1;
    x1=2;
    x2=36;
    
    %Logic of the license plate XX 111 XX or XX 1111 X
    if indiceImg == 1 || indiceImg==2
        x1=2;
        x2=26;
    elseif indiceImg>2 && indiceImg<6
        x1=26;
        x2=36;
    elseif(indiceImg==7 || indice== 8)
        x1=2;
        x2=26;
    end

    for i=x1:x2
        templat=letter{i};
        aux=corr2(templat,img);
        if(aux>max)
            max=aux;
            indice=i;
        end
    end
    
    auxiliar="";
    boolAux=indiceImg;
    if(max>0.310)
        auxiliar = returnString(indice, holes);
        boolAux=indiceImg+1;
    end
    string=auxiliar;
    bool=boolAux;
end