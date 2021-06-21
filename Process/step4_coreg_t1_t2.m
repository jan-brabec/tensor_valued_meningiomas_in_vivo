function a = step4_coreg_t1_t2(s)
% function a = step4_coreg_t1(s)

a = [];
ap = '../data/raw';
tp = '../data/processed';
zp = '../data/interim';

if (nargin == 0)
    clc; mdm_iter_lund(ap, @step4_coreg_t1_t2); return;
end

if (~strcmp(s.modality_name, 'NII')), return; end

disp(s.subject_name);

opt = mdm_opt;
opt.do_overwrite = 1;
opt.verbose      = 1;

% ip - input path, op - output path, wp - interim path
ip = fullfile(ap, s.subject_name, s.exam_name, s.modality_name);
op = fullfile(tp, s.subject_name, s.exam_name, 'Diff/ver3', 'Serie_01_FWF');
wp = fullfile(zp, s.subject_name, s.exam_name, 'Diff/ver3', 'Serie_01_FWF');
msf_mkdir(op); msf_mkdir(wp);

% coreg t1
i_t1_nii_fn = msf_find_fn(ip, '*mprage*', 0);
o_t1_nii_fn = fullfile(op, 'T1_MPRAGE.nii.gz');

if (~opt.do_overwrite && exist(o_t1_nii_fn, 'file'))
    
    disp('T1 already registered');
    
elseif (~isempty(i_t1_nii_fn))
    s_corr_pa = mdm_s_from_nii(msf_find_fn(op, 'FWF_topup_pa.nii.gz'));
    
    % Use the highest b-value for the registration
    s_tmp = mdm_s_subsample(s_corr_pa, max(1:s_corr_pa.xps.n) == (1:s_corr_pa.xps.n), wp, opt);
    
    % Do rigid body registration
    p_fn   = elastix_p_write(elastix_p_6dof(150), fullfile(wp, 'p_t1_fwf.txt'));
    res_fn = elastix_run_elastix(i_t1_nii_fn, s_tmp.nii_fn, p_fn, wp);
    
    % Save the result
    [I,h] = mdm_nii_read(res_fn);
    mdm_nii_write(I, o_t1_nii_fn, h);
end

% coreg FLAIR
i_flair_nii_fn = msf_find_fn(ip, '*t2_spc*', 0);
o_flair_nii_fn = fullfile(op, 'T2_FLAIR.nii.gz');

if (~opt.do_overwrite && exist(o_flair_nii_fn, 'file'))
    
    disp('FLAIR already registered');
    
elseif (~isempty(i_flair_nii_fn))
    
    s_corr_pa = mdm_s_from_nii(msf_find_fn(op, 'FWF_topup_pa.nii.gz'));
    
    % Use the highest b-value for the registration
    s_tmp = mdm_s_subsample(s_corr_pa, max(1:s_corr_pa.xps.n) == (1:s_corr_pa.xps.n), wp, opt);
    
    % Do rigid body registration
    p_fn   = elastix_p_write(elastix_p_6dof(150), fullfile(wp, 'p_flair_fwf.txt'));
    res_fn = elastix_run_elastix(i_flair_nii_fn, s_tmp.nii_fn, p_fn, wp);
    
    % Save the result
    [I,h] = mdm_nii_read(res_fn);
    mdm_nii_write(I, o_flair_nii_fn, h);
    
end








