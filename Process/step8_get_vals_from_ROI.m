function dat_in_vivo = step8_get_vals_from_ROI(s)
% function dat_in_vivo = step8_get_vals_from_ROI(s)

tp = '../data/processed';
% rp = '../data/ROI_T1_based';
rp = '../data/ROI_rim_T1_based';

global iter_no dat_in_vivo

if (nargin == 0)
    clc; mdm_iter_lund(tp, @step8_get_vals_from_ROI); return;
end

if (~strcmp(s.modality_name, 'Diff/ver3')), return; end

disp(s.subject_name);

op = fullfile(tp, s.subject_name, s.exam_name, 'Diff/ver3', 'Serie_01_FWF');

MKa_im_file  = fullfile(op,'dtd_covariance_MKa.nii.gz');
MKi_im_file  = fullfile(op,'dtd_covariance_MKi.nii.gz');
MKt_im_file  = fullfile(op,'dtd_covariance_MKt.nii.gz');
MD_im_file   = fullfile(op,'dtd_covariance_MD.nii.gz' );
FA_im_file   = fullfile(op,'dtd_covariance_FA.nii.gz' );
uFA_im_file  = fullfile(op,'dtd_covariance_uFA.nii.gz' );
T1_im_file   = fullfile(op,'T1_MPRAGE.nii.gz');
T2_im_file   = fullfile(op,'T2_FLAIR.nii.gz');
S0_im_file   = fullfile(op,'dtd_covariance_S0.nii.gz');
QSM_im_file   = fullfile(op,'QSM.nii.gz');

roi_file = fullfile(rp,strcat(s.subject_name,'.nii.gz'));

I_Mka = mdm_nii_read(MKa_im_file);
I_Mki = mdm_nii_read(MKi_im_file);
I_Mkt = mdm_nii_read(MKt_im_file);
I_MD  = mdm_nii_read(MD_im_file);
I_FA  = mdm_nii_read(FA_im_file);
I_uFA = mdm_nii_read(uFA_im_file);
I_T1  = mdm_nii_read(T1_im_file);
I_T2  = mdm_nii_read(T2_im_file);
I_S0  = mdm_nii_read(S0_im_file);

I_ROI = mdm_nii_read(roi_file);

pat = str2num(s.subject_name(end-2:end));

dat_in_vivo(iter_no).I_ROI  = I_ROI;

dat_in_vivo(iter_no).Mka.I_Mka  = I_Mka;
dat_in_vivo(iter_no).Mka.Mka_in_ROI  = I_Mka(I_ROI > 0);

dat_in_vivo(iter_no).Mki.I_Mki  = I_Mki;
dat_in_vivo(iter_no).Mki.Mki_in_ROI  = I_Mki(I_ROI > 0);

dat_in_vivo(iter_no).Mkt.I_Mkt  = I_Mkt;
dat_in_vivo(iter_no).Mkt.Mkt_in_ROI  = I_Mkt(I_ROI > 0);

dat_in_vivo(iter_no).MD.I_MD  = I_MD;
dat_in_vivo(iter_no).MD.MD_in_ROI  = I_MD(I_ROI > 0);

dat_in_vivo(iter_no).FA.I_FA  = I_FA;
dat_in_vivo(iter_no).FA.FA_in_ROI  = I_FA(I_ROI > 0);

dat_in_vivo(iter_no).uFA.I_uFA  = I_uFA;
dat_in_vivo(iter_no).uFA.uFA_in_ROI  = I_uFA(I_ROI > 0);

dat_in_vivo(iter_no).T1.I_T1  = I_T1;
dat_in_vivo(iter_no).T1.T1_in_ROI  = I_T1(I_ROI > 0);

dat_in_vivo(iter_no).T2.I_T2  = I_T2;
dat_in_vivo(iter_no).T2.T2_in_ROI  = I_T2(I_ROI > 0);

dat_in_vivo(iter_no).S0.I_S0  = I_S0;
dat_in_vivo(iter_no).S0.S0_in_ROI  = I_S0(I_ROI > 0);

dat_in_vivo(iter_no).pat = pat;
dat_in_vivo(iter_no).files.MKa_im_file = MKa_im_file;
dat_in_vivo(iter_no).files.MKi_im_file = MKi_im_file;
dat_in_vivo(iter_no).files.MKt_im_file = MKt_im_file;
dat_in_vivo(iter_no).files.MD_im_file  = MD_im_file;
dat_in_vivo(iter_no).files.FA_im_file  = FA_im_file;
dat_in_vivo(iter_no).files.uFA_im_file = uFA_im_file;
dat_in_vivo(iter_no).files.T1_im_file  = T1_im_file;
dat_in_vivo(iter_no).files.T2_im_file  = T2_im_file;
dat_in_vivo(iter_no).files.S0_im_file  = S0_im_file;
dat_in_vivo(iter_no).files.QSM_im_file = QSM_im_file;

iter_no = iter_no + 1;
end