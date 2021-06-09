clear; clf; clc;
addpath(genpath('A_functions'));
labels;
load('../data/data_in_vivo_whole_tu.mat')
% load('../data/data_in_vivo_mki_rim.mat')

fn = @(x) prctile(x,50);

for c_exp = 1:numel(dat_in_vivo)
    if dat_in_vivo(c_exp).h.grade_no > 1
        x_vals(c_exp) = 2;
    else
        x_vals(c_exp) = 3;
    end
    if dat_in_vivo(c_exp).h.type_no == 5
        x_vals(c_exp) = 1;
    end
end

for c_exp = 1:numel(dat_in_vivo)
    
    param{1}(c_exp) = fn(dat_in_vivo(c_exp).S0.S0_in_ROI);
    param{2}(c_exp) = fn(dat_in_vivo(c_exp).MD.MD_in_ROI);
    param{3}(c_exp) = fn(dat_in_vivo(c_exp).Mkt.Mkt_in_ROI);
    param{4}(c_exp) = fn(dat_in_vivo(c_exp).FA.FA_in_ROI);
    param{5}(c_exp) = fn(dat_in_vivo(c_exp).uFA.uFA_in_ROI);
    
end

n_samples = length(x_vals);
x_pos = unique(x_vals); %contains how many types we have

ha = tight_subplot(1,5,[.1,.03],[.12,.08],[.1,.02]);

for c_exp = 1:5
    
    axes(ha(c_exp));
    
    o = 21;
    
    hold on;
    plot(x_vals(x_vals == 1),param{c_exp}(x_vals == 1),'.','Markersize',60,'Color',colors{o-1})    
    plot(x_vals(x_vals == 2),param{c_exp}(x_vals == 2),'.','Markersize',60,'Color',colors{o-2})
    
    bp = boxplot(param{c_exp},x_vals,'BoxStyle','outline');
    a = get(get(gca,'children'),'children');   % Get the handles of all the objects
    a = a{1};
    t = get(a,'tag');   % List the names of all the objects
    for i=1:length(x_pos)-1
        
        if (1)
            colorb{i} = 'white';
        else
            colorb = colors;
        end
        
        for op = 1:3
            a(op).LineStyle = 'none';
            a(op).Marker = 'none';
        end
        for op = 7:numel(a)
            a(op).LineStyle = 'none';
            a(op).Marker = 'none';
        end
    end
    
    set(bp,'linew',5)
    
    ylim([0 1.5])
    xlim([0.5 2.5])
    
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
        ylim([0 2])
        yticks([0 1 2])
        y_labels = {'0' '1' '2'};
    end
    if c_exp == 4
        ylim([0 1])
        yticks([0 0.5 1])
        y_labels = {'0' '0.5' '1'};
    end
    if c_exp == 5
        ylim([0 1])
        yticks([0 0.5 1])
        y_labels = {'0' '0.5' '1'};
    end
    
    set(ha(c_exp),'YTickLabel',y_labels)
    ax = gca;
    ax.FontSize = 20;
    ax.TickLength = [0.01 0.01];
    set(gca,'linewidth',3)
    set(gca,'tickdir','out');
    
    box off
    
    % Check siginifacnce
    [p,h] = ranksum(param{c_exp}(x_vals == 1),param{c_exp}(x_vals == 2))
    
end