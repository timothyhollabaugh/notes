% Tim Hollabaugh
% ECE09341
% Lab 1.1

clc;
clf;
clear variables;

% sampling frequency
fs = 10000;

% sampling interval
dt = 1.0/fs;

% signal frequency
f0 = 100;

% Total points
Npt = fs/f0 + 1.0;

tm = zeros(1, Npt);
x = zeros(1, Npt);
y = zeros(1, Npt);
z = zeros(1, Npt);

for i = 1:Npt
    tm(i) = (i-1)*dt;
    x(i) = 10.0 * sin(2 * pi * f0 * tm(i));
    y(i) = 5.0 * cos(2 * pi * f0 * tm(i));
    if (i < Npt/2)
        z(i) = 10;
    else
        z(i) = -10;
    end
end

% Plot data

figure(1);
plot(tm, x, 'r');
hold on;
plot(tm, y, 'b*');
title("Example function");
xlabel("time");
ylabel("x");

figure(2);
subplot(1, 2, 1);
plot(tm, x);
title('x function');

subplot(1, 2, 2);
plot(tm, y);
title('y function');

figure(3);
plot(tm, z);
ylim([-11, 11]);
xlim([-0.001, 0.011]);

figure(4);
tm = [-2, -2, 0, 0, 2, 4, 4];
x = [0, 1, 1, 2, 2, 1, 0];
tm2 = [-4, -4, -2, -2, 0, 2, 2];
tm3 = [2, 2, 0, 0, -2, -4, -4];
tm4 = [-4, -4, 0, 0, 4, 6, 6];
plot(tm, x);
hold on;
plot(tm2, x);
hold on;
plot(tm3, x);
hold on;
plot(tm4, x);
xlim([-10, 10]);
ylim([-1, 3]);


