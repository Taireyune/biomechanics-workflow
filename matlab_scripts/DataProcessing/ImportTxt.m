function Y = ImportTxt(filename, startRow, endRow)
%Turns data from text file into Matlab String Array.
%Skip the first column. When not specified, import 1*endRow;2*endColumn 
delimiter = '\t';
% Initialize variables.
if nargin<=2
        startRow = 1;
        endRow = inf;
end

% Format for each line of text:
columnN=size(readtable(filename));
formatSpec = ['%*',repmat('s%',[1,columnN(2)]),'[^\n\r]']

% Open the text file
fileID = fopen(filename,'r');

% Read columns of data according to the format.
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'TextType', 'string', 'HeaderLines', startRow(1)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'TextType', 'string', 'HeaderLines', startRow(block)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

% Close the text file.
fclose(fileID);

% Create output variable
Y = [dataArray{1:end-1}]
end
