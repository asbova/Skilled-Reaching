pdfName = 'figure4.pdf';
pdfDir = '/Users/alexandrabova/Box Sync/Leventhal Lab/Manuscripts/Skilled Reaching Opto/figures';
pdfName = fullfile(pdfDir,pdfName);

% set figure properties
kinem_figProps.m = 4;
kinem_figProps.n = 3;

kinem_figProps.panelWidth = ones(kinem_figProps.n,1) * 8;
kinem_figProps.panelHeight = ones(kinem_figProps.m,1) * 5;

kinem_figProps.colSpacing = ones(kinem_figProps.n-1,1) * 1.3;
kinem_figProps.rowSpacing = ones(kinem_figProps.m-1,1) * .9;

kinem_figProps.width = 30;
kinem_figProps.height = 28;

kinem_figProps.topMargin = 4.2;
kinem_figProps.leftMargin = .5;

[h_fig,h_axes] = createFigPanels5(kinem_figProps);

txtSz = 10;
xLabelText = 'z (mm)';

% plot aperture trajectories in col 1
for i = 1:4
    axes(h_axes(i,1))
    plotAperTraj(exptSummary(i))
    set(gca,'FontSize',txtSz);
    set(gca,'xlabel',[])
    if i < 4
        set(gca,'XTickLabel',{' '})
    end 
end 

% plot orientation trajectories in col 2
for i = 1:4
    axes(h_axes(i,2))
    plotOrientTraj(exptSummary(i))
    set(gca,'FontSize',txtSz);
    set(gca,'xlabel',[])
    if i < 4
        set(gca,'XTickLabel',{' '})
    end 
end 

% plot MRL trajectories in col 3
for i = 1:4
    axes(h_axes(i,3))
    plotMRLtraj(exptSummary(i))
    set(gca,'xlabel',[])
    set(gca,'FontSize',txtSz);
    if i < 4
        set(gca,'XTickLabel',{' '})
    end 
end 

h_figAxis = createFigAxes(h_fig);
axes(h_figAxis);
text(.475,.015,xLabelText,'FontSize',txtSz)

fig=gcf;
fig.PaperUnits = 'centimeters';
fig.PaperPosition = [0 0 kinem_figProps.width kinem_figProps.height];
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];

print(pdfName,'-dpdf');