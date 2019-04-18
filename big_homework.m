close all;
clear;
clc;
v_sound = 340;
[y,Fs] = audioread('sound.wav');
t_y = linspace(0,(length(y)-1)/Fs,length(y));
figure;
plot(t_y,y);
xlabel("t(s)");
ylabel("幅度");
title("麦克风接收声音的时域波形");

nfft = 512;
nooverlap = nfft - 2;
[s,f,t] = spectrogram(y,nfft,nooverlap,nfft,Fs);
figure;
imagesc(t,f,log10(abs(s)));
set(gca, 'YDir', 'normal');
xlabel('时间 (secs)');
ylabel('频率(Hz)');
title('麦克风接收声音的短时傅里叶变换');
[m,n] = max(abs(s));

% figure;
% plot(t,n);

figure;
plot(t,f(n));
set(gca,'YLim',[0 4000]);
title("分离得到的主要的STFT");
xlabel('Time (secs)');
ylabel('Freq (Hz)');

f_max = f(max(n));
f_min = f(min(n));
f_0 = (f_max + f_min)/2;
v_1 = (f_max - f_0)/f_max*v_sound;
v_2 = (f_0 - f_min)/f_min*v_sound;
v_average = (v_1 + v_2)/2;
disp(v_average);
[a,max_e] = find(n == max(n));
[b,min_e] = find(n == min(n));
t_min = (t(max_e(1)) + t(min_e(1)))/2;
flag = 0;
for i = 1:1:length(max_e)
    if max_e(i)>min_e(1)
        flag = i;
        break;
    end
end
t_max = (t(max_e(flag)) + t(min_e(1)))/2;
r = (t_max-t_min)*v_average/pi;
delt_t = t(min_e(1))-t(max_e(1));
theta = v_average*delt_t/r/2;
d = r/cos(theta);





