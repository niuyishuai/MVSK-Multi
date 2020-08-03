function setupfig
    h=gcf;
    % 设置 figure属性
    set(h,'InvertHardcopy','off','PaperUnits','points',...
        'Color',[1 1 1],...
        'Renderer','painters',...
        'position',[100 300 800 530]);
    %'PaperPositionMode','auto',...
        
    % 设置坐标轴
    axes1 = gca; %axes('Parent',h); 
    box(axes1,'on');
    set(axes1,'looseInset',[0 0 0 0]);
    
    % 设置其余坐标区属性
    %set(axes1,'FontSize',13.5,'LineWidth',0.634920634920635);
end