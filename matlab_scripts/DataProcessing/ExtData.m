function ExtractedArray = ExtData(InputArray,ParameterVector)
%takes run data and spits out the array for specific parameters

%Inital definition
InA=InputArray;
PV=string(ParameterVector);

%Dimensions of input
n1=size(PV);
n2=size(InA);
PR=7;       %Parameter range in the InputArray

%Use contains function to find a 3-Dimensional array p. 
%Each i layer is one variable 
p=repmat(0,PR,n2(2),n1(1));
for i=1:n1(1)
    p(:,:,i)=strcmp(InA(1:PR,:),PV(i)); %contains vs strcmp
    if sum(sum(sum(p(:,:,i))))==0
        disp("Parameter not found")
        return       
end

%The matrix p gets collapsed down to 1 by n2(2) extraction vector 
EV=sum(sum(p,3)); 
%Only when all parameters are met does the extraction vector produce 1
%Reduce the vector to positions of the output columns
EV=find(EV==max(EV));  

%Use string syntax to produce function for the extraction array
%Good to use in the future
EV1=string(EV);
EV1=pad(EV1,10);
EV1=insertAfter(EV1,10,'),');
EV1(end)=insertAfter(EV1(end),12,']');
EV1=insertBefore(EV1,1,'InA(:,');
EV1(1)=insertBefore(EV1(1),1,'[');
EV2=join(EV1);

%Note that eval can only operate on scalars
%Final answer
ExtractedArray=eval(EV2);
end