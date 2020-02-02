% Lab 1: Continuos time Systems
% Tim Hollabaugh 9/19/19

clear all;
clf;

% Problem 1: Plot u(t+20)-u(t-20)

figure(1);
time_1 = -25:0.01:25;
y_1 = ustep(time_1, 20) - ustep(time_1, -20);
plot(time_1, y_1);
axis([-25 25 -2 2]);
title('Probblem 1');
xlabel('time (seconds)');
ylabel('y(t)');
grid;

% Problem 2: Square wave that is 1 from 0 to 5, -1 from 5 to 10

figure(2);
time_2 = 0:0.01:30;
y_2 = ustep(time_2, 0) - 2 * ustep(time_2, -5) + 2 * ustep(time_2, -10) - 2 * ustep(time_2, -15) + 2 * ustep(time_2, -20) - 2 * ustep(time_2, -25) + 2 * ustep(time_2, -30);
plot(time_2, y_2);
axis([-1, 31, -2, 2]);
title('Problem 2');
xlabel('time (seconds)');
ylabel('y(t)');
grid;

% Problem 3: 2 sin(250πt – pi/5)

figure(3);
time_3 = 0:0.0004:0.3;
y_3 = zeros(1, ceil(0.3/0.0004)+1);
for i = 1:(ceil(0.3/0.0004)+1)
    y_3(i) = 2 * sin(250 * pi * time_3(i) - pi / 5);
end
plot(time_3, y_3);
axis([-0.1, 0.4, -2, 2]);
title('Problem 3');
xlabel('time (seconds)');
ylabel('y(t)');
grid;

% Problem 4: 

figure(4);
time_4 = 0:0.05:40;
y_4 = zeros(1, ceil(40/0.05)+1);
y__4 = zeros(1, ceil(40/0.05)+1);
for i = 1:(ceil(40/0.05)+1)
    y_4(i) = cos(2 * time_4(i) + time_4(i) * time_4(i) / 2);
    y__4(i) = time_4(i) + 2;
end
plot(time_4, y_4, time_4, y__4);
axis([-1, 41, -2, 41]);
title('Problem 4');
xlabel('time (seconds)');
ylabel('y(t)');
grid;

% Problem 5: 

figure(5);
time_5 = 0:0.05:40;
y_5 = zeros(1, ceil(40/0.05)+1);
y__5 = zeros(1, ceil(40/0.05)+1);
for i = 1:(ceil(40/0.05)+1)
    y_5(i) = cos(2 * time_5(i) - 2 * sin(time_5(i)));
    y__5(i) = 2 - 2 * cos(time_5(i));
end
plot(time_5, y_5, time_5, y__5);
axis([-1, 41, -2, 5]);
title('Problem 5');
xlabel('time (seconds)');
ylabel('y(t)');
grid;

% Problem 6:

figure(6);
time_6 = 0:0.1:200;

y_61 = zeros(1, ceil(200/0.1)+1);
f_61 = 159:(2/(51+1)):161;
for i = 1:(ceil(200/0.1)+1)
    for j = 1:51
        y_61(i) = y_61(i) + 10 * cos(2 * pi * f_61(j) * time_6(i));
    end
end

y_62 = zeros(1, ceil(200/0.1)+1);
f_62 = 159:(2/(101+1)):161;
for i = 1:(ceil(200/0.1)+1)
    for j = 1:101
        y_62(i) = y_62(i) + 10 * cos(2 * pi * f_62(j) * time_6(i));
    end
end

plot(time_6, y_61, time_6, y_62);
axis([-1, 201, -11, 11]);
title('Problem 6');
xlabel('time (seconds)');
ylabel('y(t)');
grid;

saveas(1, "1.png");
saveas(2, "2.png");
saveas(3, "3.png");
saveas(4, "4.png");
saveas(5, "5.png");
saveas(6, "6.png");