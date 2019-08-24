function StatResult = StatPoint(InputArray)
%takes specific parameter data array and spits out average and standard deviation
%between the experimental repetitions 
IA4=InputArray;
side=["left","right"];
name=unique(IA4(1,:));
n=size(name);
y=string(repmat(0,2,2*n(2)));
for i=1:2*n(2)
    y(1,i)=name(ceil(i/2));
    y(2,i)=side(~mod(i,2)+1);
end
m=8;
StatResult=string(repmat(0,m,2*n(2)));
for i=1:2*n(2) 
Oneset=ExtData(IA4,y(:,i));
Average=string(mean(str2double(Oneset(m,:))));
SD=string(std(str2double(Oneset(m,:))));
%number of rows should add up to m
StatResult(:,i)=[Oneset(1:4,1);Oneset(6:7,1);Average;SD]; 
end
end