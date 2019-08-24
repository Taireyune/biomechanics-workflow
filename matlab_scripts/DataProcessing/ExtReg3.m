function OutPutArray = ExtReg3(PrimaryDataArray,ParameterArray,SecondaryDataArray,OrthogonalRows)
%Takes an already-modified array with a primary parameter, finds multiple
%parallel parameters from parameter array with the same orthogonal constrains 
%(same person, same intervention, same repetition for example) from another 
%data set. This allows the parallel parameter to be compiled in the correct
%order (aligned parameters).

%Parallel Parameters can be more than one constraint to be as specific as
%possible so that the extract data function do not find more than one
%column for each iteration of the search.

PA=ParameterArray;
PAn=size(PA);
PD=PrimaryDataArray;

for i=1:PAn(2)
    IM=ExtReg2(PrimaryDataArray,PA(:,i),SecondaryDataArray,OrthogonalRows);
    PD(8+i,:)=IM(9,:);
end
OutPutArray=PD;
end
