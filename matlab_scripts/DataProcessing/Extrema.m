function [MaxMinX,MaxMinY] = Extrema(X,Y,MaxMin)
%Spit out local max if MaxMin = 1 and min if MaxMin = 0
x=size(X);
y=size(Y);

if isequal(x,y)==0
    display('Unequal input vector size')
end

D=zeros(1,x(1)-1);
for i=2:x(1)
    D(i-1)=(Y(i)-Y(i-1))/(X(i)-X(i-1));
end

MV=[0,0];

%Find the local max values
if MaxMin==1
    for i=2:x(1)-3
        if sign(D(i))==1 
            if isequal(sign(D(i-1)),sign(D(i)),-sign(D(i+1)),-sign(D(i+2)))==1|isequal(sign(D(i-1)),sign(D(i)),sign(D(i+1))-1,-sign(D(i+2)))==1
                MV=[MV;[X(i+1),Y(i+1)]];
            end
        end
    end
end

%Find the local min values
if MaxMin==0
    for i=2:x(1)-3
        if sign(D(i))==-1 
            if isequal(sign(D(i-1)),sign(D(i)),-sign(D(i+1)),-sign(D(i+2)))==1|isequal(sign(D(i-1)),sign(D(i)),sign(D(i+1))+1,-sign(D(i+2)))==1
                MV=[MV;[X(i+1),Y(i+1)]];
            end
        end
    end
end
MV(1,:)=[];
MaxMinX=MV(:,1);
MaxMinY=MV(:,2);
end
