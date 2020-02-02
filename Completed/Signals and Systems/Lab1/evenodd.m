% generate the even and odd portions of the signal
function [y_even, y_odd] = evenodd(y)
    y_r = fliplr(y);
    y_even = 0.5 * (y + y_r);
    y_odd = 0.5 * ( y - y_r);
end
