function plot_image_contrasts()

% All examples
% c_subject = [101,102,103,104,105];
% c_subject = [106,107,108,109,110];
% c_subject = [111,112,113,114,115];
% c_subject = [116,117,118,119,120];
% c_subject = [121,122,123,124,125];
% c_subject = [126,127,128,129,130];

% First figure
% c_subject = 12;

% MK - stiff
% c_subject = [114, 107, 109, 106]; %stiff that have the lowest MK_10
% c_subject = [115, 112]; %othres that have the highest MK_10

% MKA - stiff
% c_subject = [114, 109]; %stiff that have the lowest MKA_10
% c_subject = [115, 112, 121, 120]; %othres that have the highest MKA_10

% MD - variable
% c_subject = [115, 112, 102, 121]; %variable that have the lowest MD
% c_subject = [109, 114, 101]; %others that have the highest MD

% std(FA) - soft
% c_subject = [103, 120]; %soft that have highest std(FA)
% c_subject = [109, 114, 115]; %hard or variable that have lowest std(FA)

% std(MKA) - variable
% c_subject = [112, 115, 105]; %variable that have the highest std(MKA)
% c_subject = [120, 109, 106, 118]; %othres that have the lowest std(MKA)

% MKI - grade 
% c_subject = [113, 108, 128, 106]; %grade II that have lowest std(MKI)
% c_subject = [122, 127, 126, 2]; %grade I that have highest std(MKI)

%Psammomatous MKA highest sorted
% c_subject = [122, 115, 107, 110, 130]; %highest to lowest

%Psammomatous MKi lowest sorted
% c_subject = [107, 110, 115, 122, 130]; %lowest to highest

for c_exp = 1:numel(c_subject)
    warning off
    sss = readtable('figs_print.xlsx');
    warning on
    sss = table2cell(sss);
    sss(find([sss{:,1}] ~= c_subject(c_exp)),:) = [];
    
    ss{c_exp,1} = num2str(sss{2}); %case ni
    ss{c_exp,2} = num2str(sss{3}); %mask
    ss{c_exp,3} = sss{4}; %slice
    ss{c_exp,4} = [str2num(sss{5}) str2num(sss{6})];
    ss{c_exp,5} = [str2num(sss{7}) str2num(sss{8})];

    contrast_scale_list{c_exp} = ...
        {[(sss{14}) (sss{15})],... %T1 MPRAGE
        [(sss{16}) (sss{17})],... %T2 FLAIR
        [(sss{22}) (sss{23})],... %S0
        [(sss{30}) str2num(sss{31})],... %MD
        [(sss{32}) (sss{33})],... %FA
        [(sss{28}) (sss{29})]...  %MKt            
        [(sss{24}) (sss{25})],... %MKA
        [(sss{26}) (sss{27})]...  %MKI
        };

    subject_name = strcat('BoF127_MMI_',ss{c_exp,1});
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
    'dtd_covariance_FA.nii.gz',...
    'dtd_covariance_Mkt.nii.gz',...    
    'dtd_covariance_Mka.nii.gz',...
    'dtd_covariance_Mki.nii.gz',...
    };

c_contrast_select = [1 2 3 4 5 6 7 8 ];
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
n_c = 12;
fh = m_upper + enh  + n_exam * 3 * ph  + sum(phm)  + m_lower;
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
print(sprintf('Fig_b_%d.png',c_subject),'-dpng','-r500')

end