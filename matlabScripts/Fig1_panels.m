pdfName = 'figure1.pdf';
pdfDir = '/Users/alexandrabova/Box Sync/Leventhal Lab/Manuscripts/Skilled Reaching Opto/figures';
pdfName = fullfile(pdfDir,pdfName);

% set figure properties
kinem_figProps.m = 4;
kinem_figProps.n = 4;

kinem_figProps.panelWidth = ones(kinem_figProps.n,1) * 8;
kinem_figProps.panelHeight = ones(kinem_figProps.m,1) * 5;

kinem_figProps.colSpacing = ones(kinem_figProps.n-1,1) * 0.2;
kinem_figProps.rowSpacing = ones(kinem_figProps.m-1,1) * .8;

kinem_figProps.width = 35;
kinem_figProps.height = 24.2;

kinem_figProps.topMargin = .3;
kinem_figProps.leftMargin = .5;

[h_fig,h_axes] = createFigPanels5(kinem_figProps);

txtSz = 10;
xLabelText = 'session number';

%remove axes for top 2 rows (panels A and B - experimental design, trial layout)
for k = 1:2
    for i = 1:4
        axes(h_axes(k,i))
        set(gca,'visible','off')
    end 
end 

% % axes(h_axes(1,1:2))
% timelineFig = imread('expt_timeline2.jpg');
% imshow(timelineFig)
% set(gcf,'position',[1 17 15 10])
% hold on
% 
% virusFig = imread('virus_implant.jpg');
% imshow(virusFig)
% set(gcf,'position',[17 17 13 8])


% plot total reach graphs in 3rd row (panel C-F)
for i = 1:4
    axes(h_axes(3,i))
    plotTotalReach(exptSummary(i))
    set(gca,'xlabel',[])
    set(gca,'FontSize',txtSz);
    set(gca,'XTickLabel',{' '})
    if i > 1
        set(gca,'YTickLabel',{' '})
        set(gca,'ylabel',[])
    end 
end 

% plot first reach success rate in 4th row(panel G-J)
for i = 1:4
    axes(h_axes(4,i))
    plotFirstSuccess(exptSummary(i))
    set(gca,'xlabel',[])
    set(gca,'FontSize',txtSz);
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


