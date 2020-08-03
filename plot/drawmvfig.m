function drawmvfig(filemat,ops)
load(filemat);
setupfig;
switch ops
    case 1
        plot([S.variance],[S.mean],'-ro',...
            'LineWidth',1,...
            'MarkerFaceColor',[1,0,0])
    case 2
        plot([S.variance],[S.mean],'--bo',...
            'LineWidth',1.5,...
            'MarkerFaceColor',[0,1,0])
end
xlabel('variance','FontWeight','bold','FontSize',13.5);
ylabel('mean','FontWeight','bold','FontSize',13.5);
end