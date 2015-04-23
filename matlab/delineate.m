% Prakhar Sahay 04/15/2015
% This is a quick-and-dirty function that corrects a range of numbers 
% obtained from a logarithmic function to the 1-10 scale to compare with the
% survey rankings.

function [r2] = delineate(r1)
    len=length(r1);
    slope=max(r1)-min(r1)/9;
    min=
    d=zeros(1,12);
    for i=1:len
        d(i)=log10(data{i}.(field_name));
    end
end