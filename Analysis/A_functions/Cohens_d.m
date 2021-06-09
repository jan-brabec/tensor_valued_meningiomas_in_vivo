function cohen_d = Cohens_d(distrib_1,distrib_2)
% function cohen_d = Cohens_d(distrib_1,distrib_2)
%
% Calculates Cohen d (effect size) for two indepedent distributions.


s1 = var(distrib_1);
s2 = var(distrib_2);

n1 = numel(distrib_1);
n2 = numel(distrib_2);

s = sqrt( ((n1 - 1)*s1 + (n2 - 1)*s2) / (n1 + n2 - 2) );

% d = abs( (median(d1) - median(d2)) / iqr(cat(2,d1,d2)) );
cohen_d = abs( (mean(distrib_1) - mean(distrib_2)) / s );


end

