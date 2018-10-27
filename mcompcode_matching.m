function [score] = mcompcode_matching(D1, map1, D2, map2)

%%%%%%%%%%%%%%%%%%%%%%%% Lingfei Song 2018.6.13 %%%%%%%%%%%%%%%%%%
% Double Orientation code Matching **PR 2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

D1 = D1(9:end-8, 9:end-8);
D2 = D2(9:end-8, 9:end-8);
map1 = map1(9:end-8, 9:end-8);
map2 = map2(9:end-8, 9:end-8);

score = min_dis(D1,map1,D2,map2);
        

function dis = min_dis(D1,map1,D2,map2)

D1 = D1(19:end-18, 19:end-18);
map1 = map1(19:end-18, 19:end-18);

dif = zeros(1,867);

map2_1 = imrotate(map2, 5, 'crop');
D2_1 = imrotate(D2, 5, 'crop');
map2_2 = imrotate(map2, -5, 'crop');
D2_2 = imrotate(D2, -5, 'crop');
map2_3 = map2;
D2_3 = D2;

map2_1 = map2_1(3:end-2, 3:end-2);
D2_1 = D2_1(3:end-2, 3:end-2);
map2_2 = map2_2(3:end-2, 3:end-2);
D2_2 = D2_2(3:end-2, 3:end-2);
map2_3 = map2_3(3:end-2, 3:end-2);
D2_3 = D2_3(3:end-2, 3:end-2);

map = zeros(size(map1));

for i = 1:289
    r = floor((i-1)/17);
    c = mod(i-1, 17);
    tmp_map2 = map2_1(17+(r-8)*2:end-(16-(r-8)*2), 17+(c-8)*2:end-(16-(c-8)*2));
    tmp_D2 = D2_1(17+(r-8)*2:end-(16-(r-8)*2), 17+(c-8)*2:end-(16-(c-8)*2));
    map(:) = 0;
    map(map1 > 0) = 1;
    map(tmp_map2 > 0) = 1;
    tmp = min(abs(tmp_D2-D1), 6-abs(tmp_D2-D1)) .* map;
    dif(i) = sum(tmp(:)) / sum(map(:));
end

for i = 1:289
    r = floor((i-1)/17);
    c = mod(i-1, 17);
    tmp_map2 = map2_2(17+(r-8)*2:end-(16-(r-8)*2), 17+(c-8)*2:end-(16-(c-8)*2));
    tmp_D2 = D2_2(17+(r-8)*2:end-(16-(r-8)*2), 17+(c-8)*2:end-(16-(c-8)*2));
    map(:) = 0;
    map(map1 > 0) = 1;
    map(tmp_map2 > 0) = 1;
    tmp = min(abs(tmp_D2-D1), 6-abs(tmp_D2-D1)) .* map;
    dif(i+289) = sum(tmp(:)) / sum(map(:));
end

for i = 1:289
    r = floor((i-1)/17);
    c = mod(i-1, 17);
    tmp_map2 = map2_3(17+(r-8)*2:end-(16-(r-8)*2), 17+(c-8)*2:end-(16-(c-8)*2));
    tmp_D2 = D2_3(17+(r-8)*2:end-(16-(r-8)*2), 17+(c-8)*2:end-(16-(c-8)*2));
    map(:) = 0;
    map(map1 > 0) = 1;
    map(tmp_map2 > 0) = 1;
    tmp = min(abs(tmp_D2-D1), 6-abs(tmp_D2-D1)) .* map;
    dif(i+578) = sum(tmp(:)) / sum(map(:));
end


dis = min(dif(:));