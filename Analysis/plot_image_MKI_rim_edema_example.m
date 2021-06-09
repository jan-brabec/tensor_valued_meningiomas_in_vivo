function plot_image_MKI_rim_edema_example()


% c_subject = [105 113]; %MKI
% c_subject = [104 129]; %Edema

for c_exp = 1:numel(c_subject)
    warning off
    sss = readtable('figs_print.xlsx');
    warning on
    sss = table2cell(sss);
    sss(find([sss{:,1}] ~= c_subject(c_exp)),:) = [];
    
    ss{c_exp,1} = num2str(sss{2}); %slice
    ss{c_exp,2} = num2str(sss{3}); %mask
    ss{c_exp,3} = sss{4};
    ss{c_exp,4} = [str2num(sss{5}) str2num(sss{6})];
    ss{c_exp,5} = [str2num(sss{7}) str2num(sss{8})];
    
    
    subject_name = strcat('Meningioma_in_vivo_',ss{c_exp,1});
    disp(subject_name)
    
    data_dir{c_exp} =  fullfile('../../../In_vivo/data/processed', subject_name, ss{c_exp,2}, 'Diff','ver3','Serie_01_FWF');
    
    I_mask{c_exp} = mdm_nii_read(fullfile(data_dir{c_exp},'m.nii.gz'));
    I_mask{c_exp} = I_mask{c_exp}(:,:,ss{c_exp,3});
end



if (0) %MKI rim example
    contrast_name_list = {...
        'T1_MPRAGE.nii.gz',...
        'dtd_covariance_Mki.nii.gz',...
        };
    
    contrast_scale_list = ... 
        {[0 700],...
        [0 0.8]...
        };
end

if (1) %Edema example
contrast_name_list = {...
    'T1_MPRAGE.nii.gz',...
    'dtd_covariance_MD.nii.gz',...
    };

contrast_scale_list = ...
    {[0 700],...
    [0 2.5]...
    };
end


c_contrast_select = [1 2];
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
n_c = 9;
fh = m_upper + enh  + n_exam * 3 * ph  + sum(phm)  + m_lower;
fw = m_left  + cnw  + n_c * pw  + sum(pwm) + m_right;

m_upper = m_upper / fh;
m_left  = m_left / fw;
ph      = ph / fh;
enh     = enh / fw;
pw      = pw / fw;

figure(183)
clf
set(gcf,'color', 'w');

for c_con = 1:max(c_contrast_select)
    for c_exp = 1:numel(c_subject)
        
        if c_exp == 1
            c_row = 1;
        elseif c_exp == 2
            c_row = 1;
        elseif c_exp == 3
            c_row = 2;
        elseif c_exp == 4
            c_row = 2;
        end
        
        nii_fn = fullfile(data_dir{c_exp}, contrast_name_list{c_contrast_select(c_con)});
        I      = mdm_nii_read(nii_fn);
        
        c_axs = contrast_scale_list{c_contrast_select(c_con)};
        
        if c_exp == 1
            c_row = 1;
        elseif c_exp == 2
            c_row = 2; c_con = c_con ;
        elseif c_exp == 3
            c_row = 2;
        elseif c_exp == 4
            c_row = 2; c_con = c_con + 2;
        end
        
        ax_l = m_left  + (c_con-1) * pw;
        
        if c_row == 1
            ax_b = 1 - m_upper - c_row * ph;
        else
            ax_b = 1 - c_row * ph;
        end
        
        if c_exp == 1
            c_row = 1;
        elseif c_exp == 2
            c_row = 1; c_con = c_con - 2;
        elseif c_exp == 3
            c_row = 2;
        elseif c_exp == 4
            c_row = 2; c_con = c_con - 2;
        end
        
        ax_w = pw;
        ax_h = ph;
        axes('position', [ax_l ax_b  ax_w ax_h]);
        
        tmp  = real(I(:,:,ss{c_exp,3},:));
        tmp1  = crop_image(tmp,    ss{c_exp,4}, ss{c_exp,5});
        mask  = crop_image(I_mask{c_exp}, ss{c_exp,4}, ss{c_exp,5});
        
        msf_imagesc(double(tmp1) .* double(mask));
        
        
        hold on;
        caxis(c_axs);
        colormap gray
    end
end

% set(gcf, 'pos', [ 98   126   829   676]);

set(gcf,'Color','k')
set(gcf, 'InvertHardcopy', 'off')

print(sprintf('First_fig_b_%d.png',c_subject),'-dpng','-r500')

end