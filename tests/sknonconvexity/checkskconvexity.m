% An example for non-convex SK speudo efficient frontier
% To test other algorithm, you just need to change one line of code:
% Algorithm_A in line 43 by your solver, e.g., linear weighting method 
muoverline=0.07;
method=3; % epsilon = 0
npoints=150; % number of points
idxN=[ 7     5    48     8     9];

p=genmodpara(idxN);
obj=genmodel(p,method);
c1=-obj.f1; % skewness
c2=obj.f2; % kurtosis
muunderline=obj.muunderline;
mu=linspace(muunderline,muoverline,npoints);
dk=polyder(c2);
ddk=polyder(dk);
ds=polyder(c1);
dds=polyder(ds);
D=conv(ddk,conv(ds,ds))-conv(dk,conv(ds,dds));
Dmu=polyval(D,mu);

% plot mu vs Dmu
figure(1)
hold all;
grid on;
plot(mu,Dmu,'-o','LineWidth',1.5);
xlabel('\mu');
ylabel('\Delta(\mu)');

% Plot SK figure
S.kurtosis = polyval(c2,mu);
S.skewness = polyval(c1,mu);
figure(2)
hold all;
grid on;
plot([S.kurtosis],[S.skewness],'-bo',...
    'LineWidth',1.5,...
    'MarkerFaceColor',[0,0,1]);

ops=genoption();
for mu0=mu
    % Todo: replace Algorithm_A by linear weighting method to get Pareto
    % optimal solution mustar
    [mustar,~,status]=Algorithm_A(mu0,obj.f1,obj.f2,muunderline,ops);
    Dmustar=polyval(D,mustar);
    if Dmustar < 0 % draw concave part
        %Dmustar
        %idxN
        figure(1);
        scatter(mustar,Dmustar,'ro','filled');
        xlim(mustar+[-0.1,0.1]);
        ylim(Dmustar+[-0.01,0.01]);
        drawnow;
        figure(2)
        scatter(polyval(c2,mustar),polyval(c1,mustar),'ro','filled');
        drawnow;
    elseif Dmustar > 0 % draw convex part
        %fprintf('%f : %f\n', mustar,Dmustar);
        figure(2)
        scatter(polyval(c2,mustar),polyval(c1,mustar),'go','filled');
        drawnow;
    end
end
figure(2)
setupsmallfig;
xlabel('kurtosis','FontWeight','bold','FontSize',17.5);
ylabel('skewness','FontWeight','bold','FontSize',17.5);
savefigtofile('noncvxsk');

%%
% Plot MV efficient frontier
S=mvskcurve(p,muoverline,method);
figure(3)
hold all;
grid on;
plot([S.variance],[S.mean],'-ro',...
                'LineWidth',1.5,...
                'MarkerFaceColor',[1,0,0]);
setupsmallfig;
xlabel('variance','FontWeight','bold','FontSize',17.5);
ylabel('mean','FontWeight','bold','FontSize',17.5);
savefigtofile('noncvxmv');