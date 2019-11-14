pdfName = 'indivKinematics.pdf';
pdfDir = '/Users/alexandrabova/Box Sync/Leventhal Lab/Manuscripts/Skilled Reaching Opto/figures';
pdfName = fullfile(pdfDir,pdfName);

% set figure properties
kinem_figProps.m = 4;
kinem_figProps.n = 4;

kinem_figProps.panelWidth = ones(kinem_figProps.n,1) * 8;
kinem_figProps.panelHeight = ones(kinem_figProps.m,1) * 5;

kinem_figProps.colSpacing = ones(kinem_figProps.n-1,1) * 0.4;
kinem_figProps.rowSpacing = ones(kinem_figProps.m-1,1) * 1.8;

kinem_figProps.width = 37;
kinem_figProps.height = 27.7;

kinem_figProps.topMargin = .3;
kinem_figProps.leftMargin = .5;

[h_fig,h_axes] = createFigPanels5(kinem_figProps);

txtSz = 10;
xLabelText = 'session number';

% plot final z in row 1
for i = 1:4
    axes(h_axes(1,i))
    plotReachExtent(exptSummary(i))
%     set(gca,'xlabel',[])
    set(gca,'FontSize',txtSz);
%     set(gca,'XTickLabel',{' '})
    if i > 1
        set(gca,'YTickLabel',{' '})
        set(gca,'ylabel',[])
    end 
end 

% plot individual changes extent in row 2
for i = 1:4
    axes(h_axes(2,i))
    plotIndExtent(exptSummary(i))
%     set(gca,'xlabel',[])
    set(gca,'FontSize',txtSz);
%     set(gca,'XTickLabel',{' '})
    if i > 1
        set(gca,'YTickLabel',{' '})
        set(gca,'ylabel',[])
    end 
end 

% plot aperture at reach end in row 3
for i = 1:4
    axes(h_axes(3,i))
    plotAperture(exptSummary(i))
    set(gca,'FontSize',txtSz);
    if i > 1
        set(gca,'YTickLabel',{' '})
        set(gca,'ylabel',[])
    end 
end 

% plot individual aperture changes in row 4
for i = 1:4
    axes(h_axes(4,i))
    plotIndAperture(exptSummary(i))
    set(gca,'FontSize',txtSz);
    if i > 1
        set(gca,'YTickLabel',{' '})
        set(gca,'ylabel',[])
    end 
end 
% 
% h_figAxis = createFigAxes(h_fig);
% axes(h_figAxis);
% text(.475,.025,xLabelText,'FontSize',txtSz)

fig=gcf;
fig.PaperUnits = 'centimeters';
fig.PaperPosition = [0 0 kinem_figProps.width kinem_figProps.height];
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];

print(pdfName,'-dpdf');

%%

pdfName = 'indivKinematics2.pdf';
pdfDir = '/Users/alexandrabova/Box Sync/Leventhal Lab/Manuscripts/Skilled Reaching Opto/figures';
pdfName = fullfile(pdfDir,pdfName);

% set figure properties
kinem_figProps.m = 4;
kinem_figProps.n = 4;

kinem_figProps.panelWidth = ones(kinem_figProps.n,1) * 8;
kinem_figProps.panelHeight = ones(kinem_figProps.m,1) * 5;

kinem_figProps.colSpacing = ones(kinem_figProps.n-1,1) * 0.4;
kinem_figProps.rowSpacing = ones(kinem_figProps.m-1,1) * 1.8;

kinem_figProps.width = 37;
kinem_figProps.height = 27.7;

kinem_figProps.topMargin = .3;
kinem_figProps.leftMargin = .5;

[j_fig,j_axes] = createFigPanels5(kinem_figProps);

% plot final z in row 1
for i = 1:4
    axes(j_axes(1,i))
    plotOrientation(exptSummary(i))
%     set(gca,'xlabel',[])
    set(gca,'FontSize',txtSz);
%     set(gca,'XTickLabel',{' '})
    if i > 1
        set(gca,'YTickLabel',{' '})
        set(gca,'ylabel',[])
    end 
end 

% plot individual changes extent in row 2
for i = 1:4
    axes(j_axes(2,i))
    plotIndOrient(exptSummary(i))
%     set(gca,'xlabel',[])
    set(gca,'FontSize',txtSz);
%     set(gca,'XTickLabel',{' '})
    if i > 1
        set(gca,'YTickLabel',{' '})
        set(gca,'ylabel',[])
    end 
end 

% plot aperture at reach end in row 3
for i = 1:4
    axes(j_axes(3,i))
    plotVelocity(exptSummary(i))
    set(gca,'FontSize',txtSz);
    if i > 1
        set(gca,'YTickLabel',{' '})
        set(gca,'ylabel',[])
    end 
end 

% plot individual aperture changes in row 4
for i = 1:4
    axes(j_axes(4,i))
    plotIndVelocity(exptSummary(i))
    set(gca,'FontSize',txtSz);
    if i > 1
        set(gca,'YTickLabel',{' '})
        set(gca,'ylabel',[])
    end 
end 
% 
% h_figAxis = createFigAxes(h_fig);
% axes(h_figAxis);
% text(.475,.025,xLabelText,'FontSize',txtSz)

fig=gcf;
fig.PaperUnits = 'centimeters';
fig.PaperPosition = [0 0 kinem_figProps.width kinem_figProps.height];
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];

print(pdfName,'-dpdf');