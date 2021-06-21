clear all;
addpath(genpath('A_functions'));
labels; clf; clc;

d_fn{1} = @(x) prctile(x,10);
d_fn{2} = @(x) prctile(x,25);
d_fn{3} = @(x) prctile(x,50);
d_fn{4} = @(x) prctile(x,75);
d_fn{5} = @(x) prctile(x,90);
d_fn{6} = @(x) std(x);

what = 'type';
sh = 1; %what to show in figure titles

if strcmp(what,'grade')
    load('../data/data_in_vivo_mki_rim.mat')
else
    load('../data/data_in_vivo_whole_tu.mat')
end

for c_fn = 1:6
    
    for c_exp = 1:numel(dat_in_vivo)
        
        fn = d_fn{c_fn};
        
        param{1}(c_exp) = fn(dat_in_vivo(c_exp).Mka.Mka_in_ROI);
        param{2}(c_exp) = fn(dat_in_vivo(c_exp).Mki.Mki_in_ROI);
        param{3}(c_exp) = fn(dat_in_vivo(c_exp).Mkt.Mkt_in_ROI);
        param{4}(c_exp) = fn(dat_in_vivo(c_exp).MD.MD_in_ROI);
        param{5}(c_exp) = fn(dat_in_vivo(c_exp).FA.FA_in_ROI);
        param{6}(c_exp) = fn(dat_in_vivo(c_exp).S0.S0_in_ROI);
        
        switch what
            case 'consistency'
                x_vals(c_exp) = dat_in_vivo(c_exp).h.consistency_no;
            case 'type'
                x_vals(c_exp) = dat_in_vivo(c_exp).h.type_no;
            case 'grade'
                x_vals(c_exp) = dat_in_vivo(c_exp).h.grade_no;
            case 'microcyst_atypical'
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
        end
        
    end
    
    title_text = {'MKA' 'MKI','MKT','MD','FA','uFA','S0'};
    
    n_samples = length(x_vals);
    x_pos = unique(x_vals); %contains how many types we have
    
    ha = tight_subplot(4,3,[.03,.01],[.12,.08],[.1,.02]);
    
    for c_exp = 1:6
        
        
        axes(ha(c_exp));
        hold on
        
        bp = boxplot(param{c_exp},x_vals,'BoxStyle','outline');
        a = get(get(gca,'children'),'children');
        
        set(bp,'linew',5)
        
        hold on
        
        plot(x_vals,param{c_exp},'.','Markersize',40,'Color','black')
        
        ax = gca;
        ax.FontSize = 20;
        ax.FontWeight = 'bold';
        ax.TickLength = [0.01 0.01];
        
        set(gca,'linewidth',3)
        set(gca,'tickdir','out');
        box off
        
        
        switch what
            case 'consistency'
                [p{1}(c_exp),h{1}(c_exp)] = ranksum(param{c_exp}(x_vals == 1),param{c_exp}(x_vals == 2 | x_vals == 3));
                [p{2}(c_exp),h{2}(c_exp)] = ranksum(param{c_exp}(x_vals == 2),param{c_exp}(x_vals == 1 | x_vals == 3));
                [p{3}(c_exp),h{3}(c_exp)] = ranksum(param{c_exp}(x_vals == 3),param{c_exp}(x_vals == 1 | x_vals == 2));
                
                d{1}(c_exp) = Cohens_d(param{c_exp}(x_vals == 1),param{c_exp}(x_vals == 2 | x_vals == 3));
                d{2}(c_exp) = Cohens_d(param{c_exp}(x_vals == 2),param{c_exp}(x_vals == 1 | x_vals == 3));
                d{3}(c_exp) = Cohens_d(param{c_exp}(x_vals == 3),param{c_exp}(x_vals == 1 | x_vals == 2));
                
            case 'type'
                [p{1}(c_exp),h{1}(c_exp)] = ranksum(param{c_exp}(x_vals == 1),param{c_exp}(x_vals ~= 1));
                [p{2}(c_exp),h{2}(c_exp)] = ranksum(param{c_exp}(x_vals == 2),param{c_exp}(x_vals ~= 2));
                [p{3}(c_exp),h{3}(c_exp)] = ranksum(param{c_exp}(x_vals == 3),param{c_exp}(x_vals ~= 3));
                [p{4}(c_exp),h{4}(c_exp)] = ranksum(param{c_exp}(x_vals == 4),param{c_exp}(x_vals ~= 4));
                [p{5}(c_exp),h{5}(c_exp)] = ranksum(param{c_exp}(x_vals == 5),param{c_exp}(x_vals ~= 5));
                [p{6}(c_exp),h{6}(c_exp)] = ranksum(param{c_exp}(x_vals == 6),param{c_exp}(x_vals ~= 6));
                [p{7}(c_exp),h{7}(c_exp)] = ranksum(param{c_exp}(x_vals == 7),param{c_exp}(x_vals ~= 7));
                
                d{1}(c_exp) = Cohens_d(param{c_exp}(x_vals == 1),param{c_exp}(x_vals ~= 1));
                d{2}(c_exp) = Cohens_d(param{c_exp}(x_vals == 2),param{c_exp}(x_vals ~= 2));
                d{3}(c_exp) = Cohens_d(param{c_exp}(x_vals == 3),param{c_exp}(x_vals ~= 3));
                d{4}(c_exp) = Cohens_d(param{c_exp}(x_vals == 4),param{c_exp}(x_vals ~= 4));
                d{5}(c_exp) = Cohens_d(param{c_exp}(x_vals == 5),param{c_exp}(x_vals ~= 5));
                d{6}(c_exp) = Cohens_d(param{c_exp}(x_vals == 6),param{c_exp}(x_vals ~= 6));
                d{7}(c_exp) = Cohens_d(param{c_exp}(x_vals == 7),param{c_exp}(x_vals ~= 7));
                
            case 'grade'
                [p{1}(c_exp),h{1}(c_exp)] = ranksum(param{c_exp}(x_vals == 1),param{c_exp}(x_vals == 2));
                d{1}(c_exp) = Cohens_d(param{c_exp}(x_vals == 1),param{c_exp}(x_vals == 2));
                
            case 'microcyst_atypical'
                [p{1}(c_exp),h{1}(c_exp)] = ranksum(param{c_exp}(x_vals == 1),param{c_exp}(x_vals == 2));
                d{1}(c_exp) = Cohens_d(param{c_exp}(x_vals == 1),param{c_exp}(x_vals == 2));
        end
        
        title(sprintf('%s, p = %.2f, h = %0.0f',title_text{c_exp},p{sh}(c_exp),h{sh}(c_exp)))
        
        
    end
    
    disp('Press any key to continue')
    pause
    clf;
    
    for i=1:numel(h)
        h_sum(i) = sum(h{i});
    end
    
    disp(h_sum)
    
    switch what
        case 'consistency'
            all_ds(c_fn) = mean([d{1} d{2} d{3}]);
        case 'type'
            all_ds(c_fn) = mean([d{1} d{2} d{3} d{4} d{5} d{6} d{7}]);
        case 'grade'
            all_ds(c_fn) = mean([d{1}]);
    end
    
end

disp(all_ds)


