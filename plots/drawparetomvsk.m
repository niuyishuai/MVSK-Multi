function drawparetomvsk(nameprefix,ops)
% This script is to generate pareto optimal mv fig and pareto sk fig
% The loop is for getting the named directories
% ops =1 : draw pareto optimal mv fig 
% ops =2 : draw pareto optimal sk fig
% generate directory names
m=[nameprefix,'mean'];

v=[nameprefix,'variance'];

s=[nameprefix,'skewness'];

k=[nameprefix,'kurtosis'];
switch ops
    case 1
        figure(1)
        hold on;
        datafilenamelst = dir([m,'/*.mat']);
        for i=1:length(datafilenamelst)
            x = load([v,'/', datafilenamelst(i).name]);
            y = load([m,'/', datafilenamelst(i).name]);
            scatter(x.Svariance,y.Smean,'g','filled');
        end
        drawmvfig('stdmvskef.mat',1);

    case 2
        figure(2)
        hold on;
        datafilenamelst = dir([s,'/*.mat']);
        for i=1:length(datafilenamelst)
            x = load([k,'/', datafilenamelst(i).name]);
            y = load([s,'/', datafilenamelst(i).name]);
            scatter(x.Skurtosis,y.Sskewness,8,'g','filled');
        end
        drawskfig('stdmvskef.mat',1);
        
end