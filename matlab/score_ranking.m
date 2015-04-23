% Prakhar Sahay 04/14/2015
% This takes two rankings, an attempt and the base, and scores the attempt
% ranking by summing the deviations. Each ranking is a struct with the
% fields 'names' and 'ranks'.

function [score] = score_ranking(attempt,base)
    len=length(attempt.names);
    % Hash the attempt, name to rank
    a=hash_ranking(attempt);
    % Hash the base, name to rank
    b=hash_ranking(base);
    % Cumulative loop over sums
    score=0;
    dudes=keys(a);
    for j=1:len
        dude=dudes{j};
        score=score+abs(log10(a(dude))-log10(b(dude)));
    end
    
    function [hash] = hash_ranking(r)
        hash=containers.Map;
        for i=1:len
            hash(r.names{i})=r.ranks(i);
        end
    end
end