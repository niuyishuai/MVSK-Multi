%This script is to draw fig and find upper left envelop
%%
%---------------------------------------------------------
% This part will generate 100 different values of epsilon;
%---------------------------------------------------------
idxN=[5 12 47 48 38];
muoverline=0.8;
method=1;
loop.outerloop=1;
loop.innerloop=100;
paretoopt(loop,idxN,muoverline,method,true); % set true for parallel mode

% get name prefix
suf=floor(log10(loop.innerloop*loop.outerloop));
pre=loop.innerloop*loop.outerloop/10^suf;
nameprefix=[num2str(pre),'e',num2str(suf)];

%draw mv
drawparetomvsk(nameprefix,1)% ops=1 : scatter mv fig
savefigtofile([nameprefix,'mv']);
%draw sk
drawparetomvsk(nameprefix,2)% ops=2 : scatter sk fig
savefigtofile([nameprefix,'sk']);


%%
%---------------------------------------------------------
% This part will generate 10000 different values of epsilon;
%---------------------------------------------------------
idxN=[5 12 47 48 38];
muoverline=0.8;
method=1;
loop.outerloop=100;
loop.innerloop=100;
paretoopt(loop,idxN,muoverline,method,true); % set true for parallel mode

% get name prefix
suf=floor(log10(loop.innerloop*loop.outerloop));
pre=loop.innerloop*loop.outerloop/10^suf;
nameprefix=[num2str(pre),'e',num2str(suf)];

%draw mv
drawparetomvsk(nameprefix,1)% ops=1 : scatter mv fig
savefigtofile([nameprefix,'mv']);
%draw sk
drawparetomvsk(nameprefix,2)% ops=2 : scatter sk fig
savefigtofile([nameprefix,'sk']);


%%
%---------------------------------------------------------
% This part will generate 1000000 different values of epsilon;
%---------------------------------------------------------
idxN=[5 12 47 48 38];
muoverline=0.8;
method=1;
loop.outerloop=100;
loop.innerloop=10000;
paretoopt(loop,idxN,muoverline,method,true); % set true for parallel mode

% get name prefix
suf=floor(log10(loop.innerloop*loop.outerloop));
pre=loop.innerloop*loop.outerloop/10^suf;
nameprefix=[num2str(pre),'e',num2str(suf)];

% draw mv
drawparetomvsk(nameprefix,1)% ops=1 : scatter mv fig
hold on;
results=extskenv(nameprefix);%extract envelope of S-K figure
% map back to mv space
scatter([results.v],[results.m],8,'o','filled');
savefigtofile([nameprefix,'mv']);

% draw sk curves
drawparetomvsk(nameprefix,2)% ops=2 : scatter sk fig
hold on;
% draw sk upper-left envelop
results=extskenv(nameprefix);%extract envelope of S-K figure
scatter([results.k],[results.s],8,'o','filled');
savefigtofile([nameprefix,'sk']);
