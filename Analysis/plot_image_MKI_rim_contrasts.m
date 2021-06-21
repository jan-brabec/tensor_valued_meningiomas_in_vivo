function plot_image_MKI_rim_contrasts()

% c_subject = [105,123,106,112,128,121]; %grade II with MKI rims
% c_subject = [108,113]; %grade II without MKI rims

% c_subject = [102, 109, 111, 117, 119]; %grade I with MKI rims
% c_subject = [ 114, 116, 120, 103,104]; %grade I with MKI rims

% c_subject = [115, 124, 129, 130]; %grade I without MKI rims
% c_subject = [101, 107, 110, 118, 122]; %grade I without MKI rims
% c_subject = [125, 127,126]; %grade I without MKI rims

% c_subject = [108 113 121 128]; % grade II with edema
% c_subject = [105 106 112 123]; % % grade II without edema

% c_subject = [102 103 104 109 111]; % grade I with edema
% c_subject = [115 117 124 126 129]; % grade I with edema
% c_subject = [130]; % grade I with edema

% c_subject = [101 107 110 114 116]; % grade I without edema
% c_subject = [118 120 122 125 127]; % grade I without edema
% c_subject = [119]; % grade I without edema

mki_rim = 0; %If 0 -> take slice with edema, if 1 -> take slice with mki rim

for c_exp = 1:numel(c_subject)
    warning off
    sss = readtable('figs_print.xlsx');
    warning on
    sss = table2cell(sss);
    sss(find([sss{:,1}] ~= c_subject(c_exp)),:) = [];
    
    ss{c_exp,1} = num2str(sss{2}); %case no
    ss{c_exp,2} = num2str(sss{3}); %mask
    if mki_rim == 1
        ss{c_exp,3} = sss{4}; %slice
    else
        ss{c_exp,3} = sss{9}; %slice
    end
    
    ss{c_exp,4} = [str2num(sss{5}) str2num(sss{6})];
    ss{c_exp,5} = [str2num(sss{7}) str2num(sss{8})];
    
    contrast_scale_list{c_exp} = ...
        {[(sss{14}) (sss{15})],... %T1 MPRAGE
        [(sss{16}) (sss{17})],... %T2 FLAIR
        [(sss{22}) (sss{23})],... %S0
        [(sss{30}) str2num(sss{31})],... %MD
        [(sss{26}) (sss{27})]}; %MKI
    
    subject_name = strcat('Meningioma_study_in_vivo_',ss{c_exp,1});
    disp(subject_name)
    
    data_dir{c_exp} =  fullfile('../../../In_vivo/data/processed', subject_name, ss{c_exp,2}, 'Diff','ver3','Serie_01_FWF');
    
    I_mask{c_exp} = mdm_nii_read(fullfile(data_dir{c_exp},'m.nii.gz'));
    I_mask{c_exp} = I_mask{c_exp}(:,:,ss{c_exp,3});
end

contrast_name_list = {...
    'T1_MPRAGE.nii.gz',...
    'T2_FLAIR.nii.gz',...
    'dtd_covariance_s0.nii.gz',...
    'dtd_covariance_MD.nii.gz',...
    'dtd_covariance_Mki.nii.gz'};

c_contrast_select = [1 2 3 4 5];
n_contrast = numel(contrast_scale_list);

n_exam  = 1;
m_upper = 0.1;
m_lower = 0.6;
m_left  = 0.1;
m_right = 0.1;
cnw     = 0;
ph      = 1;
phm1    = 0.1;
phm2    = 1.5;
phm     = [phm2 phm1 phm1 0];
enh     = 0;
pw      = 1;
pwm     = [0 0.1 0.4];

% Axis setup
n_c = 6;
fh = m_upper + enh  + n_exam * 4 * ph  + sum(phm)  + m_lower;
fw = m_left  + cnw  + n_c * pw  + sum(pwm) + m_right;

m_upper = m_upper / fh;
m_left  = m_left / fw;
ph      = ph / fh;
enh     = enh / fw;
pw      = pw / fw;

figure(150)
clf
set(gcf,'color', 'w');

for c_con = 1:max(c_contrast_select)
    for c_exp = 1:numel(c_subject)
        
        c_row = c_exp;
        
        nii_fn = fullfile(data_dir{c_exp}, contrast_name_list{c_contrast_select(c_con)});
        I      = mdm_nii_read(nii_fn);
        
        ax_l = m_left  + (c_con-1) * pw;
        
        if c_row == 1
            ax_b = 1 - m_upper - c_row * ph;
        else
            ax_b = 1 - c_row * ph;
        end
        
        ax_w = pw;
        ax_h = ph;
        axes('position', [ax_l ax_b  ax_w ax_h]);
        
        tmp  = real(I(:,:,ss{c_exp,3},:));
        tmp1  = crop_image(tmp,    ss{c_exp,4}, ss{c_exp,5});
        mask  = crop_image(I_mask{c_exp}, ss{c_exp,4}, ss{c_exp,5});
        
        msf_imagesc(double(tmp1) .* double(mask));
        
        hold on;
        caxis(contrast_scale_list{c_exp}{c_contrast_select(c_con)});
        colormap gray
    end
end

set(gcf,'Color','k')
set(gcf, 'InvertHardcopy', 'off')

print(sprintf('Fig.png'),'-dpng','-r500')

end