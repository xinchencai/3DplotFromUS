function Q = shiftCorrect(P,fitval)
    USlist = struct;
    Q = [];

%     a = -21.23;
%     b = -4.899;
%     c = 35.3;
    list = [];
    j = 1;

    for i = 1:length(P)
        if i == 1
            list = [list;P(i,:)];
        elseif P(i,3) == P(i-1,3)
            list = [list;P(i,:)];
        else
            USlist(j).myus = list;
            j = j + 1;
            list = [];
            list = [list;P(i,:)];
        end
    end

    USlist(j).myus = list;
    list = [];

    for i = 1:length(USlist)
        x = USlist(i).myus(1,3);
        y = fitval(3,1)*x.^2+fitval(3,2)*x+fitval(3,3);
        hei = (max(USlist(i).myus(:,2))-min(USlist(i).myus(:,2)))/2+min(USlist(i).myus(:,2));
        y_correct = y - hei;
        USlist(i).myus(:,2) = USlist(i).myus(:,2) + y_correct;
        len = (max(USlist(i).myus(:,1))-min(USlist(i).myus(:,1)))/2+min(USlist(i).myus(:,1));
        x_correct = 35 - len;
        USlist(i).myus(:,1) = USlist(i).myus(:,1) + x_correct;
        Q = [Q;USlist(i).myus];
    end
end