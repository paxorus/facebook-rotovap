function [likes_comments_shares] = Activity_Log_Parse()
    % init
    x=Parse_Data('example.txt');
    y=x{1};
    log=y.log;
    fnames=fieldnames(log);
    n=size(fnames);
    n=n(2);
    likes_comments_shares=[0,0,0];
    emptyvec=[0,0];
    for i=1:n
        eval_sentence(log.(fnames{i}));
    end   
    function eval_sentence(temp_cell_array)
        sizeA=size(temp_cell_array);
        sizeA=sizeA(2);
        for j=1:sizeA
            temp=temp_cell_array{j};
            checkA=strfind(temp,'like');
            checkB=strfind(temp,'share');
            checkC=strfind(temp,'comment');
            if size(checkA)~=emptyvec 
                likes_comments_shares(1)=likes_comments_shares(1)+1
            end
            if size(checkB)~=emptyvec
                likes_comments_shares(2)=likes_comments_shares(2)+1
            end
            if size(checkC)~=emptyvec 
                likes_comments_shares(3)=likes_comments_shares(3)+1
            end
        end
    end
end
    
