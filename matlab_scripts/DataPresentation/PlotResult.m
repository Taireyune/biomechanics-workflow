function Plot = PlotResult(Array,fN,DataStart,AxisLabel)
%This function takes a 101 by n array and plots the n columns on the y axis
%against x
%The number fN correspond to the figure number of the plot.

%x indices and other definition
x=[0;1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17;18;19;20;21;22;23;24;25;26;27;28;29;30;31;32;33;34;35;36;37;38;39;40;41;42;43;44;45;46;47;48;49;50;51;52;53;54;55;56;57;58;59;60;61;62;63;64;65;66;67;68;69;70;71;72;73;74;75;76;77;78;79;80;81;82;83;84;85;86;87;88;89;90;91;92;93;94;95;96;97;98;99;100];
DS=DataStart;
NA=Array(DS:end,:);
NA=str2double(NA);
n=size(Array);

%Use string modification to plot multiple columns against x
V=[1:n(2)];
V=string(V);
V=pad(V,3); %leave some space at the end
V(1:end-1)=insertAfter(V(1:end-1),3,'),'); 
V(end)=insertAfter(V(end),3,'))');  %the last term cannot have a comma
V=insertBefore(V,1,'x,NA(:,');
V(1)=insertBefore(V(1),1,'plot(');  
%we put the plot function in the string because function cannot go around
%eval.
V2=join(V);
Plot=eval(V2);
%legend gives the graphs the labels from the first, fourth, and fifth row
%jointed by '-'
%%LegendName=[Array(1,:);Array(4:5,:)];
LegendName=Array(1,:);
%%LegendName = join(LegendName,'-',1)
legend(LegendName);
%figure specify the figure number the graph goes in
figure(fN);
%axis are labeled based on parameter
%%AxisLabel=[Array(6,1),Array(7,1)];
%%AxisLabel=join(AxisLabel);
ylabel(string(AxisLabel));
xlabel("Time Normalized to 100%");
end
