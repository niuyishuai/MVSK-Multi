function drawmvfig(filemat,ops,sb)
    if nargin<3
        sb='b';
    end
    load(filemat);
    switch ops
        case 1
            plot([S.variance],[S.mean],'-ro',...
                'LineWidth',1,...
                'MarkerFaceColor',[1,0,0])
        case 2
            plot([S.variance],[S.mean],'--go',...
                'LineWidth',1.5,...
                'MarkerFaceColor',[0,1,0])
    end
    if sb== 's'
        setupsmallfig;
        xlabel('variance','FontWeight','bold','FontSize',17.5);
        ylabel('mean','FontWeight','bold','FontSize',17.5);
    else
        setupfig;
        xlabel('variance','FontWeight','bold','FontSize',13.5);
        ylabel('mean','FontWeight','bold','FontSize',13.5);
    end
end