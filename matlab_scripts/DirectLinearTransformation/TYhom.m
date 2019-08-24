function OutPut = TYhom(InputArray,InOut)

IA=InputArray;
n=size(IA);

%Path of InOut = 0 takes any numeric array and returns homogeneous array by appending 1 at the
%after the last row of the array. 
if InOut==0
    OneVect=ones(1,n(2));
    OutPut=[IA;OneVect];
end

%Path of InOut = 1 takes homogeneous array and returns cartisian array. 
if InOut==1
    IAnorm=ones(n(1),n(2));
    for i=1:n(2)
        IAnorm(:,i)=IA(:,i)/IA(end,i);
    end
    OutPut=IAnorm(1:end-1,:);
end

if InOut~=1 & InOut~=0
    display('second input is 0 or 1 only')
    return
end
end

