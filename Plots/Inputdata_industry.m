function[N,T0,stock_20years] = Inputdata_industry(mon)
%addpath ('data\3');
stock = readtable('48_industry_portoflio_value_weight_pure.csv');
% select data from 1995 to 2015(20 years) and ignore the column name
Originalsize = size(stock);
begin = Originalsize(1) - mon+1;
stock_20years = stock(begin:end,2:end);
% convert table to matrix and scaling
stock_20years = stock_20years{:,:}./100;

% ind=[];
% for i=1:N
%     a0=Allstockdata(:,i);
%     if isnan(a0)==0 
%         ind=[ind i];      % delete stock with missing data 
%     end
% end
% 
% Stockdata=Allstockdata(:,ind);
[T0,N]=size(stock_20years);
