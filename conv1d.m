hist=zeros(300,1);
x = ones(150,1);
hist(1:150,:) = x;

filterlen=50;
len=300;
    filter = mygausswin(filterlen,6);
      filter = filter/sum(filter);            % norm. to unit area
        tmp2=conv(filter,hist);                 % makes longer output
    tmp1=tmp2(1+filterlen/2:len+filterlen/2);
figure(1)
plot(filter)
figure(2)
plot(hist)
axis([0, 300, -1, 2])
figure(3)
plot(tmp1)
axis([0, 300, -1, 2])

gd = filter(1:48) - filter(2:49);
figure(4)
plot(gd)
axis([0, 48, -0.1, 0.1])

        tmp2=conv(gd,hist);                 % makes longer output
        tmp1=tmp2(25:324);
figure(5)
plot(tmp1)
            
