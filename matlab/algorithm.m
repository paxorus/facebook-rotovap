% Prakhar Sahay 04/15/2015
% This function optimizes two coefficients given some relational
% data (2 factors). It tries all different values and returns the 
% coefficients with the minimum penalty score.

function [c1,c2,score_vec] = algorithm(base,d1,d2,names)
    base=delineate(base); % deviations are additive, so normalization to 1-10 scale is required
    len=length(base.names);
    score_vec=zeros(1,101);
    min_score=Inf;
    c1=0;
    
    % optimize coeff for two factors: phofyo, nf
    for i=0:.01:1
        %attempt=struct('names',cell(1,len),'ranks',zeros(1,len));% like base
        attempt=base;
        attempt.names=cell(1,len);
        attempt.ranks=zeros(1,len);

        for j=1:len % compute rank for each member
            y=i*d1(j)+(1-i)*d2(j);
            attempt.ranks(j)=y;
            attempt.names{j}=names{j};
        end
        
        score=score_ranking(delineate(attempt),base);
        if score<min_score
             min_score=score;
             c1=i;
        end
        score_vec(round(100*i+1))=score;
    end
    c2=1-c1;
end