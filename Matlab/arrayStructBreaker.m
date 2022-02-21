function Px = arrayStructBreaker(P)
    list = [];
    USpt = struct;
    Px = struct;
    j = 1;

    for i = 1:length(P)
        if i == 1
            list = [list;P(i,:)];
        elseif P(i,3) == P(i-1,3)
            list = [list;P(i,:)];
        elseif round(P(i,3) - pi,5) == round(P(i-1,3),5)
            list = [list;P(i,:)];
        elseif round(P(i,3) + pi,5) == round(P(i-1,3),5)
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
    
    for i = 1:9
        Px(i).myP = [];
    end
    
    for i = 1:length(USpt)
        Px(1).myP = [Px(1).myP;USpt(i).myus];
        if rem(i-1,2)==0
            Px(2).myP = [Px(2).myP;USpt(i).myus];
        end
        if rem(i-1,3)==0
            Px(3).myP = [Px(3).myP;USpt(i).myus];
        end
        if rem(i-1,4)==0
            Px(4).myP = [Px(4).myP;USpt(i).myus];
        end
        if rem(i-1,5)==0
            Px(5).myP = [Px(5).myP;USpt(i).myus];
        end
        if rem(i-1,6)==0
            Px(6).myP = [Px(6).myP;USpt(i).myus];
        end
        if rem(i-1,7)==0
            Px(7).myP = [Px(7).myP;USpt(i).myus];
        end
        if rem(i-1,8)==0
            Px(8).myP = [Px(8).myP;USpt(i).myus];
        end
        if rem(i-1,9)==0
            Px(9).myP = [Px(9).myP;USpt(i).myus];
        end
    end
end