%% SURVEY DATA PROCESSING AND CORRELATIONS %%
[numerics]=xlsread('final_survey.xlsx', 'A1:K13'); %read data
%1 = ID, %2 = year, %3 = pop, %4 = fr, %5 = events, %6 = outside, %7 =
%clubs, %8 = outside, %9 = time fr, %time fb

no_categ = 11;

%hold in structure
fbdata = struct('ID', numerics(:,1),'year', numerics(:,2),'popularity', numerics(:,3),'friends', numerics(:,4),'closefriends', numerics(:,5),'events', numerics(:,6),'events_outside', numerics(:,7),'clubs', numerics(:,8),'clubs_outside', numerics(:,9), 'time', numerics(:,10), 'timeonfb', numerics(:,11));

%CORRELATIONS
fields = fieldnames(fbdata); %find field names
x = cell(81,4); %correlations between each 
            count = 1;
            %correlation
for i = 3:11
     for j = 3:11
            [r,p] = corrcoef(fbdata.(fields{i}), fbdata.(fields{j}));
            x{count} = r; %corrcoef
            x{count,2} = p; %significance value
            x{count,3} = fields(i);
            x{count,4} = fields(j); 
            count = count + 1; 
     end
end
%find sig indexes
find([x{:,2}] <= .05);
save('fbdata.mat'); 
x_s = x;
save('x_s.mat'); 