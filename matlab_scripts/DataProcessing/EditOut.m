KME1=KMA1;
KME2=KMA2;
KME3=KMA3;
KME4=KMA4;


x=contains(A1(1:5,:),string("tysc100020"))+contains(A1(1,:),string("tysc100023"));
x=contains(A1(1,:),string("tysc100012"));
x=find(x)
n=size(x)
for i=1:n(2)
    A1(:,x(n(2)+1-i))=[];
end



MM=repmat(0,6,12315,6);
V=["tysc100005";"Uneven";"normal";"right";"second";"Min_Knee_Moment_Y"]
for i=1:6
   MM(6,12315,i)=contains(A1(1:6,:),V(i));
end
D1=contains(A1(1:6,:),V(1));
D2=contains(A1(1:6,:),V(2));
D3=contains(A1(1:6,:),V(3));
D4=contains(A1(1:6,:),V(4));
D5=contains(A1(1:6,:),V(5));
D6=contains(A1(1:6,:),V(6));
D=D1+D2+D3+D4+D5+D6;
Dx=sum(D);
found=find(Dx==max(Dx))
V1=sum(sum(MM,3));
Max=max(V1);
=find(V1==Max)

Data=[Labels;Import(2,:);Import(5:end,:)];
Data(6,:)=replace(Data(6,:),"R_","");
Data(6,:)=replace(Data(6,:),"L_","");
Data(7,:)=insertAfter(Data(7,:),1,"_");
Data(7,:)=insertBefore(Data(7,:),1,"_");

