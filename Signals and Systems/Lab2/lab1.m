% Lab 1: Continuos time Systems
% Tim Hollabaugh 9/19/19

clear all;
clf;

% Setup the time axis
time_step = 0.01;
time = -5:time_step:5;

% Problem 1: Plot the unit step

figure(1);
y_step = ustep(time, -3);
plot(time, y_step);
axis([-5 5 -1 5]);
title('Unit step response');
xlabel('time (seconds)');
ylabel('y_ step(t)');
grid;

% Problem 2: Plot the ramp function

figure(2);
y_ramp = ramp(time, 3, 0);
plot(time, y_ramp);
axis([-5 5 -1 5]);
title('Ramp response');
xlabel('time(seconds)');
ylabel('y_ ramp(t)');
grid;

% Problem 3: Plotting continuous time functions

figure(3);

y_1 = 3 * ustep(time, -2)
y_2 = ramp(time, 3, 3)
plot(time, y_1, time, y_2);
axis([-5 5 -1 5]);
title('Problem 3');
xlabel('time(seconds)');
ylabel('y(t)');
grid;

% Problem 4: Larger function
% y(1) = 3: OK
% y(4) = 0: OK

figure(4);

y_4 = ramp(time, 3, 3) - ramp(time, 6, 1) + ramp(time, 3, 0) - 3 * ustep(time, -3);
plot(time, y_4);
axis([-5 5 -1 5]);
title('Problem 4');
xlabel('time(seconds)');
ylabel('y(t)');
grid;

% Problem 5
% y(t) = 2r(t+2.5) - 5r(t) + 3r(t-2) + u(t-4)
% y(5) = 0, d/dt y(t) = 0, y(-5) = 0, d/dt y(-5) = 0,
% and there are no ramp or step functions that originate outsite of [-5, 5],
% so everything will stay at 0 past -5 and 5.

figure(5);

y_5 = ramp(time, 2, 2.5) + ramp(time, -5, 0) + ramp(time, 3, -2) + ustep(time, -4);
[y_5_even, y_5_odd] = evenodd(y_5);
plot(time, y_5, time, y_5_even, time, y_5_odd);
axis([-10 10 -3 5]);
title('Problem 5');
xlabel('time(seconds)');
ylabel('y(t)');
grid;

% Problem 6
% The radio station can multiply their audio signal by the sum of
% two unit step functions to bound it to the 3 minute range.
% y(t) = x(t) * (u(t) - u(t-3)), assuming time is measured in minutes

% Problem 7

y_7 = cos(pi*t) + cos((2*pi*t)/3)
plot(time, y_r);
axis([-10 10 -3 5]);
title('Problem 7');
xlabel('time(seconds)');
ylabel('y(t)');
grid;

