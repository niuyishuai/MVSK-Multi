% First Step: draw mv and sk efficient frontier
% with idxN=[5 12 47 48 38]
%-----------------------------------------------------
% idxN=[5 12 47 48 38];method=3; muoverline=1.2;
% p=genmodpara(idxN);
% S=mvskcurve(p,muoverline,method);
% save(['stdmvskef','.mat'],'S');
figure(1)
drawmvfig('stdmvskef.mat',1,'s');
savefigtofile('benchmarkmv');
figure(2)
drawskfig('stdmvskef.mat',1,'s');
savefigtofile('benchmarksk');
%% 
% Second Step: an example that sk-epsilon crossing the pseudo one 
% corresponding to mv efficient frontier
%-----------------------------------------------------------------
% idxN=[5 12 47 48 38]; method=1; muoverline=1.2;
% p=genmodpara(idxN);
% S=mvskcurve(p,muoverline,method);
% save(['mvskef_1','.mat'],'S');
figure(1)
hold on;
drawmvfig('mvskef_1.mat',2);
drawmvfig('stdmvskef.mat',1);
figure(2)
hold on;
drawskfig('mvskef_1.mat',2,'s');
drawskfig('stdmvskef.mat',1,'s');
savefigtofile('pseudoskvssk');

%%
%Third Step: generate 10 pseudo curves 
%(including the previous one, some crossing, some not) 
% idxN=[5 12 47 48 38]; method=1; muoverline=1.2;
% p=genmodpara(idxN);
% for i=2:9
% S=mvskcurve(p,muoverline,method);
% save(['mvskef_',num2str(i),'.mat'],'S');
% end
figure(1)
hold on;
for i=1:9
drawmvfig(['mvskef_',num2str(i),'.mat'],2);
end
drawmvfig('stdmvskef.mat',1);
figure(2)
hold on;
for i=1:9
drawskfig(['mvskef_',num2str(i),'.mat'],2,'s');
end
drawskfig('stdmvskef.mat',1,'s');
savefigtofile('10sk');
%%
%Fourth Step: generate 10 thousands pseudo curves 
%--------------------------------------------------------------
%gengerate data
idxN=[5 12 47 48 38]; method=1; muoverline=1.2;
p=genmodpara(idxN);
points=10000;
mkdir('mvskcurve_bis');
mkdir('mvskcurve_bis/mean');
mkdir('mvskcurve_bis/variance');
mkdir('mvskcurve_bis/skewness');
mkdir('mvskcurve_bis/kurtosis');
for i=1:points
S=mvskcurve(p,muoverline,method);
fprintf('%d/%d\n',i,points);
Smean=S.mean;
Svariance=S.variance;
Skurtosis=S.kurtosis;
Sskewness=S.skewness;
save(['mvskcurve_bis/mean/',num2str(i),'.mat'],'Smean');
save(['mvskcurve_bis/variance/',num2str(i),'.mat'],'Svariance');
save(['mvskcurve_bis/skewness/',num2str(i),'.mat'],'Sskewness');
save(['mvskcurve_bis/kurtosis/',num2str(i),'.mat'],'Skurtosis');
%save(['mvskcurve_bis','/','mvskef_',num2str(i),'.mat'],'S');
end

%%
datafilenamelst= dir(['mvskcurve_bis','/','*.mat']);
figure(1)
hold on;
X=zeros(100,length(datafilenamelst));
Y=X;
for i=1:length(datafilenamelst)
    load(['mvskcurve_bis','/', datafilenamelst(i).name])
    X(:,i)=S.kurtosis';
    Y(:,i)=S.skewness';
    fprintf('%.2f%%\n',100*i/length(datafilenamelst));
end
%%
hold on;
scatter(X(:),Y(:),5,'filled','g');
%plot(X(1:4:end,:),Y(1:4:end,:),'--go','MarkerSize',5,'LineWidth',1.5);
%plot(X(:,1:50:end),Y(:,1:50:end),'--go','MarkerSize',5,'LineWidth',1.5);%,...
          %   'MarkerFaceColor',[0,1,0]);    
drawskfig('stdmvskef.mat',1);
%%
savefigtofile('10thousands');

