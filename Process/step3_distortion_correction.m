function a = step3_distortion_correction(s)
% function a = step3_distortion_correction(s)

a = [];
ap = '../data/raw';
tp = '../data/processed';
zp = '../data/interim';

if (nargin == 0)
    clc;
    mdm_iter_lund(ap, @step3_distortion_correction);
    return;
end

if (~strcmp(s.modality_name, 'NII')), return; end
if (~strcmp(s.subject_name, 'BoF127_MMI_107')), return; end

opt = mdm_opt;
opt.do_overwrite = 1;
opt.verbose      = 1; 
opt = fsl_opt(opt);

% ip - input path, op - output path, wp - interim path
ip = fullfile(ap, s.subject_name, s.exam_name, s.modality_name);
op = fullfile(tp, s.subject_name, s.exam_name, 'Diff/ver3', 'Serie_01_FWF');
wp = fullfile(zp, s.subject_name, s.exam_name, 'Diff/ver3', 'Serie_01_FWF');
msf_mkdir(op); msf_mkdir(wp);
  

s_pa = mdm_s_from_nii(msf_find_fn(ip, {'*STE_PA.nii*', '*STE_CFC_PA_v2.nii.gz'}),0);
s_ap = mdm_s_from_nii(msf_find_fn(fullfile(tp, ...
    s.subject_name, s.exam_name, 'Diff/ver2', 'Serie_01_FWF'), ...
    'FWF_mc.nii*'));

% select the low b-acquisition
topup_fn = fullfile(op, 'FWF_topup.nii.gz');

s_corr = mdm_s_topup(s_ap, s_pa, wp, topup_fn, opt);
s_corr_pa = mdm_s_powder_average(s_corr, op, opt);

a = s_corr_pa;







