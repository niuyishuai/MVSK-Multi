function [mustar,k,status]=Algorithm_A(mu0,F1,F2,muunderline,opt)
k=1;
status=false;
while k<=opt.IMAX
    g=F1;
    h=F2;
    g(end)=F1(end)-polyval(F1,mu0);
    h(end)=F2(end)-polyval(F2,mu0);
    [D,u_mu,mustarI,alphastar]=Algorithm_B(g,h,muunderline,opt.eps);
    infgh=min([polyval(g,mustarI),polyval(h,mustarI)]);
    
    if abs(alphastar)<=opt.eps && (infgh>=-opt.eps)
        [muhat,GHmin]=Algorithm_C(g,h,D,u_mu,opt.eps);
        if GHmin>=-opt.epsstop
            mustar=mu0;
            status=true;
            return;
        else
            mu0=muhat(1);
        end
    else
        mu0=mustarI(1);
    end
    k=k+1;
end
mustar=mu0;
end
%%
function [D,u_mu,mustarI,alphastar]=Algorithm_B(g,h,muunderline,eps)
R=roots(h-g);%solve the  root
R=(R(abs(imag(R))<=eps))';
R=real(R);
chk=(R-muunderline)>=-eps;
R=R(chk);%real root of h-g not less than muunderline
R=unique([R,muunderline,inf],'sorted');%

len=length(R)-1;
D=cell(1,len);
u_mu=cell(1,len);
umin=zeros(1,len);
mustar=cell(1,len);
for k=1:len
    D{k}=[R(k),R(k+1)];
    if isinf(R(k+1))
        hgmid=polyval(h-g,(R(k)+100));
    else
        hgmid=polyval(h-g,(R(k)+R(k+1))/2);
    end
    if hgmid>0
        u_mu{k} = h;
    else
        u_mu{k} = g;
    end
    [mustar{k},umin(k)] = Min_uI(u_mu{k},D{k});
end
alphastar=min(umin);
index=find(umin==alphastar);
mustarI=unique(cell2mat(mustar(index(:))));
end
function [mustar,umin] = Min_uI(u_mu,I)
r=roots(polyder(u_mu));
r=r(imag(r)==0);
r=r(r>=I(1)&r<=I(2));
r=unique([r',I]);
extru_mu=polyval(u_mu,r);
umin=min(extru_mu);
mustar=r(extru_mu==umin);
end
%%
function [muhat,GHmin]=Algorithm_C(g,h,D,u_mu,eps)
R=[];
for i=1:length(u_mu)
    r=roots(u_mu{i});
    r=r(abs(imag(r))<=eps);
    r=real(r);
    chkl=(r-D{i}(1))>=-eps;
    chkr=(D{i}(2)-r)>=-eps;
    r=r(chkl&chkr);
    r=unique(r');
    R=[R,r];
end
G=polyval(g,R);
H=polyval(h,R);
GH=min([G;H]);
GHmin=min(GH);
muhat=R(GH==GHmin);
end