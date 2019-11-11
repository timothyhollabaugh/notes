% Generate a ramp function
% time: Array of all the time values
% slope: the slope of the ramp
% offset: the time offset of the ramp. positive -> advance, negative -> delay
function y = ramp(time, slope, offset)

    y = zeros(1, length(time));
    for i = 1:length(time)
        if time(i) >= -offset
            y(i) = (time(i) + offset) * slope;
        end
    end

end
