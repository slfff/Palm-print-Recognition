function [D_min, map] = mecompcode_coding(palm)

%%%%%%%%%%%%%%%% Lingfei Song 2018.5.12 %%%%%%%%%%%%%%%%%%%%
% DAS Coding
% Input:  Region of Interest 'roi';
% Output: major direction 'D'; Anisotropy Measurement 'A';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

palm = double(palm);

%%%%%%%%%%%%%%%%%%%%%%% direction %%%%%%%%%%%%%%%%%%%%%%%%%%%%
persistent temp_0;
persistent temp_1;
persistent temp_2;
persistent temp_3;
persistent temp_4;
persistent temp_5;

if isempty(temp_0)
    
    idx = 1:31;
    idx_row = repmat(idx, 31, 1)';
    idx_col = repmat(idx, 31, 1);
    
    temp_0 = G(idx_row-16, idx_col-16,      0, 0.0916, 5.6179, 5.6179);     % previous: 0.0916, 5.6179, 5.6179
    temp_1 = G(idx_row-16, idx_col-16,   pi/6, 0.0916, 5.6179, 5.6179);
    temp_2 = G(idx_row-16, idx_col-16, 2*pi/6, 0.0916, 5.6179, 5.6179);
    temp_3 = G(idx_row-16, idx_col-16, 3*pi/6, 0.0916, 5.6179, 5.6179);
    temp_4 = G(idx_row-16, idx_col-16, 4*pi/6, 0.0916, 5.6179, 5.6179);
    temp_5 = G(idx_row-16, idx_col-16, 5*pi/6, 0.0916, 5.6179, 5.6179);
end

gpu_R1 = conv2(palm, temp_0, 'same');
gpu_R2 = conv2(palm, temp_1, 'same');
gpu_R3 = conv2(palm, temp_2, 'same');
gpu_R4 = conv2(palm, temp_3, 'same');
gpu_R5 = conv2(palm, temp_4, 'same');
gpu_R6 = conv2(palm, temp_5, 'same');

[rows, cols] = size(palm);
D_min = zeros(rows, cols);          % direction of minimum response.
current_min = zeros(rows, cols);    % current minimum 

mask = gpu_R2 < gpu_R1;
D_min(mask) = 2; D_min(~mask) = 1;
current_min(mask) = gpu_R2(mask); current_min(~mask) = gpu_R1(~mask);

mask_low = gpu_R3 < current_min;
D_min(mask_low) = 3;
current_min(mask_low) = gpu_R3(mask_low);

mask_low = gpu_R4 < current_min;
D_min(mask_low) = 4;
current_min(mask_low) = gpu_R4(mask_low);

mask_low = gpu_R5 < current_min;
D_min(mask_low) = 5;
current_min(mask_low) = gpu_R5(mask_low);

mask_low = gpu_R6 < current_min;
D_min(mask_low) = 6;
current_min(mask_low) = gpu_R6(mask_low);

D_min = D_min - 1;

tmp = current_min(:);
tmp = sort(tmp);

map = double(current_min < tmp(10158));

