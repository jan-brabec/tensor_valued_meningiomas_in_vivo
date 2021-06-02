clear; clf; clc;
addpath(genpath('A_functions'));
labels;
load('../data/data_in_vivo_whole_tu.mat')
% load('../data/data_in_vivo_mki_rim.mat')

fn = @(x) prctile(x,50); %choose
%     fn = @(x) std(x);

for c_exp = 1:numel(dat_in_vivo)

    param{1}(c_exp) = fn(dat_in_vivo(c_exp).Mka.Mka_in_ROI);
    param{2}(c_exp) = fn(dat_in_vivo(c_exp).Mki.Mki_in_ROI);
    param{3}(c_exp) = fn(dat_in_vivo(c_exp).Mkt.Mkt_in_ROI);
    param{4}(c_exp) = fn(dat_in_vivo(c_exp).MD.MD_in_ROI);
    param{5}(c_exp) = fn(dat_in_vivo(c_exp).FA.FA_in_ROI);
    param{6}(c_exp) = fn(dat_in_vivo(c_exp).uFA.uFA_in_ROI);
    param{7}(c_exp) = fn(dat_in_vivo(c_exp).S0.S0_in_ROI);
    
    %         x_vals(c_exp) = dat_in_vivo(c_exp).h.consistency_no; %consistency
            x_vals(c_exp) = dat_in_vivo(c_exp).h.type_no; %type
%     x_vals(c_exp) = dat_in_vivo(c_exp).h.grade_no; %grade
    
%     for c_exp = 1:numel(dat_in_vivo) %microcystic vs atypical
%         if dat_in_vivo(c_exp).h.grade_no > 1
%             x_vals(c_exp) = 2;
%         else
%             x_vals(c_exp) = 3;
%         end
%         
%         if dat_in_vivo(c_exp).h.type_no == 5
%             x_vals(c_exp) = 1;
%         end
%     end
    
end

title_text = {'MKA' 'MKI','MKT','MD','FA','uFA','S0'};
ind = [];

for i=1:size(param,2)
    param{i}(ind) = [];
end
x_vals(ind) = [];

n_samples = length(x_vals);
x_pos = unique(x_vals); %contains how many types we have

ha = tight_subplot(4,3,[.03,.01],[.12,.08],[.1,.02]);

for c_exp = 1:7
    
    axes(ha(c_exp));
    hold on
    
    bp = boxplot(param{c_exp},x_vals,'BoxStyle','outline');
    a = get(get(gca,'children'),'children');   % Get the handles of all the objects
    
    
    
    set(bp,'linew',5)
    %     ylim([0 1.5])
    yticks([0 1])
    yticklabels({'0','1'})
    
    if (0)
        
        xlim([0.5 3.5])
        
    end
    
    hold on
    plot(x_vals,param{c_exp},'.','Markersize',40,'Color','black')
    
    ax = gca;
    ax.FontSize = 20;
    ax.FontWeight = 'bold';
    ax.TickLength = [0.01 0.01];
    
    set(gca,'linewidth',3)
    set(gca,'tickdir','out');
    box off
    
    
    if (0) %consistency
        [p{1}(c_exp),h{1}(c_exp)] = ranksum(param{c_exp}(x_vals == 1),param{c_exp}(x_vals == 2 | x_vals == 3));
        [p{2}(c_exp),h{2}(c_exp)] = ranksum(param{c_exp}(x_vals == 2),param{c_exp}(x_vals == 1 | x_vals == 3));
        [p{3}(c_exp),h{3}(c_exp)] = ranksum(param{c_exp}(x_vals == 3),param{c_exp}(x_vals == 1 | x_vals == 2));
    end
    if (1) %type
        [p{1}(c_exp),h{1}(c_exp)] = ranksum(param{c_exp}(x_vals == 1),param{c_exp}(x_vals ~= 1));
        [p{2}(c_exp),h{2}(c_exp)] = ranksum(param{c_exp}(x_vals == 2),param{c_exp}(x_vals ~= 2));
        [p{3}(c_exp),h{3}(c_exp)] = ranksum(param{c_exp}(x_vals == 3),param{c_exp}(x_vals ~= 3));
        [p{4}(c_exp),h{4}(c_exp)] = ranksum(param{c_exp}(x_vals == 4),param{c_exp}(x_vals ~= 4));
        [p{5}(c_exp),h{5}(c_exp)] = ranksum(param{c_exp}(x_vals == 5),param{c_exp}(x_vals ~= 5));
        [p{6}(c_exp),h{6}(c_exp)] = ranksum(param{c_exp}(x_vals == 6),param{c_exp}(x_vals ~= 6));
        [p{7}(c_exp),h{7}(c_exp)] = ranksum(param{c_exp}(x_vals == 7),param{c_exp}(x_vals ~= 7));
    end
    if (0) %microcystic vs atypical and grade
        [p{1}(c_exp),h{1}(c_exp)] = ranksum(param{c_exp}(x_vals == 1),param{c_exp}(x_vals == 2));
    end
    
    title(sprintf('%s, p = %.2f, h = %0.0f',title_text{c_exp},p{1}(c_exp),h{1}(c_exp)))
    
end

for i=1:numel(h)
    h_sum(i) = sum(h{i});
end

disp(h_sum)



