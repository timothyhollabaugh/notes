clear vars;

%Problem 1
a = addeven(1:1000);

%Problem 2
b = clamp_arr([1, -1, 5, -5, 0]);

%Problem 3
c = variance([1, 2, 3, 4]);

%Problem 4
d = zeros(1000, 1);
t = zeros(1000, 1);
for i = 1:1000;
    t(i) = i;
    d(i) = hard_limit(i/1000);
end

plot(t, d);