# facebook-rotovap
A suite of JS scripts screen-scrape data, after which MatLab scripts compounds and analyzes the data.


# JavaScript
The suite of scripts are combined into one file to run sequentially. The raw collected data is uploaded to Parse.
Profile: # of friends, # of groups, profile picture upload dates, top 10 friends, # people chatted to in last 8 weeks,
	average number of likes/comments on person's posts,# of people blocked,# of incoming/outgoing pending friend requests
Friends: # of friends of friends (and if from Brandeis plus name/gender)
Activity log (past 8 weeks): # of statuses,# of pictures,# of comments,# of likes, # of shares
Chats (top 10 friends+any group convos, past week): each comment with length+time

We can then give the following report:
- *activity log*: timeline of prof pic uploads, statuses, pictures, comments, likes, share
- *profile*: name, # friends, percentage of friends from Brandeis, top 10 friends
- *friends*: normalized rank in terms of number of friends, gender ratio of friends
- *disclaimer*: all friends do not make data accessible, assumed to be negligible loss of information
- *chats*: average response time, participation percentage, average message length 

# Survey
The survey questions can provide new datasets for our conclusions. We can also ask for estimates of the collected data to compare and contrast.

# End Goal
In addition to reporting the above parameters, we can compare and contrast the respondent's self-perception with the reality.
Though perhaps not statistically significant, we can finally rank the respondents against each other. It gives only a very rough idea
and is more interesting within a friend group (or if a large enough demographic is covered, which is out of the scope of this project).
It will be more important for normalization, in that the majority individuals may undershoot how much they chat or post.
We may also be able to comment on how two friends interact if two respondents happen to be friends. Finally we can include the other questions
of the survey to attempt linear/quadratic correlations and generate several graphs.