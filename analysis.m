
Fs = 20000;

lpFilt = designfilt('lowpassiir','FilterOrder',4, ...
    'PassbandFrequency',10000,'PassbandRipple',0.2, ...
    'SampleRate',Fs);

hpFilt = designfilt('highpassiir','FilterOrder',4, ...
    'PassbandFrequency',1000,'PassbandRipple',0.2, ...
    'SampleRate',Fs);


ch1 = amplifier_data(22,:);
ch2 = amplifier_data(23,:);


ch1_filt = filtfilt(lpFilt,ch1);
ch2_filt = filtfilt(lpFilt,ch2);

ch1_filt = filtfilt(hpFilt,ch1_filt);
ch2_filt = filtfilt(hpFilt,ch2_filt);

figure(1)
plot(ch1_filt)
