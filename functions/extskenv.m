function results=extskenv(nameprefix)
% generate directory names
m=[nameprefix,'mean'];

v=[nameprefix,'variance'];

s=[nameprefix,'skewness'];

k=[nameprefix,'kurtosis'];
datafilenamelist=dir([s,'/*.mat']);
step=0.4;%0.2
tol=step/2;
minrange=0;
maxrange=80;%40;
len=ceil((maxrange-minrange)/step)+1;
results.m=inf(1,len);
results.v=results.m;
results.s=results.m;
results.k=results.m;
% results.e=zeros(len,5);


for i=1:length(datafilenamelist)
    M=load([m,'/',datafilenamelist(i).name]);
    V=load([v,'/',datafilenamelist(i).name]);
    S=load([s,'/',datafilenamelist(i).name]);
    K=load([k,'/',datafilenamelist(i).name]);
    %E=load([ep','/',datafilenamelist(i).name]);
    mm=M.Smean;
    vv=V.Svariance;
    ss=S.Sskewness;
    kk=K.Skurtosis;
%     ee=E.Sepsilon;
    for l=1:length(ss)
        %case 1: tol=step/2
        if tol==step/2
            if ss(l)<=maxrange+tol && ss(l)>=minrange-tol
                idx=floor((ss(l)-minrange+tol)/step)+1;
                if results.k(idx)>kk(l)
                    results.m(idx)=mm(l);
                    results.v(idx)=vv(l);
                    results.s(idx)=ss(l);
                    results.k(idx)=kk(l);
%                     results.e(idx,:)=ee(l,:);
                end
            end
            %case 2: tol<step/2
        else
            if ss(l)<=maxrange+tol && ss(l)>=minrange-tol
                d=(ss(l)-minrange)/step;
                intpart=round(d);
                dt1=(ss(l)-minrange-tol)/step;
                dt2=(ss(l)-minrange+tol)/step;
                if (d>intpart && dt1<intpart)||(d<intpart && dt2>intpart)
                    idx=intpart+1;
                    if results.k(idx)>kk(l)
                        results.m(idx)=mm(l);
                        results.v(idx)=vv(l);
                        results.s(idx)=ss(l);
                        results.k(idx)=kk(l);
%                         results.k(idx,:)=ee(l,:);
                    end
                end
            end
            
        end
    end
fprintf('the %d/%d is done \n',i,length(datafilenamelist));
end
end