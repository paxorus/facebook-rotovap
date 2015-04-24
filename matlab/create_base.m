% Prakhar Sahay 04/14/2015
% This uses 'prakhar_survey.tsv' to create a base ranking based on how people in my
% friend group rank themselves on a scale of 1-10.

function [base] = create_base(file_name)
    mat=importdata(file_name,'\t');
    base.names=mat.textdata;
    base.ranks=mat.data;
end