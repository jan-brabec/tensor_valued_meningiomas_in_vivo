clear all

global iter_no dat_in_vivo

% load('../../Analysis/data_in_ex_vivo')

iter_no = 1;
dat_in_vivo = step8_get_vals_from_ROI();

histo_source;
type_label = {"Fibroblastic","Meningothelial","Transitional" "Clear-cell" "Microcystic/Angiomatous", "Chordoid", "Psammomatous"}';
grade_label = {"WHO I", "WHO II"}';
vascularity_label = {"Avascular" "Between" "Vascularized" "N/A"}';
fibrotic_label = {"Without" "Fibrotic parts" "N/A"}';
consistency_label = {"Soft", "Variable","Hard","N/A"}';

for c_exp = 1:numel(dat_in_vivo)
    dat_in_vivo(c_exp).h.type = types{c_exp,1};
    dat_in_vivo(c_exp).h.consistency = types{c_exp,2};
    dat_in_vivo(c_exp).h.grade = types{c_exp,3};
    dat_in_vivo(c_exp).h.vascularized = types{c_exp,4};
    dat_in_vivo(c_exp).h.fibrotic_parts = types{c_exp,5};
    
    for j = 1:size(type_label,1) %number types
        if dat_in_vivo(c_exp).h.type == type_label{j}
            dat_in_vivo(c_exp).h.type_no = j;
        end
    end
    
    for j = 1:size(consistency_label,1) %number types
        if dat_in_vivo(c_exp).h.consistency == consistency_label{j}
            dat_in_vivo(c_exp).h.consistency_no = j;
        end
    end
    
    for j = 1:size(grade_label,1) %number grades
        if dat_in_vivo(c_exp).h.grade == grade_label{j}
            dat_in_vivo(c_exp).h.grade_no = j;
        end
    end    
end


clearvars -except dat_in_vivo data_ex_vivo
% save('../../Analysis/data_in_ex_vivo')
save('../../Analysis/data_in_vivo_rim')

