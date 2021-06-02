function a = step1_copy_data(s)
% function a = step1_copy_data(s)

a = [];
ap = '/Volumes/BoF127_MMI';
tp = '../data/raw/';

if (nargin == 0)
    mdm_iter_lund(ap, @step1_copy_data);
    return;
end

if (~strcmp(s.modality_name, 'NII')), return; end

ip = fullfile(ap, s.subject_name, s.exam_name, s.modality_name);
op = fullfile(tp, s.subject_name, s.exam_name, s.modality_name);

msf_mkdir(op);

d = dir(fullfile(ip, '*.*'));

for c = 1:numel(d)
    
    x = [...
        any(strfind(d(c).name, 't2')) ...
        any(strfind(d(c).name, 'FWF')) ...
        any(strfind(d(c).name, 'mprage')) ...
        ];
    
    if (exist(fullfile(op, d(c).name), 'file')), continue; end
    
    if (~any(x))
        disp(d(c).name);
        1;
        continue;
    end
    
    copyfile( fullfile(ip, d(c).name), fullfile(op, d(c).name));
end


end