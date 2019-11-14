% set figure properties
kinem_figProps.m = 1;
kinem_figProps.n = 4;

kinem_figProps.panelWidth = ones(kinem_figProps.n,1) * 11;
kinem_figProps.panelHeight = ones(kinem_figProps.m,1) * 9;

kinem_figProps.colSpacing = ones(kinem_figProps.n-1,1) * 0.8;
kinem_figProps.rowSpacing = ones(kinem_figProps.m-1,1) * 1;

kinem_figProps.width = 20*2.54;
kinem_figProps.height = 4.3*2.54;

kinem_figProps.topMargin = .5;
kinem_figProps.leftMargin = 2.54;

[h_fig,h_axes] = createFigPanels5(kinem_figProps);

txtSz = 12;
xLabelText = 'session number';

% plot - change to appropriate function
for i = 1:4
    axes(h_axes(1,i))
    plotVelocity(exptSummary(i))
    set(gca,'xlabel',[])
    set(gca,'FontSize',txtSz);
    if i > 1
        set(gca,'YTickLabel',{' '})
        set(gca,'ylabel',[])
    end 
end 

h_figAxis = createFigAxes(h_fig);
axes(h_figAxis);
text(.475,.05,xLabelText,'FontSize',txtSz)