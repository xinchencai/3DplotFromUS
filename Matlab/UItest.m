clear
clc

x = linspace(0,100,1);

for i = 1:6
    y = i*x;
    subplot(3,2,i);plot(x,y);
    my_str = strcat('Graph number: ',num2str(i));
    uicontrol('Style','text','Position',find_pos(i),'String',my_str);
end