


c_exp = 9;


contrast_scale_list = ...
    {[0 700],... %T1 MPRAGE
    [0 200],... %T2 FLAIR
    [0 600],... %S0
    [0 2.5],... %MD
    [0 0.7],... %FA
    [0 1.8]...  %MKt
    [0 1.4],... %MKA
    [0 0.8]...  %MKI
    };

colorbar
colormap('gray');

c = colorbar;
c.LineWidth = 1.5;
c.Ticks = [0.0,0.95];
c.TickLabels = {num2str(contrast_scale_list{c_exp}(1)), num2str(contrast_scale_list{c_exp}(2))}
% c.TickLength = 0.4;
c.FontSize = 40;
c.FontWeight = 'bold';
c.Color = 'white';


set(gcf,'color','black');
set(gca,'color','black');
fig = gcf;
fig.InvertHardcopy = 'off';

print(sprintf('Color_map%d.png',c_exp),'-dpng','-r500')
