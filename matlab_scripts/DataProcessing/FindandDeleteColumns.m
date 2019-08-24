%This script finds and deletes column with certain names
%preallocate matric
m=repmat(0,5,13855);
for i=1:5
      m(i,:)=contains(CompileA2(1,:),edit(i));
end
n=sum(m);
deleteNumber=find(n==1);
l=size(deleteNumber);    
%Delete the columns that were found
%Note that each deleted term is adjusted by subtracting i
for i=1:l(2)
    CompileA2(:,deleteNumber(i)+1-i)=[];
end
