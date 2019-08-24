function OutPutVector=InHomoGrid(DataX,DataY,VertexX,VertexY)
%Given a set of data points and vertex to a quadrilateral, spits out a
%logic vector for the points that are in this grid:
%Points on the top and left leg or within the four sides.
u=DataX;
v=DataY;
X=VertexX;
Y=VertexY;
in=inpolygon(u,v,X,Y);
%%[in,on]=inpolygon(u,v,X,Y);
%%in=in-on;

%%T=find(on==1);
%%Tsz=size(T);

%%for t=1:Tsz(2)
    %%Logic=CheckBoarder([u(T(t)),v(T(t))],[X(1),Y(1)],[X(2),Y(2)],[X(3),Y(3)],[X(4),Y(4)]);
    %%if Logic==0
        %%on(T(t))=0;
    %%end
%%end
%%in=in+on;
OutPutVector=in;
end