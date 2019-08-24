function Array=OpenTxt(filename)
%Takes folder location joined to file name, spits out array in string
%format

%Initial definition
delimiter = '\t';
startRow = 1;
endRow = inf;
RT=readtable(filename);
sz=size(RT);

%Creating format from variable number of columns, the number of columns
%correspond to the numbers of s%
FS=repmat("s%",1,sz(2));
FS=join(FS);
FS=erase(FS," ");
FSpad=string("%*[^\n\r]");
formatSpec=insertBefore(FSpad,"[",FS)

%The rest is from import function
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'TextType', 'string', 'HeaderLines', startRow(1)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'TextType', 'string', 'HeaderLines', startRow(block)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end
fclose(fileID);
Array = [dataArray{1:end-1}];
end
