function Distance = GridDistance(PointArray,RowSize,ColumnSize,HoriVert)
%Takes array of points on a grid
%Takes row and column size
%Indicate '0' for horizontal point distance '1' for vertical point distance
%Output the distance between each set of points in a vector.

PA=PointArray;
N=RowSize;
M=ColumnSize;
sz=size(PA);

%'0' horizontal
if HoriVert==0
    D=0;
    for i=1:sz(2)-1
        if mod(i,M)~=0
            D1=norm(PA(:,i)'-PA(:,i+1)');
            D=[D,D1];
        end
    end
end

if HoriVert==1
    D=0;
    for i=1:sz(2)-M
        D1=norm(PA(:,i)'-PA(:,i+M)');
        D=[D,D1];   
    end
end
D(1)=[];
Distance=D;
end
