clear; clf; clc;
addpath(genpath('A_functions'));
labels;
% load('../data/data_in_vivo_whole_tu.mat')
load('../data/data_in_vivo_mki_rim.mat')


%         fn = @(x) prctile(x,50);
fn = @(x) std(x);

for c_exp = 1:numel(dat_in_vivo)
    
    param{1}(c_exp) = fn(dat_in_vivo(c_exp).S0.S0_in_ROI);
    param{2}(c_exp) = fn(dat_in_vivo(c_exp).MD.MD_in_ROI);
    param{3}(c_exp) = fn(dat_in_vivo(c_exp).Mkt.Mkt_in_ROI);
    param{4}(c_exp) = fn(dat_in_vivo(c_exp).FA.FA_in_ROI);
    param{5}(c_exp) = fn(dat_in_vivo(c_exp).Mka.Mka_in_ROI);
    param{6}(c_exp) = fn(dat_in_vivo(c_exp).Mki.Mki_in_ROI);
    
    x_vals(c_exp) = dat_in_vivo(c_exp).h.grade_no;
end

n_samples = length(x_vals);
x_pos = unique(x_vals); %contains how many types we have

ha = tight_subplot(1,6,[.1,.03],[.12,.08],[.1,.02]);

for c_exp = 1:6
    
    axes(ha(c_exp));
    hold on;
    
    if (1)
        o = 17;
        
        plotSpread({param{c_exp}(x_vals == 1), param{c_exp}(x_vals == 2)},...
            'xNames',{'1','2'},...
            'spreadWidth',0.5,'distributionColors',{colors{o-1},colors{o-2}})
        
        hold on
        line([0.7 1.3],[median(param{c_exp}(x_vals == 1)) median(param{c_exp}(x_vals == 1))],'Linewidth',4,'Color','red')
        line([1.7 2.3],[median(param{c_exp}(x_vals == 2)) median(param{c_exp}(x_vals == 2))],'Linewidth',4,'Color','red')
        
    end
    
    ylim([0 1.5])
    xlim([0.5 2.5])
    
    ax1pos = get(gca,'position');
    
    hold on;
    xticks(x_pos)
    
    if c_exp == 1
        ylim([0 200])
        yticks([0 100 200])
        y_labels = {'0' '100' '200'};
    end
    if c_exp == 2
        ylim([0 0.5])
        yticks([0 0.25 0.5])
        y_labels = {'0' '0.25' '0.5'};
    end
    if c_exp == 3
        ylim([0 0.5])
        yticks([0 0.25 0.5])
        y_labels = {'0' '0.25' '0.5'};
    end
    if c_exp == 4
        ylim([0 0.5])
        yticks([0 0.25 0.5])
        y_labels = {'0' '0.25' '0.5'};
    end
    if c_exp == 5
        ylim([0 0.5])
        yticks([0 0.25 0.5])
        y_labels = {'0' '0.25' '0.5'};
    end
    if c_exp == 6
        ylim([0 0.5])
        yticks([0 0.25 0.5])
        y_labels = {'0' '0.25' '0.5'};
    end
    
    set(ha(c_exp),'XTickLabel',grade_label);
    set(ha(c_exp),'YTickLabel',y_labels)
    
    
    ax = gca;
    ax.FontSize = 20;
    ax.TickLength = [0.01 0.01];
    set(gca,'linewidth',3)
    set(gca,'tickdir','out');
    box off
    
    %Check significance
    [p,h] = ranksum(param{c_exp}(x_vals == 1),param{c_exp}(x_vals == 2))
    
    
end