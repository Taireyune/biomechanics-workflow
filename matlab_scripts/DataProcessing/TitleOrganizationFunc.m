function [outputArg1,outputArg2] = TitleOrganizationFunc(inputArg1,inputArg2)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
outputArg1 = inputArg1;
outputArg2 = inputArg2;
end

"DeletionName","SubjectCode"
%DeletionName="H:\waibazishuju\c3d\20170929-C3D\Trimmed_chenmeng"
%SubjectCode="TYSC00001"

%size of your big ass array
baa=size(Big)
EndCol=baa(2)

%add "-" to the names without "-" between left/right and trial number
IntRow1=Big(1,1:end)
IntRow1=lower(IntRow1)
for i=1:EndCol
    if endsWith(IntRow1(i),'-1.c3d')==0|endsWith(IntRow1(i),'-2.c3d')==0|endsWith(IntRow1(i),'-3.c3d')==0|endsWith(IntRow1(i),'-4.c3d')==0|endsWith(IntRow1(i),'-5.c3d')==0
        IntRow1(i)=insertBefore(IntRow1(i),5,'-')
    end
end

A1=lower(Row1);
A2=contains(A1,'-b');
A3=2*contains(A1,'-s');
A4=string(A3+A2);
A4=replace(A4,'0','normal');
A4=replace(A4,'1','big');
A4=replace(A4,'2','small')
idx=A3+A2==0
check1=sum(idx(:))
check2=sum(contains(A1,'-n'))
if check1~=check2
    return
end
RowInterv=A4

B1=contains(A1,'-l');
B2=string(B1);
B3=~contains(A1,'-r');
B2=replace(B2,'1','left');
B2=replace(B2,'0','right');
if sum(B1)~=sum(B3)
    return
end
RowLeg=B2

C1=contains(A1,'1.c3d');
C2=2*contains(A1,'2.c3d';
C3=3*contains(A1,'3.c3d');
C4=4*contains(A1,'4.c3d');
C5=5*contains(A1,'5.c3d');
C6=C1+C2+C3+C4+C5
check3=C6>5
if sum(check3)>0
    return
end
RowTrails=string(C6)

H:\waibazishuju\c3d\20171018-C3D\CHENTONGFENG\Trimmed_chentongfeng-B-L-1.c3d';
NewRow=erase(row1,name1)
for i=1:EndCol
    if contain(row1(i),name1)==1
        nameRow(i)=GetCode(name1)
    end
end


V=contain(row1,name1)
V=code*V
V=string(V)
V=pad(V,4+x,'left','TYSC')
   
strlength(name1)

Row1=["H:\waibazishuju\c3d\20170930-C3D\geyongwei\Trimmed_geyongwei-N-L-1.c3d","H:\waibazishuju\c3d\20170930-C3D\geyongwei\Trimmed_geyongwei-N-L-1.c3d"]
A1=lower(Row1)
%delete front and back
N1=eraseBetween(A1,'h:\','mmed_','Boundaries','inclusive')
N1=eraseBetween(N1,'-','c3d','Boundaries','inclusive')
%apply getCode to every index
RowCode=arrayfun(@GetCode,N1)

CompileB=[CompileTitle;CompileA(2,:);CompileA(5:end,:)]
