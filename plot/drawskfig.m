function drawskfig(filemat,ops)
load(filemat);
setupfig;
switch ops
    case 1
        plot([S.kurtosis],[S.skewness],'-ro',...
            'LineWidth',1.5,...
            'MarkerFaceColor',[1,0,0])
    case 2
        plot([S.kurtosis],[S.skewness],'--bo',...
            'LineWidth',1.5,...
             'MarkerFaceColor',[0,1,0])
end
xlabel('kurtosis','FontWeight','bold','FontSize',13.5);
ylabel('skewness','FontWeight','bold','FontSize',13.5);
end