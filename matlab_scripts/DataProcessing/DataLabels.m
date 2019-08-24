function AxBLabel = DataLabels(Row1)
%Takes string vector of file names and spits out a labeling matrix


%#1
%Takes string array of file names and spits out a row with code names only
%all lowercase
A1=lower(Row1);
%delete front and back
N1=eraseBetween(A1,'h:\','mmed_','Boundaries','inclusive');
N1=eraseBetween(N1,'-','c3d','Boundaries','inclusive');
%apply getCode to every index
RowCode=arrayfun(@GetCode,N1);


%#2
%Takes string array of file names and spits out a row with group names
RowGroup=arrayfun(@Classification,N1);


%#3
%Takes string array of file names and spits out a row with the type of intervention
%row containing 0 and 1 where 1's are where patterns were found
A2=contains(A1,'-b');
%multiply the different pattern by 2 to differentiate
A3=2*contains(A1,'-s');
A4=string(A3+A2);
%replace numbers with words
A4=replace(A4,'0','normal');
A4=replace(A4,'1','big');
A4=replace(A4,'2','small');
%check whethere there is misread symbols
idx=A3+A2==0;
check1=sum(idx(:));
check2=sum(contains(A1,'-n'));
if check1~=check2
    return
end
%results
RowInterv=A4;


%#4
%Takes string array of file names and spits out a row with the left or
%right leg.
%Row containing 0 and 1 where 1's are where patterns were found, same as
%before.
B1=contains(A1,'-l');
B2=string(B1);
B2=replace(B2,'true','left');
B2=replace(B2,'false','right');
%check if consistant
B3=~contains(A1,'-r');
if sum(B1)~=sum(B3)
    return
end
%results
RowLeg=B2;


%#5
%Takes string array of file names and spits out a row with trial number
%Row containing 0 and 1 where 1's are where patterns were found, same as
%before.
C1=contains(A1,'1.c3d');
C2=2*contains(A1,'2.c3d');
C3=3*contains(A1,'3.c3d');
C4=4*contains(A1,'4.c3d');
C5=5*contains(A1,'5.c3d');
C6=C1+C2+C3+C4+C5;
%Check for error
check3=C6>5;
if sum(check3)>0
    return
end
C6=string(C6);
C6=replace(C6,'1','first');
C6=replace(C6,'2','second');
C6=replace(C6,'3','third');
C6=replace(C6,'4','fourth');
C6=replace(C6,'5','fifth');
%results
RowTrials=C6; 

%combine the rows
AxBLabel=[RowCode;RowGroup;RowInterv;RowLeg;RowTrials];
end

%TryBigTitle=DataLabels(TryBigData(1,1:end))
