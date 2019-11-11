%*************************************
% function lab3q4(speech,start)
% Linear prediction analysis of one frame of speech
% Find lp coefficients, plot poles and error signal
% speech - speech signal
% start - starting sample of 30 ms frame
%*************************************

function lab3q4(speech,start)

%*************************************
% Extract 30 ms frame
sw = speech(start:start+239);

%*************************************
% Do lp analysis
a=lpc(sw,12);

%*************************************
% Find and plot poles of lp filter
poles=roots(a);

% Plot unit circle
figure(1)
step=0:0.1:2*pi;                
points=[cos(step); sin(step)];  
plot(points(1,:), points(2,:),'linewidth',2); 
axis('image');                  
hold;

% Plot poles
plot(poles,'x','linewidth',2);
hold;
title('Poles of linear prediction filter')

%*************************************
% Find frequency response (magnitude response)
[h,w]=freqz(1,a,256);
w=8000*w/(2*pi);
h=20*log10(abs(h));
figure(2);
plot(w,h,'linewidth',2);
xlabel('Frequency (Hz)')
ylabel('Magnitude response of filter')

%*************************************
% Filter signal to find error
lperror=filter(a,1,sw);

% Plot speech and error signal
figure(3);
subplot(211);
plot(sw,'linewidth',2);
title('Speech signal');
subplot(212);
plot(lperror,'linewidth',2);
title('Error signal');
                      
