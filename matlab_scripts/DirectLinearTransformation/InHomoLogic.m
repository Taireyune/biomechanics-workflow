function PLogicArray=InHomoLogic(DataX,DataY,CXarray,CYarray)
%Takes observed data points in vectors DataX and DataY
%Takes Camera X and Y vertex both in matrix array corresponding to the
%calibration layout.
%Spits out an n by m by l array of 1's and 0's, 1's at a certain position correspond to the point's
%position in the n by m indice grid and the third component correspond to
%where the point lie in the grid.

x=CXarray;
y=CYarray;

sz=size(x);
check1=size(y);
if isequal(sz,check1)==0
    display('CXarray and CYarray matrix do not match')
    return
end

u=DataX;
v=DataY;
usz=size(u);
check4=size(v);
if isequal(usz,check4)==0
    display('Point dimensions do not match')
end

PLogicArrayP=zeros(sz(1)-1,sz(2)-1,usz(2));

for n=1:sz(1)-1
    for m=1:sz(2)-1
        %Increase the bounds of the edge of the grid by E to avoid missing any
        %points. 
        E=1;
        
        %Top edge
        if n==1 & m~=(1|sz(2)-1)
            Xp=[x(n,m),x(n+1,m),x(n+1,m+1),x(n,m+1)];
            Yp=[y(n,m)+E,y(n+1,m),y(n+1,m+1),y(n,m+1)+E];
        %Bottom edge
        elseif n==sz(1)-1 & m~=(1|sz(2)-1)
            Xp=[x(n,m),x(n+1,m),x(n+1,m+1),x(n,m+1)];
            Yp=[y(n,m),y(n+1,m)-E,y(n+1,m+1)-E,y(n,m+1)];
        %Left edge
        elseif m==1 & n~=(1|sz(1)-1)
            Xp=[x(n,m)-E,x(n+1,m)-E,x(n+1,m+1),x(n,m+1)];
            Yp=[y(n,m),y(n+1,m),y(n+1,m+1),y(n,m+1)]; 
        %Right edge
        elseif  m==sz(2)-1 & n~=(1|sz(1)-1)
            Xp=[x(n,m),x(n+1,m),x(n+1,m+1)+E,x(n,m+1)+E];
            Yp=[y(n,m),y(n+1,m),y(n+1,m+1),y(n,m+1)]; 
           
        %Top left point
        elseif n==1 & m==1
            Xp=[x(n,m)-E,x(n+1,m)-E,x(n+1,m+1),x(n,m+1)];
            Yp=[y(n,m)+E,y(n+1,m),y(n+1,m+1),y(n,m+1)+E];
        %Top Right point
        elseif n==1 & m==sz(2)-1
            Xp=[x(n,m),x(n+1,m),x(n+1,m+1)+E,x(n,m+1)+E];
            Yp=[y(n,m)+E,y(n+1,m)-E,y(n+1,m+1)-E,y(n,m+1)+E];
        %Bottom left point
        elseif n==sz(1)-1 & m==1
            Xp=[x(n,m)-E,x(n+1,m)-E,x(n+1,m+1),x(n,m+1)];
            Yp=[y(n,m),y(n+1,m)-E,y(n+1,m+1)-E,y(n,m+1)]; 
        %Right edge
        elseif  n==sz(1)-1 & m==sz(2)-1
            Xp=[x(n,m),x(n+1,m),x(n+1,m+1)+E,x(n,m+1)+E];
            Yp=[y(n,m),y(n+1,m)-E,y(n+1,m+1)-E,y(n,m+1)];
            
        %The rest of the quadrilateral in the grid
        else  
            Xp=[x(n,m),x(n+1,m),x(n+1,m+1),x(n,m+1)];
            Yp=[y(n,m),y(n+1,m),y(n+1,m+1),y(n,m+1)];
        end
        
        %Plug in the vertex values
        PLogic=InHomoGrid(u,v,Xp,Yp);
        check3=PLogic>1;
        
        %This makes sure each point can only be found once in a specific
        %quadrilateral.
        if check3~=0
            PLogic=arrayfun(@sign,PLogic);
            display("found greater than 1")
            m
            n
        end
        PLogicArrayP(n,m,:)=PLogic;
        
        %Delete the output point from the set to avoid finding the point
        %in multiple quadrilateral.    
        Pl=PLogic;
        if sum(Pl)~=0
            Pl=find(Pl>0);
            nPl=size(Pl);
            for i=1:nPl(2)
                u(Pl(i))=0;
                v(Pl(i))=0;                
            end
        end
    end
end

%Check whether all points are accounted for.
check2=sum(sum(PLogicArrayP,2),1);
check2=check2(:);
RefVect=ones(usz(2),1);
if isequal(check2,RefVect)==0
    check2
    display('InHomoLogic: discontinuous mapping *******______*******_________________________________*******************')
    return
end
PLogicArray=PLogicArrayP;
end

