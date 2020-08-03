function S=skoptimizer(p,muoverline,method)
    % Solve SK pareto optimization problem 
    %  S=skoptimizer(p,muoverline,method);
    %   p            :a struct
    %   muoverline   :upper bound of mu;
    %   method       :choosing epsilon method;
    x0=1;
    muunderline=p.A/p.C*x0;
    a1 = (x0/p.D)*(p.B*(p.V\ones(p.N0,1))-p.A*(p.V\p.e));
    b = (1/p.D)*(p.C*(p.V\p.e)-p.A*(p.V\ones(p.N0,1)));
    
    mu0=muunderline+(muoverline-muunderline)*rand;
    epsilon=genepsilon(a1,b,mu0,p.e,method);
    S.epsilon=epsilon;
    a=a1+epsilon;
    
    theta0 = a'*p.AssetSkewness*kron(a,a);
    theta1 = 3*b'*p.AssetSkewness*kron(a,a);
    theta2 = 3*a'*p.AssetSkewness*kron(b,b);
    theta3 = b'*p.AssetSkewness*kron(b,b);
    
    gamma0 = a'*p.AssetKurtosis*kron(kron(a,a),a);
    gamma1 = 4*b'*p.AssetKurtosis*kron(kron(a,a),a);
    gamma2 = 6*b'*p.AssetKurtosis*kron(kron(a,a),b);
    gamma3 = 4*b'*p.AssetKurtosis*kron(kron(a,b),b);
    gamma4 = b'*p.AssetKurtosis*kron(kron(b,b),b);
    c1=[0,theta3,theta2,theta1,theta0];
    c2=[gamma4,gamma3,gamma2,gamma1,gamma0];
    ops=genoption();
    [mustar,~,status]=Algorithm_A(mu0,-c1,c2,muunderline,ops);
%     if status
%         fprintf('Pareto optimal solution found.\n');
%     else
%         fprintf(2,'Max iteration exceed ! Please change your paremeter IMAX: %d \n',ops.IMAX);
%         return;
%     end
    w=(a+b*mustar)';
    S.mean=p.e'*w';      % expected return on a portfolio
    S.variance=w*p.V*w'; % portfolio standard deviation
    S.skewness=w*p.AssetSkewness*kron(w',w'); %portfolio skewness
    S.kurtosis=w*p.AssetKurtosis*kron(kron(w',w'),w');%portfolio kurtosis
end

