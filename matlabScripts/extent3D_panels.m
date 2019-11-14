pdfName = '3d_extent.pdf';
pdfDir = '/Users/alexandrabova/Box Sync/Leventhal Lab/Manuscripts/Skilled Reaching Opto/figures';
pdfName = fullfile(pdfDir,pdfName);

% set figure properties
kinem_figProps.m = 1;
kinem_figProps.n = 4;

kinem_figProps.panelWidth = ones(kinem_figProps.n,1) * 8;
kinem_figProps.panelHeight = ones(kinem_figProps.m,1) * 6;

kinem_figProps.colSpacing = ones(kinem_figProps.n-1,1) * 0.2;
kinem_figProps.rowSpacing = ones(kinem_figProps.m-1,1) * .8;

kinem_figProps.width = 35.5;
kinem_figProps.height = 7.5;

kinem_figProps.topMargin = .3;
kinem_figProps.leftMargin = .5;

[h_fig,h_axes] = createFigPanels5(kinem_figProps);

txtSz = 10;

% plot 3d plots in row
for i = 1:4
    axes(h_axes(1,i))
    plot3Dextent(exptSummary(i))
    set(gca,'FontSize',txtSz);
    legend('off')
    if i > 1
        set(gca,'ZTickLabel',{' '})
        set(gca,'zlabel',[])
        set(gca,'xTickLabel',{' '})
        set(gca,'xlabel',[])
    end
end 

% h_figAxis = createFigAxes(h_fig);
% axes(h_figAxis);
% text(.475,.025,xLabelText,'FontSize',txtSz)

fig=gcf;
fig.PaperUnits = 'centimeters';
fig.PaperPosition = [0 0 kinem_figProps.width kinem_figProps.height];
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];

print(pdfName,'-dpdf');