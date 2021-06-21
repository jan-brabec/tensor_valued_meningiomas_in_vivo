clear; clf; clc;
addpath(genpath('A_functions'));
labels;
load('../data/data_in_vivo_whole_tu.mat')
% load('../data/data_in_vivo_mki_rim.mat')


fn = @(x) prctile(x,10);
% fn = @(x) std(x);

for c_exp = 1:numel(dat_in_vivo)
    
    param{1}(c_exp) = fn(dat_in_vivo(c_exp).S0.S0_in_ROI);
    param{2}(c_exp) = fn(dat_in_vivo(c_exp).MD.MD_in_ROI);
    param{3}(c_exp) = fn(dat_in_vivo(c_exp).FA.FA_in_ROI);
    param{4}(c_exp) = fn(dat_in_vivo(c_exp).Mkt.Mkt_in_ROI);
    param{5}(c_exp) = fn(dat_in_vivo(c_exp).Mka.Mka_in_ROI);
    param{6}(c_exp) = fn(dat_in_vivo(c_exp).Mki.Mki_in_ROI);
    
    x_vals(c_exp) = dat_in_vivo(c_exp).h.consistency_no;
    
end

% % % x_vals(2) = 100; %variable
% % % x_vals(14) = 100; %stiff

n_samples = length(x_vals);
x_pos = unique(x_vals); %contains how many types we have

ha = tight_subplot(1,6,[.1,.03],[.12,.08],[.1,.02]);
for c_exp = 1:numel(param)
    
    axes(ha(c_exp));
    hold on;
    o = 4;
    
    hold on
    
    plotSpread({param{c_exp}(x_vals == 1), param{c_exp}(x_vals == 2), param{c_exp}(x_vals == 3)},...
        'xNames',{'1','2','3'},...
        'spreadWidth',0.5,'distributionColors',{colors{o-1},colors{o-2},colors{o-3}})
    hold on
    
    % % %        ccc = [252, 189, 64]./255;
    % % %        plot(2,param{c_exp}(2),'.','Markersize',50,'color',ccc);
    % % %        hold on
    % % %        plot(3,param{c_exp}(14),'.','Markersize',50,'color',ccc);
    
    line([0.7 1.3],[median(param{c_exp}(x_vals == 1)) median(param{c_exp}(x_vals == 1))],'Linewidth',4,'Color','red')
    line([1.7 2.3],[median(param{c_exp}(x_vals == 2)) median(param{c_exp}(x_vals == 2))],'Linewidth',4,'Color','red')
    line([2.7 3.3],[median(param{c_exp}(x_vals == 3)) median(param{c_exp}(x_vals == 3))],'Linewidth',4,'Color','red')
    
    xticks(x_pos)
    
    if (1) %if 10th perctile to plot
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
            y_labels = {'0' '0.5' '1'};
        end
        if c_exp == 5
            ylim([0 2])
            yticks([0 1 2])
            y_labels = {'0' '0.5' '1'};
        end
        if c_exp == 6
            ylim([0 0.5])
            yticks([0 0.25 0.5])
            y_labels = {'0' '0.25' '0.5'};
        end
        
    else %if standard deviation to plot
        if c_exp == 1
            ylim([0 200])
            yticks([0 100 200])
            y_labels = {'0' '100' '200'};
        end
        if c_exp == 2
            ylim([0 0.3])
            yticks([0 0.15 0.3])
            y_labels = {'0' '0.15' '0.3'};
        end
        if c_exp == 3
            ylim([0 0.2])
            yticks([0 0.1 0.2])
            y_labels = {'0' '0.1' '0.2'};
        end
        if c_exp == 4
            ylim([0 0.2])
            yticks([0 0.1 0.2])
            y_labels = {'0' '0.1' '0.2'};
        end
        if c_exp == 5
            ylim([0 1])
            yticks([0 0.5 1])
            y_labels = {'0' '0.5' '1'};
        end
        if c_exp == 6
            ylim([0 0.3])
            yticks([0 0.15 0.3])
            y_labels = {'0' '0.15' '0.3'};
        end
    end
    
    set(ha(c_exp),'XTickLabel',{'','',''});
    set(ha(c_exp),'YTickLabel',y_labels)
    
    ax = gca;
    ax.FontSize = 20;
    ax.TickLength = [0.01 0.01];
    set(gca,'linewidth',3)
    set(gca,'tickdir','out');
    xlim([0.5 3.5])
    box off
    
    % Check significance
    [p,h] = ranksum(param{c_exp}(x_vals == 1 | x_vals == 2),param{c_exp}(x_vals == 3))
    %     [p,h] = ranksum(param{c_exp}(x_vals == 1 ),param{c_exp}(x_vals == 3 | x_vals == 2))
    %         [p,h] = ranksum(param{c_exp}(x_vals == 1 | x_vals == 3),param{c_exp}(x_vals == 2))
    
    
    
    
    
    
end