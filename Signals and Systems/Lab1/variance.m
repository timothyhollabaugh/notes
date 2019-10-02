function result = variance(x)
    s = 0;
    for i = 1:length(x)
        s = s + (x(i) - mean(x))^2;
    end
    result = 1/length(x) * s;
end