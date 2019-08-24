importData1 = DataCompilation('C:\Users\Taire\Desktop\readFolder',106)

R1 = importData1(1,:)
labels = DataLabels(R1)

trimmed = cat(1, importData1(2,:), importData1(5:end,:));
Compile20190212 = cat(1, labels, trimmed);
edited1 = insertBefore(Compile20190212(7,:), 1, "_");
edited1 = insertAfter(edited1, 2, "_");
Compile20190212(7,:) = edited1;


IA2 = strrep(IA1,"L_", "");
IA2 = strrep(IA2,"R_", "");

%Obtain impulse, FPA, and knee moments. Point values
P1=["Parallel";"normal";"Average_FPA";"_X_"];
P2=["Parallel";"big";"Average_FPA";"_X_"];
P3=["ToeOut";"small";"Average_FPA";"_X_"];
P4=["ToeOut";"normal";"Average_FPA";"_X_"];

output = StatRunPt(IA1,P1,P2,P3,P4);
output = output';
xlswrite('C:\Users\Taire\Desktop\FPA.xlsx',output);

%Obtain hip angle, knee angles, knee moments
parameter1 = ["ANKLE_ANGLE"; "_Z_"];
Array = ExtData(IA2, parameter1);
[Data,FirstMean,SecondMean,SecondSD,ThirdMean] = StatWork(Array,parameter1);

P1=["Parallel";"normal";"ANKLE_ANGLE";"_Z_"];
P2=["Parallel";"big";"ANKLE_ANGLE";"_Z_"];
P3=["ToeOut";"small";"ANKLE_ANGLE";"_Z_"];
P4=["ToeOut";"normal";"ANKLE_ANGLE";"_Z_"];

output = StatRunPt(ThirdMean,P1,P2,P3,P4);
output = output';
xlswrite('C:\Users\Taire\Desktop\ankleExternal.xlsx',output);
