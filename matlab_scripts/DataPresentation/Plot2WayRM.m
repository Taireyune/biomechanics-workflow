function GraphOutPut=Plot2WayRM(vectorX1,vectorX2,vectorY1,vectorY2) 
a1=vectorX1;
a2=vectorX2;
b1=vectorY1;
b2=vectorY2;
n=size(a1);
n=n(1);
hold on
for i=1:n
    plot([a1(i),a2(i)],[b1(i),b2(i)],'LineWidth',0.5,'Color',[0 0 0])
end
hold off
end
