function setupfig
    h=gcf;
    % ���� figure����
    set(h,'InvertHardcopy','off','PaperUnits','points',...
        'Color',[1 1 1],...
        'Renderer','painters',...
        'position',[100 300 800 530]);
    %'PaperPositionMode','auto',...
        
    % ����������
    axes1 = gca; %axes('Parent',h); 
    box(axes1,'on');
    set(axes1,'looseInset',[0 0 0 0]);
    
    % ������������������
    %set(axes1,'FontSize',13.5,'LineWidth',0.634920634920635);
end