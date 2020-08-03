function [AssetMean,AssetCovar,AssetSkewness,AssetKurtosis] = AssetMoments(AssetReturns,N,T0)

[AssetMean, AssetCovar] = ecmnmle(AssetReturns, [], 10000);
AssetCovar = (N/(N - 1))*AssetCovar;

% ComAssetReturnsutation of M3, the co-skewness matrix
AssetSkewness=[];
for i=1:N
    S=[];
    for j=1:N
        for k=1:N
            u=0;
            for t=1:T0
                u=u+((AssetReturns(t,i)-mean(AssetReturns(:,i)))*(AssetReturns(t,j)-mean(AssetReturns(:,j))) ...
                    *(AssetReturns(t,k)-mean(AssetReturns(:,k))));
            end
            S(j,k)=u/T0; 
        end
    end
    AssetSkewness=[AssetSkewness S];
end

% ComAssetReturnsutation of M4, the co-kurtosis matrix
AssetKurtosis=[];
for i=1:N
    for j=1:N
        S=[];
        for k=1:N
            for l=1:N
                u=0;
                for t=1:T0 
                    u=u+((AssetReturns(t,i)-mean(AssetReturns(:,i)))*(AssetReturns(t,j)-mean(AssetReturns(:,j)))* ...
                        (AssetReturns(t,k)-mean(AssetReturns(:,k)))*(AssetReturns(t,l)-mean(AssetReturns(:,l))));
                end
                S(k,l)=u/T0;
            end
        end
        AssetKurtosis=[AssetKurtosis S];
    end
end

