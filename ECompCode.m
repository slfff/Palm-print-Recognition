function [score] = ECompCode(palm1, palm2)


D1 = ecompcode_coding(palm1);
D2 = ecompcode_coding(palm2);

score = ecompcode_matching(D1, D2);
