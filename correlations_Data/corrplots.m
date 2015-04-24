%in this file, we plot  significant and meaningful correlations
% cannot create a function to optimize this because there are two plots
load('x.mat');
load('x_s.mat');
load('fbdata.mat'); %survey
load('corr_data.mat'); %fb data
%significant plots
%# of comments, photos of you
%
p = polyfit(corr_data(:,6), corr_data(:,8),1);
linepointsX = [min(corr_data(:,6)) max(corr_data(:,6))]; 
linepointsY = polyval(p, [min(corr_data(:,6)) max(corr_data(:,6))]); 
figure;
hold on
scatter(corr_data(:,6), corr_data(:,8)); 
plot(linepointsX, linepointsY, '-r');
hold off; 
%friends, comments

z = polyfit(corr_data(:,6), fbdata.friends,1);
linepointsX = [min(corr_data(:,6)) max(corr_data(:,6))]; 
linepointsY = polyval(z, [min(corr_data(:,6)) max(corr_data(:,6))]); 
figure;
hold on
scatter(corr_data(:,6), fbdata.friends); 
plot(linepointsX, linepointsY, '-r');
hold off; 

%plot(fbdata.events, fbdata.friends)
%events + friends
y = polyfit(fbdata.events, fbdata.friends,1);
linepointsX = [min(fbdata.events) max(fbdata.events)]; 
linepointsY = polyval(y, [min(fbdata.events) max(fbdata.events)]); 
figure;
hold on
scatter(fbdata.events, fbdata.friends); 
plot(linepointsX, linepointsY, '-r');
hold off; 