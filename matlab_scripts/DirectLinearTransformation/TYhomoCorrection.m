function CorrectedArray=TYhomoCorrection(PointData,Origin,Ratio,TwoDMonster,CXarray,CYarray)
%This might be the code everyone sees.
%Takes 2 by x point data from video captures.
%Takes x and y coordinate camera calibration arrays.
%Takes 2D monster array.
%Returns the array corrected based homograph calibration.

%Initial definition
x=CXarray;
y=CYarray;
x=x*10^(-3);
y=y*10^(-3);
%Data point normalization
NPD=PointData*Ratio/1000;
NPD(1,:)=NPD(1,:)+Origin(1)-4;
NPD(2,:)=NPD(2,:)+Origin(2)-4;
NPD=NPD*1000*10^(-3);

u=NPD(1,:);
v=NPD(2,:);
usz=size(u);

%Turn data points from cartesian to homogeneous coordinate
Data=TYhom(NPD,0);

%Turn 2D monster into the real Monster Array
M2D=TwoDMonster;
sz=size(x);
N=sz(1)-1;
M=sz(2)-1;
MA=HomoReshape(M2D,1,[N,M,3,3]);

%Obtain logical array that indicate where the point lie in relation to the
%calibration gridlines.
LoAr=InHomoLogic(u,v,x,y);

%Start the correction array
CA=zeros(3,usz(2));

%Match the DLT matrix with the correct points
for i=1:usz(2)
    [n,m]=find(LoAr(:,:,i)==1);
    MAi=squeeze(MA(n,m,:,:));
    CA(:,i)=MAi*Data(:,i);
end
CA=TYhom(CA,1);
CA=CA*10^(3);
CA=CA/1000;
CA(1,:)=CA(1,:)-Origin(1)+4;
CA(2,:)=CA(2,:)-Origin(2)+4;
CorrectedArray=CA*1000/Ratio;
end
%Written by Taireyune
    


