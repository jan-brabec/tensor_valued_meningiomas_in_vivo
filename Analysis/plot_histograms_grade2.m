clear; clf; clc;
addpath(genpath('A_functions'));
labels;
% load('../data/data_in_vivo_whole_tu.mat')
load('../data/data_in_vivo_mki_rim.mat')

p1 = []; p2 = [];
for c_exp = 1:numel(dat_in_vivo)
    
    x_vals(c_exp) = dat_in_vivo(c_exp).h.grade_no;
    
    par = dat_in_vivo(c_exp).Mki.Mki_in_ROI;
    
    if x_vals(c_exp) == 1
        p1 = cat(1,p1,par);
    elseif x_vals(c_exp) == 2
        p2 = cat(1,p2,par);
    end
    
end

xl = 1;
bo = 30;
lw = 2;
col = 100;
o = 17;

hold on
[x1,n1] = hist(p1,bo);
[x2,n2] = hist(p2,bo);

x1 = x1 ./ trapz(n1,x1);
x2 = x2 ./ trapz(n2,x2);

sm = 3;
plot(n1,smooth(x1,sm),'Color',colors{o-1},'Linewidth',4)
plot(n2,smooth(x2,sm),'Color',colors{o-2},'Linewidth',4)


xlim([0 xl])
ax = gca;
ax.FontSize = 20;
ax.TickLength = [0.01 0.01];
set(gca,'linewidth',lw)
set(gca,'tickdir','out');
yticks([0])
yticklabels({''})

