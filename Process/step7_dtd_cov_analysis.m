function a = step7_dtd_cov_analysis(s)
% function a = step7_dtd_cov_analysis(s)

a = [];
tp = '../data/processed';
zp = '../data/interim';

if (nargin == 0)
    clc;
    mdm_iter_lund(tp, @step7_dtd_cov_analysis);
    return;
end

if (~strcmp(s.modality_name, 'Diff/ver3')), return; end

disp(s.subject_name)

opt = mdm_opt;
opt.do_overwrite = 1;
opt.mask.do_overwrite = 1;
opt.verbose      = 1;
opt = dtd_covariance_opt(opt);

opt.dtd_covariance.fig_maps = {'s0','MD', 'ad', 'rd', 'FA', 'uFA', 'MKi', 'MKa', 'MKt', 'C_MD', 'C_c', 'C_mu', 'C_M'};

opt.dtd_covariance.do_regularization = 1;
opt.dtd_covariance.do_clamping = 1;
opt.filter_sigma = 0.7;

% op - output path, wp - interim path
op = fullfile(tp, s.subject_name, s.exam_name, 'Diff/ver3', 'Serie_01_FWF');
wp = fullfile(zp, s.subject_name, s.exam_name, 'Diff/ver3', 'Serie_01_FWF');
msf_mkdir(op); msf_mkdir(wp);

% connect to data (use motion and topup corrected merged FWF file)
s = mdm_s_from_nii(fullfile(op, 'FWF_topup.nii.gz'));
s.mask_fn = fullfile(op, 'mask.nii.gz');

dtd_covariance_pipe(s, op, opt);