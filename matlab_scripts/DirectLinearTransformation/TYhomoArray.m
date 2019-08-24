function [MonsterArray,CXarray,CYarray]=TYhomoArray(RealPoints,ImagePoints,RowSize,ColumnSize)
%Takes the x and y components of the real (calibration) points and camera 
%image points as 2 by x arrays.
%Takes the length of rows and columns.
%Spits outs a n by m by 3 by 3 monster array that contains all the 3 by 3 DLT 
%matrix for image distortion corrections.

%Initial definition
x=RealPoints(1,:);
y=RealPoints(2,:);
u=ImagePoints(1,:);
v=ImagePoints(2,:);

%All calculations are done with smaller values (10^(-3)) to minimize matlab value
%storage error.
x=x*10^(-3);
y=y*10^(-3);
u=u*10^(-3);
v=v*10^(-3);

N=RowSize;
M=ColumnSize;

szx=size(x);
szy=size(y);
szu=size(u);
szv=size(v);

%Check for sizes
if isequal(szx,szy,szu,szv)==0
    display('vector size mismatch')
    return
end

%Turn each vector into an N by M array
x=reshape(x,M,N)';
y=reshape(y,M,N)';
u=reshape(u,M,N)';
v=reshape(v,M,N)';

CXarray=u*10^3;
CYarray=v*10^3;

%Build the Monster Array using HomoSolve by TY
MA=zeros(N-1,M-1,3,3);
for n=1:N-1
for m=1:M-1
    X=[x(n,m),x(n+1,m),x(n+1,m+1),x(n,m+1)];
    Y=[y(n,m),y(n+1,m),y(n+1,m+1),y(n,m+1)];
    U=[u(n,m),u(n+1,m),u(n+1,m+1),u(n,m+1)];
    V=[v(n,m),v(n+1,m),v(n+1,m+1),v(n,m+1)];
    MA(n,m,:,:)=HomoSolve(X,Y,U,V);
end
end
MonsterArray=MA;
end
%Written by Taireyune