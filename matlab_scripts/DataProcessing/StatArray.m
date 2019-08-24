function StatArray = StatArray(InputArray)
%takes specific parameter data array (string) and spits out the average 
%for column with the same first row and left/right
IA4=InputArray;
side=["left","right"];
name=unique(IA4(1,:));
n=size(name);
y=string(repmat(0,2,2*n(2)));
for i=1:2*n(2)
    y(1,i)=name(ceil(i/2));
    y(2,i)=side(~mod(i,2)+1);
end
StatArray=string(repmat(0,107,2*n(2)));
for i=1:2*n(2) 
Oneset=ExtData(IA4,y(:,i));
Average=string(mean(str2double(Oneset(8:end,:)),2));
StatArray(:,i)=[Oneset(1:4,1);Oneset(6:7,1);Average];
end
end