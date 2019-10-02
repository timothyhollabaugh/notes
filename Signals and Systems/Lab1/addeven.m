function sum = addeven(x)
    s = 0;
    for i = 1:length(x)/2
        s = s + x(i*2);
    end
    sum = s;
end