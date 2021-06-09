clear; clf; clc;
load('../data/data_in_vivo_whole_tu.mat')

for c_exp = 1:numel(dat_in_vivo)
    grade(c_exp) = dat_in_vivo(c_exp).h.grade_no;
end

%case      1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30
edema   = [0  1  1  1  0  0  0  1  1  0  1  0  1  0  1  0  1  0  0  0  1  0  0  1  0  1  0  1  1  1];
MKI_rim = [0  1  1  1  1  1  0  0  1  0  1  1  0  1  0  1  1  0  1  1  1  0  1  0  0  0  0  1  0  0];
 

% Test to get grade II
% test = edema == 1;
% test = MKI_rim == 1;
test = edema == 1 | MKI_rim == 1;

TP = [sum(grade == 2 & test == 1)];
TN = [sum(grade == 1 & test == 0)]; 
FP = [sum(grade == 1 & test == 1)];
FN = [sum(grade == 2 & test == 0)];

SENS = TP ./ (TP + FN) .* 100
SPEC = TN ./ (TN + FP) .* 100
PPV  = TP ./ (TP + FP) .* 100
NPV  = TN ./ (TN + FN) .* 100