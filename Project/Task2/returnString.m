function string = returnString(index, holes)
if index==1 && holes==1
    letter='A';
elseif index==2 && holes==2
    letter='B';
elseif index==3 && holes==0
    letter='C';
elseif index==4 && holes==1
    letter='D';
elseif index==5 && holes==0
    letter='E';
elseif index==6 && holes==0
    letter='F';
elseif index==7 && holes==0
    letter='G';
elseif index==8 && holes==0
    letter='H';
elseif index==9 && holes==0
    letter='I';
elseif index==10 && holes==0
    letter='J';
elseif index==11 && holes==0
    letter='K';
elseif index==12 && holes==0
    letter='L';
elseif index==13 && holes==0
    letter='M';
elseif index==14 && holes==0
    letter='N';
elseif index==15 && (holes==1 )
    letter='O';
elseif index==16 && holes==1
    letter='P';
elseif index==17 && holes==1
    letter='Q';
elseif index==18 && holes==1
    letter='R';
elseif index==19 && holes==0
    letter='S';
elseif index==20 && holes==0
    letter='T';
elseif index==21 && holes==0
    letter='U';
elseif index==22 && holes==0
    letter='V';
elseif index==23 && holes==0
    letter='W';
elseif index==24 && holes==0
    letter='X';
elseif index==25 && holes==0
    letter='Y';
elseif index==26 && holes==0
    letter='Z';
elseif index==27 && holes==0
    letter='1';
elseif index==28 && holes==0
    letter='2';
elseif index==29 && holes==0
    letter='3';
elseif index==30 && holes==1
    letter='4';
elseif index==31 && holes==0
    letter='5';
elseif index==32 && holes==1
    letter='6';
elseif index==33 && holes==0
    letter='7';
elseif index==34 && holes==2
    letter='8';
elseif index==35 && holes==1
    letter='9';
elseif index==36 && holes ==1 
    letter='0';
else
    letter='';
end 
string= letter;