function [D] = compcode_coding(palm)

%%%%%%%%%%%%%%%% Lingfei Song 2018.5.26 %%%%%%%%%%%%%%
% Competitive Coding Scheme for Palmprint Verification  ICPR 04
% Input:  Region of interest 'palm'.
% Output: Double-orientation code 'Op' and 'Os'.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

palm = double(palm);
[rows, cols] = size(palm);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
    
    temp_0 = G(idx_row-16, idx_col-16,      0, 0.0916, 5.6179, 5.6179);
    temp_1 = G(idx_row-16, idx_col-16,   pi/6, 0.0916, 5.6179, 5.6179);
    temp_2 = G(idx_row-16, idx_col-16, 2*pi/6, 0.0916, 5.6179, 5.6179);
    temp_3 = G(idx_row-16, idx_col-16, 3*pi/6, 0.0916, 5.6179, 5.6179);
    temp_4 = G(idx_row-16, idx_col-16, 4*pi/6, 0.0916, 5.6179, 5.6179);
    temp_5 = G(idx_row-16, idx_col-16, 5*pi/6, 0.0916, 5.6179, 5.6179);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

gpu_R1 = conv2(palm, temp_0, 'same');
gpu_R2 = conv2(palm, temp_1, 'same');
gpu_R3 = conv2(palm, temp_2, 'same');
gpu_R4 = conv2(palm, temp_3, 'same');
gpu_R5 = conv2(palm, temp_4, 'same');
gpu_R6 = conv2(palm, temp_5, 'same');

D = zeros(rows, cols);  % find the minimum response direction for gabor filter.
current_min = zeros(rows, cols);    % current minimum 

mask = gpu_R2 < gpu_R1;
D(mask) = 2; D(~mask) = 1;
current_min(mask) = gpu_R2(mask); current_min(~mask) = gpu_R1(~mask);

mask_low = gpu_R3 < current_min;
D(mask_low) = 3;
current_min(mask_low) = gpu_R3(mask_low);

mask_low = gpu_R4 < current_min;
D(mask_low) = 4;
current_min(mask_low) = gpu_R4(mask_low);

mask_low = gpu_R5 < current_min;
D(mask_low) = 5;
current_min(mask_low) = gpu_R5(mask_low);

mask_low = gpu_R6 < current_min;
D(mask_low) = 6;

D = D - 1;



