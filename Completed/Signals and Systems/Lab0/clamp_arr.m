% Makes any value less than 0 be -1
function result = clamp_arr(x)
    result = arrayfun(@(x) clamp(x), x);
end

function r = clamp(x)
    if x < 0
        r = -1;
    else
        r = x;
    end
end