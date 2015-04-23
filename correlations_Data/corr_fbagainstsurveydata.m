% this file plots correlations BETWEEN fb and survey data
load('fbdata.mat'); %survey
load('corr_data.mat'); %fb data
load('fields_corr.mat');  % fb data fields
fieldsfb = fields_corr; %find field names
fieldssurvey = fieldnames(fbdata); 
x = cell(72,4); %correlations between each 
            count = 1;
for i = 2:9
     for j = 1:9
         % we could also only output if there is a correlation + then plot
        % + do anova
            [r,p] = corrcoef(fbdata.(fieldssurvey{i}), corr_data(:,j));
            x{count} = r; %corrcoef
            x{count,2} = p; %significance value
            x{count,3} = fieldssurvey(i);
            x{count,4} = fieldsfb(j); 
            count = count + 1; 
     end
end