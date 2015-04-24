function [sum] = Likes_Parse()
    % init
    x=Parse_Data('example.txt');
    y=x{1};
    y=y.likes;
    n=size(y);
    n=n(2);
    sum=0;
    for i=1:n
        sum=sum+eval_sentence(y{i});
    end   
    function [num_likes] = eval_sentence(temp)
        digit_pat1='\d';
        emptyvec=[0,0];
        if temp==0
            num_likes=0;
        else
            check=regexp(temp,digit_pat1,'match');
            checkA=strfind(temp,'and');
            checkB=strfind(temp,',');
            sizecheckB=size(checkB);            
            if size(checkA)==emptyvec % no 'and'
                num_likes=1;
            elseif size(check)==emptyvec % no '%d'
                num_likes=2;
            elseif sizecheckB==emptyvec % x, y, and z like this
                num=str2num(check{1});
                num_likes=num+1;
            else
                num1=sizecheckB(2);
                num2=str2num(check{1});
                num_likes=num1+num2+1;
            end

        end
    end
end
    
