function TwoParameterArray=ExtReg(InputArray,Parameter1,Parameter2,DataStartAt)
%Takes data array and two parameters (one parameter per slot), spits out a matrix with values of the
%two parameters.
%The each pair of values come from the same trial.
P1=string(Parameter1);
P2=string(Parameter2);
DS=DataStartAt;
IA=InputArray;
A1=ExtData(IA,P1);
x=find(strcmp(A1(:,1),P1));
sz=size(A1);
Title1=string(repmat(P2,1,sz(2)));
A2=string(repmat("0",sz(1),sz(2)));
Pt=A1(1:DS-2,:);
Pi=Pt;
Pi(x,:)=Title1;
%%FPA=ExtData(IA,Pi(:,1));
for i=1:sz(2)
    A2(:,i)=ExtData(IA,Pi(:,i));
    %%x=size(FPA2);
    %%if x(2)>1
       %%display found
        %%g=i
    %%return
    %%end
    %%FPA=[FPA,FPA2];
end
TwoParameterArray=[Pt;Title1;A1(DS,:);A2(DS,:)];
end

%scatter(str2double(A1(8,:)),str2double(A2(8,:)))

%Px=string("Average_FPA");

%for i=1:351
  % Ax(1:5,i))
   
   
   %Try strcmp