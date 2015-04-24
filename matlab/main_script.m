% Prakhar Sahay 04/14/2015
% This script uses a base ranking, and runs a greedy optimization algorithm
% coupled with a ranking algorithm of our own design to find the set of
% coefficients of a weighted average that most closely match the base
% ranking.

% BASE_FILE_NAME='prakhar_survey.tsv';
% base=create_base(BASE_FILE_NAME);
% REL_FILE_NAME='prakhar_friends.json';
% data=json2data(REL_FILE_NAME);
FIELDS={'phofyo','nf','albums'};
coeff=zeros(1,length(FIELDS));

len=length(base.names);
d1=strip_column(data,FIELDS{1});
d2=strip_column(data,FIELDS{2});
names=cell(1,len);
for i=1:len
    names{i}=data{i}.name;
end

[coeff(1),coeff(2),scores]=algorithm(base,d1,d2,names);
disp(coeff);
for j=1:length(FIELDS)-2
    d1=coeff(j)*d1+coeff(j+1)*d2;
    d2=strip_column(data,FIELDS{j+2});
    [c1,c2,scores]=algorithm(base,d1,d2,names);
    coeff=c1*coeff;
    coeff(j+2)=c2;
    disp(coeff);
end