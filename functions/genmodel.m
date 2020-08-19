function obj=genmodel(p,method)
x0=1;
obj.muunderline=p.A/p.C*x0;
a1 = (x0/p.D)*(p.B*(p.V\ones(p.N0,1))-p.A*(p.V\p.e));
b = (1/p.D)*(p.C*(p.V\p.e)-p.A*(p.V\ones(p.N0,1)));

% mu0=muunderline+(muoverline-muunderline)*rand;
mu0=obj.muunderline;
obj.epsilon=genepsilon(a1,b,mu0,p.e,method);
a=a1+obj.epsilon;
obj.a=a;
obj.b=b;

Kaa=kron(a,a);
Kbb=kron(b,b);
theta0 = a'*p.AssetSkewness*Kaa;
theta1 = 3*b'*p.AssetSkewness*Kaa;
theta2 = 3*a'*p.AssetSkewness*Kbb;
theta3 = b'*p.AssetSkewness*Kbb;

Kaaa=kron(Kaa,a);
Kaab=kron(Kaa,b);
Kabb=kron(a,Kbb);
Kbbb=kron(Kbb,b);
gamma0 = a'*p.AssetKurtosis*Kaaa;
gamma1 = 4*b'*p.AssetKurtosis*Kaaa;
gamma2 = 6*b'*p.AssetKurtosis*Kaab;
gamma3 = 4*b'*p.AssetKurtosis*Kabb;
gamma4 = b'*p.AssetKurtosis*Kbbb;
obj.f1=-[0,theta3,theta2,theta1,theta0];
obj.f2=[gamma4,gamma3,gamma2,gamma1,gamma0];
end