function Y = DataCompilation(FolderDirectory,Row)
%DataComplilation takes a folder (using folder directory) of Txt data and
%spits out one array of all the data by appending from left to right 
%(column to column). 
%Number of total rows can be specified (Usually 106, may need
%verification).

%insert folder directory to get file name array
A=dir(FolderDirectory); 

%number of files
sz=size(A);

%initial file name
%first two rows are empty, so start with 3
F1=join([A(3).folder '\' A(3).name]); 

%import using function by TY
Data=ImportTxt(F1);
Dim=size(Data);

%this make sure the dimension of Data i=3 has the correct number of rows
    if Dim(1)~=Row
        EmpStr1=string(repmat({''}, Row-Dim(1), Dim(2)));
        Data=[Data;EmpStr1];
    end

%loop the proccess to append more files
i=4;
    for i=4:sz
%variable ending in "i" changes with the loop      
        Fi=join([A(i).folder '\' A(i).name]); 
        Datai=ImportTxt(Fi);
        Dimi=size(Datai);
%modify datai to the correct number of rows        
        if Dimi(1)~=Row
            EmpStri=string(repmat({''}, Row-Dimi(1), Dimi(2)));
            Datai=[Datai;EmpStri];    
        end
%append new data to the right of original array
    Data=[Data Datai];
    end

%final array
Y=Data;  
end

