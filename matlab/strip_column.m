% Prakhar Sahay 04/15/2015
% This is a quick-and-dirty function to access some field for a cell array
% of structs. The usual functions fail because some values are [].

function [d] = strip_column(data,field_name)
    len=length(data);
    d=zeros(1,12);
    for i=1:len
        d(i)=log10(data{i}.(field_name));
    end
end