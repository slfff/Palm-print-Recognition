function [score] = MECompCode(palm1, palm2)


[D1, map1] = mecompcode_coding(palm1);
[D2, map2] = mecompcode_coding(palm2);

score = mecompcode_matching(D1, map1, D2, map2);