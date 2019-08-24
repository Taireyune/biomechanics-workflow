function [OutPutArray,SizeVector]=HomoReshape(MonsterArray,InOut,MonsterDimensions)
%Two functions in and out.
MA=MonsterArray;
sz=size(MA);

%Path InOut = 0 takes a monster array.
%Output a 3 by x reshaped array of the monster array and the size of the
%monster array.
if InOut==0
    N=sz(1);
    M=sz(2);
    TDA=zeros(3,3*sz(1)*sz(2));
    for n=1:N
        for m=1:M
            i=3*((n-1)*M+m);
            TDA(:,i-2:i)=MA(n,m,:,:); 
        end
    end
    OutPutArray=TDA;
    SizeVector=sz;
end

%Path InOut = 1 takes a 3 by x array and the corresponding monster array dimension vector,
%Reconstruct the monster array. 
if InOut==1
    MD=MonsterDimensions;
    MB=zeros(MD(1),MD(2),3,3);
    for n=1:MD(1)
        for m=1:MD(2)
            i=3*((n-1)*MD(2)+m);
            MB(n,m,:,:)=MA(:,i-2:i);
        end
    end
    OutPutArray=MB;
    SizeVector=0;
end
    
if InOut~=1 & InOut~=0
    display('second input is 0 or 1 only')
    return
end