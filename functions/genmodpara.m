function p=genmodpara(idxN)
%Input:
%      idxN: a stock number
%Output:
%      p   : a struct including the following information:
%          e,V,AssetSkewness,AssetKurtosis,A,B,C,D
%          
[N,T0,stockreturn] = Inputdata_industry(100);
N0=length(idxN);
[e,V,AssetSkewness,AssetKurtosis] = AssetMoments(stockreturn(1:T0,idxN),N0,T0);
% shorthand matrix
A = (ones(N0,1)'/V)*e;
B = (e'/V)*e;
C = (ones(N0,1)'/V)*ones(N0,1);
D = B*C-A^2;
p.e=e;
p.V=V;
p.AssetSkewness=AssetSkewness;
p.AssetKurtosis=AssetKurtosis;
p.A=A;
p.B=B;
p.C=C;
p.D=D;
p.N0=length(idxN);
end