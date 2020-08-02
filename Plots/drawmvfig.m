function drawmvfig(filemat,ops)
load(filemat);
switch ops
    case 1
        plot([S.variance],[S.mean],'-ro',...
            'LineWidth',1.5,...
            'MarkerFaceColor',[1,0,0])
    case 2
        plot([S.variance],[S.mean],'-go',...
            'LineWidth',1.5,...
             'MarkerFaceColor',[0,1,0])
end
xlabel('variance');
ylabel('mean');
end