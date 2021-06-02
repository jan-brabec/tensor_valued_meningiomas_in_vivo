function [I,Im] = crop_image(I, xy_start, s_window)

[n_row, n_col, ~] = size(I);

plot_part_col = [xy_start(1) xy_start(1) + s_window(1)];
plot_part_row = [xy_start(2) xy_start(2) + s_window(2)];

rowrange = max(1, floor(plot_part_row(1) * n_row)):...
    min(n_row, floor(plot_part_row(2) * n_row));
colrange = max(1, floor(plot_part_col(1) * n_col)):...
    min(n_col, floor(plot_part_col(2) * n_col));

Im = zeros(size(I));
Im(colrange, rowrange,:) = 1;

I = I(colrange, rowrange,:);

end