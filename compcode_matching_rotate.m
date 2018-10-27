function [score] = compcode_matching_rotate(D1, D2)

%%%%%%%%%%%%%%%%%%%%%%%% Lingfei Song 2018.6.14 %%%%%%%%%%%%%%%%%%
% Competitive Code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

D1 = D1(9:end-8, 9:end-8);
D2 = D2(9:end-8, 9:end-8);

score = min_dis(D1,D2);
        

function dis = min_dis(D1, D2)

D1 = D1(19:end-18, 19:end-18);

diss = zeros(1,867);

D2_1 = imrotate(D2, 5, 'crop');
D2_2 = imrotate(D2, -5, 'crop');
D2_3 = D2;

D2_1 = D2_1(3:end-2, 3:end-2);
D2_2 = D2_2(3:end-2, 3:end-2);
D2_3 = D2_3(3:end-2, 3:end-2);

for i = 1:289
    r = floor((i-1)/17);
    c = mod(i-1, 17);
    tmp_D2 = D2_1(17+(r-8)*2:end-(16-(r-8)*2), 17+(c-8)*2:end-(16-(c-8)*2));
    tmp = min(abs(D1-tmp_D2), 6-abs(D1-tmp_D2));
    diss(i) = sum(tmp(:));
end

for i = 1:289
    r = floor((i-1)/17);
    c = mod(i-1, 17);
    tmp_D2 = D2_2(17+(r-8)*2:end-(16-(r-8)*2), 17+(c-8)*2:end-(16-(c-8)*2));
    tmp = min(abs(D1-tmp_D2), 6-abs(D1-tmp_D2));
    diss(i+289) = sum(tmp(:));
end

for i = 1:289
    r = floor((i-1)/17);
    c = mod(i-1, 17);
    tmp_D2 = D2_3(17+(r-8)*2:end-(16-(r-8)*2), 17+(c-8)*2:end-(16-(c-8)*2));
    tmp = min(abs(D1-tmp_D2), 6-abs(D1-tmp_D2));
    diss(i+578) = sum(tmp(:));
end

[rows, cols] = size(D1);
dis = min(diss) / (rows * cols);