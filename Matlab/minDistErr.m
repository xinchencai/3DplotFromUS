function min = minDistErr(A1,A2)
    arr = [];
    for i = 1:length(A1(1,:))
        vec = A2(:,i) - A1(:,i);
        dist = sqrt(vec(1)^2+vec(2)^2);
        arr = [arr;dist];
    end
    min = mean(arr);
end