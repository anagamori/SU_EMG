close all

[file, path, filterindex] = uigetfile('*.rhd', 'Select an RHD2000 Data File', 'MultiSelect', 'off');
[t_amplifier, amplifier_data, board_dig_in_data, frequency_parameters] = read_Intan_RHD2000_file_nongui(file, path);

Fs = 20000;

lpFilt = designfilt('lowpassiir','FilterOrder',4, ...
    'PassbandFrequency',10000,'PassbandRipple',0.2, ...
    'SampleRate',Fs);

hpFilt = designfilt('highpassiir','FilterOrder',4, ...
    'PassbandFrequency',350,'PassbandRipple',0.2, ...
    'SampleRate',Fs);

data = amplifier_data;
data_filt = zeros(size(data));

idx = 1;
idx2 = 1;
idx3 = 1;
idx4 = 1;
time = [1:size(data,2)]./Fs;

for i = 1:32
    
    data_filt(i,:) = filtfilt(lpFilt,data(i,:));
    data_filt(i,:) = filtfilt(hpFilt,data_filt(i,:));
    
    
end

ref_signal = mean(data_filt);

for i = 1:32
    if i <= 8
        figure(1)
        ax{i} = subplot(8,1,idx);
        plot(time,data_filt(i,:)-data_filt(1,:),'color','k','LineWidth',1)
        idx = idx+1;
        ylim([-1000 1000])
    elseif i > 8 && i <=16
        figure(2)
        ax{i} = subplot(8,1,idx2);
        plot(time,data_filt(i,:)-data_filt(9,:),'color','k','LineWidth',1)
        idx2 = idx2+1;
        ylim([-1000 1000])
    elseif i > 16 && i <=24
        figure(3)
        ax{i} = subplot(8,1,idx3);
        plot(time,data_filt(i,:)-data_filt(17,:),'color','k','LineWidth',1)
        idx3 = idx3+1;
        ylim([-1000 1000])
    elseif i > 24 && i <=32
        figure(4)
        ax{i} = subplot(8,1,idx4);
        plot(time,data_filt(i,:)-data_filt(25,:),'color','k','LineWidth',1)
        idx4 = idx4+1;
        ylim([-5000 5000])
    end
end
figure(1)
sgtitle('Shank B')
figure(2)
sgtitle('Shank C')
figure(3)
sgtitle('Shank D')
figure(4)
sgtitle('Shank A')

linkaxes([ax{1:8}],'xy')
linkaxes([ax{9:16}],'xy')
linkaxes([ax{17:24}],'xy')
linkaxes([ax{25:32}],'xy')

