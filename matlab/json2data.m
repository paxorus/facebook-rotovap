% Prakhar Sahay 04/15/2015
% This function converts JSON strings to extract all relational data.

function [data] = json2data(file_name)
    raw_data=importdata(file_name,'\t');
    len=length(raw_data);
    % preallocate
    data=cell(1,len);%char(zeros(1,len));
    for i=1:len
        temp=parse_json(raw_data{i});
        data{i}=temp{1};
        disp(data{i}.name);
        data{i}=rmfield(data{i},'dates');
        data{i}=rmfield(data{i},'names');
        data{i}=rmfield(data{i},'nblock');
        data{i}=rmfield(data{i},'date');
        data{i}=rmfield(data{i},'top');
        data{i}=rmfield(data{i},'user');
        data{i}=rmfield(data{i},'log');
        data{i}=rmfield(data{i},'birth');

        % fields that are kept (11):
        % albums, comments, likes, phofyo, photos, numfs, nf, ng,
        % ninc, nout, name
        % fields that are removed (8):
        % dates, names, nblock, date, top, user, log, birth
    end
end