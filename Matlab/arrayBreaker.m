function USpt = arrayBreaker(P)
    list = [];
    USpt = struct;
    j = 1;

    for i = 1:length(P)
        if i == 1
            list = [list;P(i,:)];
        elseif P(i,3) == P(i-1,3)
            list = [list;P(i,:)];
        else
            USpt(j).myus = list;
            j = j + 1;
            list = [];
            list = [list;P(i,:)];
        end
    end

    USpt(j).myus = list;
    list = [];
%     P1 = []; P2 = []; P3 = []; P4 = [];


%     for i = 1:length(USpt)
%         P1 = [P1;USpt(i).myus];
%         if rem(i-1,2)==0
%             P2 = [P2;USpt(i).myus];
%         end
%         if rem(i-1,4)==0
%             P3 = [P3;USpt(i).myus];
%         end
%         if rem(i-1,9)==0
%             P4 = [P4;USpt(i).myus];
%         end
%     end
end