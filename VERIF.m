addpath('.\CompCode\');
addpath('.\MCompCode\');
addpath('.\ECompCode\');
addpath('.\MECompCode\');
addpath('.\PALM_DATABASE\');

method = @CompCode;

% genuine matching
genu_match = zeros(1,75000);
idx = 1;
for i = 0:599
    if i<10
        numstr = ['00', int2str(i)];
    elseif i<100
        numstr = ['0', int2str(i)];
    else
        numstr = int2str(i);
    end
    d = dir(['.\PALM_DATABASE\ROI_',numstr, '*.bmp']);
    for j = 1:size(d,1)
        for k = j+1:size(d,1)
            palm1 = imread(d(j).name);
            palm2 = imread(d(k).name);
            genu_match(idx) = method(palm1, palm2);
            idx = idx + 1;
        end
    end
    disp(i);
end

% imposter matching
impo_match = zeros(1,30000000);
idx = 1;
for i = 0:599
    if i<10
        numstr1 = ['00', int2str(i)];
    elseif i<100
        numstr1 = ['0', int2str(i)];
    else
        numstr1 = int2str(i);
    end
    d1 = dir(['.\PALM_DATABASE\ROI_',numstr1, '*.bmp']);
    for j = i+1:599
        if j<10
            numstr2 = ['00', int2str(j)];
        elseif j<100
            numstr2 = ['0', int2str(j)];
        else
            numstr2 = int2str(j);
        end
        d2 = dir(['.\PALM_DATABASE\ROI_',numstr2, '*.bmp']);
        
        for k = 1:size(d1, 1)
            for l = 1:size(d2, 1)
                palm1 = imread(d1(k).name);
                palm2 = imread(d2(k).name);
                impo_match(idx) = method(palm1, palm2);
                idx = idx + 1;
            end
        end
    end
    disp(i);
end
    
    
    