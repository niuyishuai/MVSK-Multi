function S=mvskcurve(p,muoverline,method)
% This script is to generate mean and variance for mv-efficient frontier
% and  skewness and kurtosis for sk-efficient frontier
% p            :a struct
% muoverline   :upper bound of mu;
% method       :strategy of chongsing epsilon
npoints=100;
e=p.e;
V=p.V;
AssetSkewness=p.AssetSkewness;
AssetKurtosis=p.AssetKurtosis;
A=p.A;
B=p.B;
C=p.C;
D=p.D;
N0=p.N0;
x0 = 1; % the initiate wealth
muunderline=A/C*x0;
a1= (x0/D)*(B*(V\ones(N0,1))-A*(V\e));
b = (1/D)*(C*(V\e)-A*(V\ones(N0,1)));
mu0=muunderline+(muoverline-muunderline)*rand;
epsilon=genepsilon(a1,b,mu0,e,method);
a=a1+epsilon;
S.mean=zeros(1,npoints);
S.variance=S.mean;
S.skewness=S.mean;
S.kurtosis=S.mean;
mu=linspace(muunderline,muoverline,npoints);
for i=1:length(mu)
    w=(a+b*mu(i))';
    S.mean(i)=e'*w';              % expected return on a portfolio 
    S.variance(i)=w*V*w';              % portfolio standard deviation
    S.skewness(i)=w*AssetSkewness*kron(w',w');% portfolio skewness
    S.kurtosis(i)=w*AssetKurtosis*kron(kron(w',w'),w');% portfolio kurtosis
end
S.epsilon=epsilon;
end
