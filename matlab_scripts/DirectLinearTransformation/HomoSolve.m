function OutputVector=HomoSolve(RealVertexX,RealVertexY,ImageVertexX,ImageVertexY)
%Takes four calibration vertex and four camera vertex,
%Spits out the homograph transformation matrix from camera vertex to
%calibration vertex
x=RealVertexX;
y=RealVertexY;
xd=ImageVertexX;
yd=ImageVertexY;

n=size(x);
if isequal(size(x),size(y),size(xd),size(yd))==0
    display('HomoSolve: too many input vertices')
    return
end

A=zeros(2*n(2),9);
for i=1:n(2)
    A(2*i-1,:)=[x(i),y(i),1,0,0,0,-x(i)*xd(i),-xd(i)*y(i),-xd(i)];
    A(2*i,:)=[0,0,0,x(i),y(i),1,-x(i)*yd(i),-yd(i)*y(i),-yd(i)];
end
if n(2)==4
H=null(A);
%H=H*10^(5);
else
    %%[U,S,V]=svd(A);
    %%H=V(:,0);
end
check=size(H);
if check(2)~=1
    H=H(:,1);
    display('multiple solution')
    %MS=[x;y;xd;yd]
end
H=reshape(H,3,3)';
OutputVector=H^(-1);
end