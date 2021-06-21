function a = step2_motion_and_eddy_current_correction(s)
% function a = step2_motion_and_eddy_current_correction(s)

a = [];
ap = '../data/raw';
tp = '../data/processed';

if (nargin == 0)
    mdm_iter_lund(ap, @step2_motion_and_eddy_current_correction);
    return;
end

if (~strcmp(s.modality_name, 'NII')), return; end
    
% set options
opt = mdm_opt;
opt.do_overwrite = 1; 
opt.verbose      = 1;

% set paths
ip = fullfile(ap, s.subject_name, s.exam_name, s.modality_name);
op = fullfile(tp, s.subject_name, s.exam_name, 'Diff/ver2', 'Serie_01_FWF');
msf_mkdir(op); msf_mkdir(ip);

% connect to data and merge it
s_lte = mdm_s_from_nii(msf_find_fn(ip, {'*LTE.nii*', '*LTE_v2.nii.gz'}), 1);
s_ste = mdm_s_from_nii(msf_find_fn(ip, {'*STE.nii*', '*STE_CFC_v2.nii.gz'}), 0);

% fix a issues with gradient tables for two specific patients
if (strcmp(s.subject_name(end-2:end), '106')) % case 1
    s_lte.xps = s_ste.xps;
    s_lte.xps.b_delta = ones(size(s_lte.xps.b_delta));
    s_lte.xps.bt = tm_1x3_to_1x6(s_lte.xps.b, 0, s_lte.xps.u);
end

if (strcmp(s.subject_name(end-2:end), '114')) % case 2
    s_ste.xps.b(end-3:end-1) = [0.1 2.0 2.0] * 1e9;
    s_ste.xps.u( (end-3):(end-1), 1 ) = 1;
end

s = mdm_s_merge({s_lte, s_ste}, op, 'FWF', opt);

% motion correction of reference
p_fn = elastix_p_write(elastix_p_affine(200), fullfile(op, 'p.txt'));

s_lowb = mdm_s_subsample(s_lte, s_lte.xps.b < 1.1e9, op, opt);
s_mec  = mdm_mec_b0(s_lowb, p_fn, op, opt);

% extrapolation-based motion correction
s_mc = mdm_mec_eb(s, s_mec, p_fn, op, opt);

% powder average
s_pa = mdm_s_powder_average(s_mc, op, opt);







