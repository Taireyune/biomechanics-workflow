function output=StatRunPt2(IA1,P1,P2,P3,P4)
%Takes data array (raw data) and parameter vectors (seperated by group), spits out matrix with names,
%means, and SD
P=[P1 P2 P3 P4];

Array1=ExtData(IA1,P(:,1));
Array2=StatPoint(Array1);
for i=2:4
    Array3=ExtData(IA1,P(:,i));
    Array4=StatPoint(Array3);
    Array2=[Array2,Array4];
end
output=Array2;
end
%Output numberic data in two column, and append data from each group to the
%bottom of the previous