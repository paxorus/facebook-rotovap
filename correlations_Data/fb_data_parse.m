%%this file processes fb data further
%calculates FB CORRELATIONS%%
data = Parse_Data;
conv = cellfun(@(x) x(1,1), data);
%add up numfs, comments, likes, photos

%TIDY UP COLUMNS for data analysis
for i = 1:13
    %tidy up comments - add them up
k = cellfun(@sum,conv(i).comments,'uni', false); %temp var
conv(i).comments = sum(cell2mat(k)); %sum up comments

%tidy up likes - add them up
likes_no = conv(i).likes;
conv(i).likes =  length(likes_no); 

%get number from photos, convert to double, then sum up
a = conv(i).photos; 
b = conv(i).ninc;
l = 0; %retrieve number, l is a temp variable that helps us sum 
%up the # of photos
    for j = 1:length(a) %check all cases for length of '___ photo(s)'
        if strcmp(a{j}, 'Empty') == 1
            a{j} = 0;
            conv(i).photos{j} = a{j};
        elseif strcmp(a{j}, '1 photo') == 1 
        a{j} = 1;
        conv(i).photos{j} = a{j};
        elseif strcmp(a{j}, '1 video') == 1
        a{j} = 1;
        conv(i).photos{j} = a{j};
        else
        a{j} = a{j}(1:end-7);
       conv(i).photos{j} = str2num(a{j});
        end
        l = l + conv(i).photos{j}; %sum up # of photos
    end
    conv(i).photos =  l; 
end
%put in a nice struct, name + #s only so we can analyze%
final_conv = conv; 
fields = {'name', 'birth', 'date','top', 'user', 'log', 'names', 'numfs', 'dates', 'ninc'};
final_conv = rmfield(final_conv,fields);
x = cell(81,4); %correlations between each 
            count = 1;
            %correlation
fields_corr = fieldnames(final_conv);
corr_data = (struct2cell(final_conv)); 

for i = 1:9 %get rid of any empty boxes which would mess up the 
  if isempty(corr_data{i,5}) %cell2mat line
        corr_data{i,5} = 0;  
  end
    if isempty(corr_data{i,11})
        corr_data{i,11} = 0; 
   end
end
corr_data = cell2mat(corr_data)'; %convert this structure to a matrix
for i = 1:9
      for j = 1:9
%          % we could also only output if there is a correlation + then plot
%         % + do anova
            
           [r,p] = corrcoef(corr_data(:,i), corr_data(:,j));
           x{count} = r; %corrcoef
           x{count,2} = p; %significance value
            x{count,3} = fields_corr{i};
            x{count,4} = fields_corr{j}; 
             count = count + 1; 
     end
end
save('corr_data.mat'); 
save('fields_corr.mat'); 
