clear; clf; clc;
addpath(genpath('A_functions'));
labels;
load('../data/data_in_vivo_whole_tu.mat')
% load('../data/data_in_vivo_mki_rim.mat')

fn = @(x) prctile(x,50);

for c_exp = 1:numel(dat_in_vivo)
    
    param{1}(c_exp) = fn(dat_in_vivo(c_exp).S0.S0_in_ROI);
    param{2}(c_exp) = fn(dat_in_vivo(c_exp).MD.MD_in_ROI);
    param{3}(c_exp) = fn(dat_in_vivo(c_exp).FA.FA_in_ROI);
    param{4}(c_exp) = fn(dat_in_vivo(c_exp).Mkt.Mkt_in_ROI);
    param{5}(c_exp) = fn(dat_in_vivo(c_exp).Mka.Mka_in_ROI);
    param{6}(c_exp) = fn(dat_in_vivo(c_exp).Mki.Mki_in_ROI);
    
    x_vals(c_exp) = dat_in_vivo(c_exp).h.type_no;
    x_vals_pos(c_exp) = c_exp;
    cons(c_exp) = dat_in_vivo(c_exp).h.consistency_no;
    
end

% % % x_vals(12) = 100;
% % % x_vals(14) = 100;
% % % x_vals(15) = 100;

n_samples = length(x_vals);
x_pos = unique(x_vals); %contains how many types we have

ha = tight_subplot(1,6,[.1,.03],[.12,.08],[.1,.02]);

for c_exp = 1:numel(param)
    
    axes(ha(c_exp));
    hold on;
    
    o = 17;
    plotSpread({param{c_exp}(x_vals == 1), param{c_exp}(x_vals == 2), param{c_exp}(x_vals == 3),...
        param{c_exp}(x_vals == 4),param{c_exp}(x_vals == 5),param{c_exp}(x_vals == 6),param{c_exp}(x_vals == 7)},...
        'xNames',{'1','2','3','4','5','6','7'},...
        'spreadWidth',0.5,'distributionColors',{colors{o-1},colors{o-2},colors{o-3},colors{o-4},colors{o-5},colors{o-6},colors{o-7}})
    
    hold on;
    
% % %     
% % %     ccc = [252, 189, 64]./255;
% % %     plot(1,param{c_exp}(12),'.','Markersize',50,'color',ccc);
% % %     hold on
% % %     plot(5,param{c_exp}(14),'.','Markersize',50,'color',ccc);
% % %     plot(7,param{c_exp}(15),'.','Markersize',50,'color',ccc);
    
    %     for i = 1:numel(x_vals_pos)
    %         if dat_in_vivo(i).h.consistency_no == 3
    %             hold on
    %             plot(x_vals(x_vals_pos(i)),param{c_exp}(x_vals_pos(i)),'.','Markersize',60,'Color',[0.9856 0.7372 0.2537])
    %         end
    %     end
    
    line([0.7 1.3],[median(param{c_exp}(x_vals == 1)) median(param{c_exp}(x_vals == 1))],'Linewidth',4,'Color','red')
    line([1.7 2.3],[median(param{c_exp}(x_vals == 2)) median(param{c_exp}(x_vals == 2))],'Linewidth',4,'Color','red')
    line([2.7 3.3],[median(param{c_exp}(x_vals == 3)) median(param{c_exp}(x_vals == 3))],'Linewidth',4,'Color','red')
    line([3.7 4.3],[median(param{c_exp}(x_vals == 4)) median(param{c_exp}(x_vals == 4))],'Linewidth',4,'Color','red')
    line([4.7 5.3],[median(param{c_exp}(x_vals == 5)) median(param{c_exp}(x_vals == 5))],'Linewidth',4,'Color','red')
    line([5.7 6.3],[median(param{c_exp}(x_vals == 6)) median(param{c_exp}(x_vals == 6))],'Linewidth',4,'Color','red')
    line([6.7 7.3],[median(param{c_exp}(x_vals == 7)) median(param{c_exp}(x_vals == 7))],'Linewidth',4,'Color','red')
    
    ylim([0 1.5])
    xlim([0.5 7.5])
    
    ax1pos = get(gca,'position');

    hold on;
    xticks(x_pos)
    
    if c_exp == 1
        ylim([0 800])
        yticks([0 400 800])
        y_labels = {'0' '400' '800'};
    end
    if c_exp == 2
        ylim([0 2])
        yticks([0 1 2])
        y_labels = {'0' '1' '2'};
    end
    if c_exp == 3
        ylim([0 1])
        yticks([0 0.5 1])
        y_labels = {'0' '0.5' '1'};
    end
    if c_exp == 4
        ylim([0 2])
        yticks([0 1 2])
        y_labels = {'0' '1' '2'};
    end
    if c_exp == 5
        ylim([0 2])
        yticks([0 1 2])
        y_labels = {'0' '1' '2'};
    end
    if c_exp == 6
        ylim([0 0.5])
        yticks([0 0.25 0.5])
        y_labels = {'0' '0.25' '0.5'};
    end
    
    
       set(ha(c_exp),'YTickLabel',y_labels)
    
    
    
    hold on
    
    ax = gca;
    ax.FontSize = 20;
    ax.TickLength = [0.01 0.01];
    set(gca,'linewidth',3)
    set(gca,'tickdir','out');
    
    box off
    
    % Check significance
    [p,h] = ranksum(param{c_exp}(x_vals ~= 7),param{c_exp}(x_vals == 7))
    
end

