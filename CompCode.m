function [score] = CompCode(palm1, palm2)

D1 = compcode_coding(palm1);
D2 = compcode_coding(palm2);

score = compcode_matching_no_align(D1, D2);
