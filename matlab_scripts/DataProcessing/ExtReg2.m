function OutPutArray=ExtReg2(PrimaryDataArray,ParallelParameter,SecondaryArray,OrthogonalRows)
%Takes an already-modified array with a primary parameter, finds a
%parallel parameter with the same orthogonal constrains (same person, same
%intervention, same repetition for example) from another data set.
%This allows the parallel parameter to be compiled in the correct
%order (aligned parameters).

%ParallelParameter can be more than one constraint to be as specific as
%possible so that the extract data function do not find more than one
%column for each iteration of the search.

%Initial definitions
A1=PrimaryDataArray;
An=size(A1);

P=ParallelParameter;

A2=SecondaryArray;
CV=OrthogonalRows;
CVn=size(CV);

%The variable d denots what row the data from A2 starts, here we assume it
%is 8.
d=8;
    
%Since the parameters in each column of the primary array is different,
%we construct parameter vector for each column using the row information.
%Then, combine it with the parallel parameter.
J=string(repmat(0,1,An(2)));
for j=1:An(2)
    Pk=string(repmat(0,CVn(2),1));
    for k=1:CVn(2)
        Pk(k)=A1(CV(k),j);
    end
    Psum=[Pk;P];
    x=ExtData(A2,Psum);
    check=size(x);
    if check(2)>1
        display not enough constraints error
        return
    end
    J(j)=x(d);
end
A1(9,:)=J;    
OutPutArray=A1;
end

    
        
    
    
