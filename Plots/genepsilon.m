function epsilon=genepsilon(a,b,mu0,e,method)
switch method
    case 1
        w0=(a+b*mu0)/5;
        n=length(a);
        epsilon=randn(n,1).*w0;
        % min ||x-epsilon||^2 
        %      s.t. ones(n,1)*x=0 
        delta=-sum(epsilon)/n;
        epsilon=epsilon+delta;
    case 2
        w0=(a+b*mu0)/5;
        epsilon=randn(length(a),1).*w0;
        n=length(a);
        % min ||x-epsilon||^2 
        %      s.t.  e'*x=0; 
        %            ones(n,1)*x=0 
        I=ones(n,1);
        A=[[2*eye(n),e,I];[e',0,0];[I',0,0]];
        b=[2*epsilon;0;0];
        x=A\b;
        epsilon=x(1:n);
    case 3
        epsilon=0;
        
end
end