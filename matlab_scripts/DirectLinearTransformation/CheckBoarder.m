function YesNo=CheckBoarder(BoarderPoint,P1,P2,P3,P4)
%Takes known points on the boarder for a specific quadrilateral and tell
%whether the point is on the top left two edges.
D1=Dist2Line(BoarderPoint,P1,P2);
D2=Dist2Line(BoarderPoint,P2,P3);
D3=Dist2Line(BoarderPoint,P3,P4);
D4=Dist2Line(BoarderPoint,P4,P1);
D=[D1,D2,D3,D4];
ClosestDistance=min(D);
n=find(D==ClosestDistance);
sz=size(n);
YesNo=0;
if n==[1,4]         %Top left vertex
    YesNo=1;
    display("CheckBoarder: on point")
else
    if sz(2)==1
        if n==1|n==4    %Top or left edge
            YesNo=1;
            display("CheckBoarder: on line")
        end
    end
end
end
