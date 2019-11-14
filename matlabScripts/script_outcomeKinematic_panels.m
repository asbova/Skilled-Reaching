pdfName = 'outcomeKinematics4.pdf';
pdfDir = '/Users/alexandrabova/Box Sync/Leventhal Lab/Manuscripts/Skilled Reaching Opto/figures';
pdfName = fullfile(pdfDir,pdfName);

txtSz = 12;
xLabelText = 'session number';

% set figure properties
% set figure properties
kinem_figProps.m = 4;
kinem_figProps.n = 4;

kinem_figProps.panelWidth = ones(kinem_figProps.n,1) * 8;
kinem_figProps.panelHeight = ones(kinem_figProps.m,1) * 6;

kinem_figProps.colSpacing = ones(kinem_figProps.n-1,1) * 0.2;
kinem_figProps.rowSpacing = ones(kinem_figProps.m-1,1) * .4;

kinem_figProps.width = 35.5;
kinem_figProps.height = 27;

kinem_figProps.topMargin = .3;
kinem_figProps.leftMargin = .5;

[h_fig,h_axes] = createFigPanels5(kinem_figProps);

txtSz = 10;
xLabelText = 'session number';

% plot end point by outcome in row 1
for i = 1:4
    axes(h_axes(1,i))
    plotOutcomeEndPoint(exptOutcomeSummary(i))
    set(gca,'xlabel',[])
    set(gca,'FontSize',txtSz);
    set(gca,'XTickLabel',{' '})
    if i > 1
        set(gca,'YTickLabel',{' '})
        set(gca,'ylabel',[])
    end 
    if i < 4
        legend('off')   
    end 
end 

% plot aperture at reach end by outcome in row 2
for i = 1:4
    axes(h_axes(2,i))
    plotOutcomeAperture(exptOutcomeSummary(i))
    set(gca,'xlabel',[])
    set(gca,'FontSize',txtSz);
    set(gca,'XTickLabel',{' '})
    legend('off')
    if i > 1
        set(gca,'YTickLabel',{' '})
        set(gca,'ylabel',[])
    end 
end 

% plot orientation at reach end by outcome in row 3
for i = 1:4
    axes(h_axes(3,i))
    plotOutcomeOrientation(exptOutcomeSummary(i))
    set(gca,'xlabel',[])
    set(gca,'FontSize',txtSz);
    set(gca,'XTickLabel',{' '})
    legend('off')
    if i > 1
        set(gca,'YTickLabel',{' '})
        set(gca,'ylabel',[])
    end 
end 

% plot velocity by outcome in row 4
for i = 1:4
    axes(h_axes(4,i))
    plotOutcomeVelocity(exptOutcomeSummary(i))
    set(gca,'xlabel',[])
    set(gca,'FontSize',txtSz);
    legend('off')
    if i > 1
        set(gca,'YTickLabel',{' '})
        set(gca,'ylabel',[])
    end 
end 

h_figAxis = createFigAxes(h_fig);
axes(h_figAxis);
text(.475,.025,xLabelText,'FontSize',txtSz)

fig=gcf;
fig.PaperUnits = 'centimeters';
fig.PaperPosition = [0 0 kinem_figProps.width kinem_figProps.height];
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];

print(pdfName,'-dpdf');