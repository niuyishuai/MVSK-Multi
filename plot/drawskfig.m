function drawskfig(filemat,ops,sb)
    if nargin<3
        sb='b';
    end
    load(filemat);
    switch ops
        case 1
            plot([S.kurtosis],[S.skewness],'-ro',...
                'LineWidth',1.5,...
                'MarkerFaceColor',[1,0,0])
        case 2
            plot([S.kurtosis],[S.skewness],'--go',...
                'LineWidth',1.5,...
                'MarkerFaceColor',[0,1,0])
    end
    if sb== 's'
        setupsmallfig;
        xlabel('kurtosis','FontWeight','bold','FontSize',17.5);
        ylabel('skewness','FontWeight','bold','FontSize',17.5);
    else
        setupfig;
        xlabel('kurtosis','FontWeight','bold','FontSize',13.5);
        ylabel('skewness','FontWeight','bold','FontSize',13.5);
    end
end