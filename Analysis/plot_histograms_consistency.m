clear; clf; clc;
addpath(genpath('A_functions'));
labels;
load('../data/data_in_vivo_whole_tu.mat')
% load('../data/data_in_vivo_mki_rim.mat')

p1 = []; p2 = []; p3 = [];
for c_exp = 1:numel(dat_in_vivo)
    
    x_vals(c_exp) = dat_in_vivo(c_exp).h.consistency_no;
    
    par = dat_in_vivo(c_exp).MD.MD_in_ROI;
%     par = dat_in_vivo(c_exp).FA.FA_in_ROI;
%     par = dat_in_vivo(c_exp).Mkt.Mkt_in_ROI;
    
    if x_vals(c_exp) == 1
        p1 = cat(1,p1,par);
    elseif x_vals(c_exp) == 2
        p2 = cat(1,p2,par);
    elseif x_vals(c_exp) == 3
        p3 = cat(1,p3,par);
    end
    
end

xl = 2;
bo = 30;
lw = 2;
col = 100;
o = 4;

hold on
histogram(p3,bo,'Normalization','probability','Facecolor',colors{o-3})
histogram(p1,bo,'Normalization','probability','Facecolor',colors{o-1})
histogram(p2,bo,'Normalization','probability','Facecolor',colors{o-2})

xlim([0 xl])
ax = gca;
ax.FontSize = 20;
ax.TickLength = [0.01 0.01];
set(gca,'linewidth',lw)
set(gca,'tickdir','out');
yticks([0])
yticklabels({''})
