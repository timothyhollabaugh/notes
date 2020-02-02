syms W
for k=1:24;
E(k)=single(int((sin(0.5*W)/(0.5*W))^2 ,W,0,k*pi)/pi);
end
stem(E,'linewidth',2); 
hold on
EE=0.9900*ones(1,24); 
plot(EE,'r','linewidth',2)
set(gca,'XTick',0:5:25)
set(gca,'XTickLabel',{'0','5\pi','10\pi','15\pi','20\pi','25\pi'})
xlabel('Angular frequency')
ylabel('Signal Energy')
axis([0 25 0 1.1])
