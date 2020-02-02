%*************************************************************
% Function to generate unit step 
% Input : time interval t, 
%         signal advance/delay factor ad,
% Output: Unit step response y
% Usage: y = ustep(t,ad);
%**************************************************************
 
function y = ustep(t,ad)
% generation of unit step
% t: time
% ad : advance  (positive), delay (negative)
 
N= length(t);
y = zeros(1,N);
for i = 1:N
    if t(i)>= -ad
        y(i) = 1;
    end
end
end
