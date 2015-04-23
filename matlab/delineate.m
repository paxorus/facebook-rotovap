% Prakhar Sahay 04/15/2015
% This is a quick-and-dirty function that corrects a range of numbers 
% obtained from a logarithmic function to the 1-10 scale to compare with the
% survey rankings.

function [attempt] = delineate(attempt)
    len=length(attempt.ranks);
    x0=min(attempt.ranks);
    xf=max(attempt.ranks);
    m=9/(xf-x0); % slope
    
    for i=1:len
        x=attempt.ranks(i);
        attempt.ranks(i)=m*(x-x0)+1;
    end
end