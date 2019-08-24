function [Data,FirstMean,SecondMean,SecondSD,ThirdMean]=StatWork(Array,Parameters)
%Takes Array and selection parameters, spits out mean value vector and
%standard deviation vector.
%First mean represent average between multiple trials of the same
%conditions
Data=ExtData(Array,Parameters);
FirstMean=StatArray(Data);

%Second mean and standard deviation represent average/SD between different
%legs of the same experimental treatment
SecondMean=mean(str2double(FirstMean(end-100:end,:)),2);
SecondSD=std(str2double(FirstMean(end-100:end,:)),0,2);

%Third mean represent average of the whole time course (one value per
%column)
ThirdMean=mean(str2double(Data(end-100:end,:)),1);
ThirdMean=[Data(1:7,:);ThirdMean];
end
