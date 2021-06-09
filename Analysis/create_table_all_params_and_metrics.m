clear; clf; clc;
addpath(genpath('A_functions'));
labels;
load('../data/data_in_vivo_whole_tu.mat')
% load('../data/data_in_vivo_mki_rim.mat')

metric{1} = @(x) prctile(x,10);
metric{2} = @(x) prctile(x,25);
metric{3} = @(x) prctile(x,50);
metric{4} = @(x) prctile(x,75);
metric{5} = @(x) prctile(x,90);
metric{6} = @(x) var(x);

for c_con = 1:3
    for m_exp = 1:numel(metric)
        for c_exp = 1:numel(dat_in_vivo)
            
            param{c_con}{1}{m_exp}(c_exp) = metric{m_exp}(dat_in_vivo(c_exp).T1.T1_in_ROI);
            param{c_con}{2}{m_exp}(c_exp) = metric{m_exp}(dat_in_vivo(c_exp).T2.T2_in_ROI);
            param{c_con}{3}{m_exp}(c_exp) = metric{m_exp}(dat_in_vivo(c_exp).S0.S0_in_ROI);
            param{c_con}{4}{m_exp}(c_exp) = metric{m_exp}(dat_in_vivo(c_exp).MD.MD_in_ROI);
            param{c_con}{5}{m_exp}(c_exp) = metric{m_exp}(dat_in_vivo(c_exp).FA.FA_in_ROI);
            param{c_con}{6}{m_exp}(c_exp) = metric{m_exp}(dat_in_vivo(c_exp).uFA.uFA_in_ROI);
            param{c_con}{7}{m_exp}(c_exp) = metric{m_exp}(dat_in_vivo(c_exp).Mkt.Mkt_in_ROI);
            param{c_con}{8}{m_exp}(c_exp) = metric{m_exp}(dat_in_vivo(c_exp).Mka.Mka_in_ROI);
            param{c_con}{9}{m_exp}(c_exp) = metric{m_exp}(dat_in_vivo(c_exp).Mki.Mki_in_ROI);
            
            if c_con == 1
                x_vals{c_con}{m_exp}(c_exp) = dat_in_vivo(c_exp).h.consistency_no;
            elseif c_con == 2
                x_vals{c_con}{m_exp}(c_exp) = dat_in_vivo(c_exp).h.type_no;
            elseif c_con == 3
                x_vals{c_con}{m_exp}(c_exp) = dat_in_vivo(c_exp).h.grade_no;
            end
            
        end
    end
end

c_con = 1;
for m_exp = 1:numel(metric)
    for c_exp = 1:numel(param{1})
        pc{c_exp}{m_exp}{1} = median(param{c_con}{c_exp}{m_exp}(x_vals{c_con}{m_exp} == 1));
        pc{c_exp}{m_exp}{2} = median(param{c_con}{c_exp}{m_exp}(x_vals{c_con}{m_exp} == 2));
        pc{c_exp}{m_exp}{3} = median(param{c_con}{c_exp}{m_exp}(x_vals{c_con}{m_exp} == 3));
    end
end

c_con = 2;
for m_exp = 1:numel(metric)
    for c_exp = 1:numel(param{1})
        pt{c_exp}{m_exp}{1} = median(param{c_con}{c_exp}{m_exp}(x_vals{c_con}{m_exp} == 1));
        pt{c_exp}{m_exp}{2} = median(param{c_con}{c_exp}{m_exp}(x_vals{c_con}{m_exp} == 2));
        pt{c_exp}{m_exp}{3} = median(param{c_con}{c_exp}{m_exp}(x_vals{c_con}{m_exp} == 3));
        pt{c_exp}{m_exp}{4} = median(param{c_con}{c_exp}{m_exp}(x_vals{c_con}{m_exp} == 4));
        pt{c_exp}{m_exp}{5} = median(param{c_con}{c_exp}{m_exp}(x_vals{c_con}{m_exp} == 5));
        pt{c_exp}{m_exp}{6} = median(param{c_con}{c_exp}{m_exp}(x_vals{c_con}{m_exp} == 6));
        pt{c_exp}{m_exp}{7} = median(param{c_con}{c_exp}{m_exp}(x_vals{c_con}{m_exp} == 7));
    end
end

c_con = 3;
for m_exp = 1:numel(metric)
    for c_exp = 1:numel(param{1})
        pg{c_exp}{m_exp}{1} = median(param{c_con}{c_exp}{m_exp}(x_vals{c_con}{m_exp} == 1));
        pg{c_exp}{m_exp}{2} = median(param{c_con}{c_exp}{m_exp}(x_vals{c_con}{m_exp} == 2));
    end
end






%consistency
p=[];
for c_exp = 1:numel(param{1})
    for m_exp = 1:numel(metric)
        a  = cell2mat(pc{c_exp}{m_exp});
        p = cat(2,p,a);
    end
end

p = reshape(p,[numel(pc{1}{1})*numel(metric),numel(param{1})]);
p = p';

a = {' 10' ' 25' ' 50' ' 75' ' 90' ' var'};
y_label = [];
for m_exp = 1:numel(metric)
    y_label = cat(2,y_label,{strcat('soft ',a{m_exp}),strcat('var ',a{m_exp}),strcat('stiff ',a{m_exp})});
end
x_label = {'T1' 'T2','S0','MD','FA','uFA','MK','MKA','MKI'};
T = array2table(p,'VariableNames',y_label,'RowNames',x_label);
writetable(T,'test.xlsx','Sheet',1,'WriteRowNames',1);


%type
p=[];
for c_exp = 1:numel(param{1})
    for m_exp = 1:numel(metric)
        a  = cell2mat(pt{c_exp}{m_exp});
        p = cat(2,p,a);
    end
end

p = reshape(p,[numel(pt{1}{1})*numel(metric),numel(param{1})]);
p = p';

a = {' 10' ' 25' ' 50' ' 75' ' 90' ' var'};
y_label = [];
for m_exp = 1:numel(metric)
    y_label = cat(2,y_label,{strcat('1 ',a{m_exp}),strcat('2 ',a{m_exp}),strcat('3 ',a{m_exp}), strcat('4 ',a{m_exp}), strcat('5 ',a{m_exp}),strcat('6 ',a{m_exp}), strcat('7 ',a{m_exp})});
end
x_label = {'T1' 'T2','S0','MD','FA','uFA','MK','MKA','MKI'};
T = array2table(p,'VariableNames',y_label,'RowNames',x_label);
writetable(T,'test.xlsx','Sheet',2,'WriteRowNames',1);

%grade
p=[];
for c_exp = 1:numel(param{1})
    for m_exp = 1:numel(metric)
        a  = cell2mat(pg{c_exp}{m_exp});
        p = cat(2,p,a);
    end
end

p = reshape(p,[numel(pg{1}{1})*numel(metric),numel(param{1})]);
p = p';

a = {' 10' ' 25' ' 50' ' 75' ' 90' ' var'};
y_label = [];
for m_exp = 1:numel(metric)
    y_label = cat(2,y_label,{strcat('WHO I ',a{m_exp}),strcat('WHO II ',a{m_exp})});
end
x_label = {'T1' 'T2','S0','MD','FA','uFA','MK','MKA','MKI'};
T = array2table(p,'VariableNames',y_label,'RowNames',x_label);
writetable(T,'test.xlsx','Sheet',3,'WriteRowNames',1);









