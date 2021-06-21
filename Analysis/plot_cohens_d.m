clear; clf; clc;
addpath(genpath('A_functions'));
labels;
load('../data/data_in_vivo_whole_tu.mat')
% load('../data/data_in_vivo_mki_rim.mat')

lw = 2;


c_c = mean([colors{4-1};colors{4-2};colors{4-3}],1);
c_t = mean([colors{17-7}; colors{17-4}],1);
c_g = mean([colors{17-1};colors{17-1}],1);

d_c = [0.5606    0.5301    0.5000    0.4720    0.4909    0.4496];
d_t = [0.6470    0.6781    0.7058    0.6949    0.6428    0.5136];
d_g = [0.4355    0.4034    0.3293    0.2915    0.2297    0.3639];

plot(d_c,'Color',c_c,'Linewidth',4)
hold on
plot(d_t,'Color',c_t,'Linewidth',4)
hold on
plot(d_g,'Color',c_g,'Linewidth',4)


ax = gca;
ax.FontSize = 20;
ax.TickLength = [0.01 0.01];
set(gca,'linewidth',lw)
set(gca,'tickdir','out');
% yticks([0])
% yticklabels({''})

xticks([1 2 3 4 5 6])
xticklabels({'','','','','',''})
ylim([0 0.8])
xlim([0 7])