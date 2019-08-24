%StatMatrix=[FPA(7,:);Impulse(7,:);HAA(7,:);HRA(7,:);KRA(7,:)];
%AI=inputarray
%i=Xaxis
%j=Yaxis
%Markers = ["o","x","+","*"];
    AI=str2double(StatMatrix);
    i=5;
    j=2;
    %figure
    %range of axis
    %axis([-10 50 -35 20])
    %xlabel('Foot Progression Angle (degrees)');
    %ylabel('Knee Internal Rotation (degrees)'); 

    hold on
    scatter(AI(i,1:39),AI(j,1:39),'o','b');
    scatter(AI(i,40:71),AI(j,40:71),'o','r');
    scatter(AI(i,72:119),AI(j,72:119),'*','r');
    scatter(AI(i,120:167),AI(j,120:167),'*','b');

    legend("Parallel group, regular","Parallel group, big","ToeOut group, small","ToeOut group, regular");

    hold off
