function output=StatRunPt(IA1,P1,P2,P3,P4)
%Takes data array (raw data) and parameter vectors (each representing a group), 
%spits out matrix with names, means, and SD
%Use raw point data
P=[P1 P2 P3 P4];

%May need to redefine number of columns and rows, 4 parameters (n) and 7 
%rows per parameter (r).
%Most number of columns is 20
n=4;
r=8;
m=18;
ArrayX=string(repmat(0,n*r,m));
for i=1:4
    Array1=ExtData(IA1,P(:,i));
    Array2=StatPoint(Array1);
    s=size(Array2);
    Zero=string(repmat(0,r,m-s(2)));
    Array2=[Array2,Zero];
    ArrayX(r*i-r+1:r*i,:)=Array2; %each iteration depend on size of array 2
end
output=ArrayX;
end
%output in multiple columns seperated by group