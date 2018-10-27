function [score] = MCompCode(palm1, palm2)

[D1, map1] = mcompcode_coding(palm1);
[D2, map2] = mcompcode_coding(palm2);

score = mcompcode_matching(D1, map1, D2, map2);