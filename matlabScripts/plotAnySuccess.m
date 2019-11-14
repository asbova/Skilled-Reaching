function h_fig = plotAnySuccess(exptSummary)

retrainSess = 1:2;
laserSess = 3:12;
occludedSess = 13:22;

maxValue = 1.5;

patchX = [2.5 12.5 12.5 2.5];
patchY = [0 0 maxValue maxValue];

textLaser = 'Laser On';
textOcclude = 'Occluded';

%define figure colors for each group
ratGrp = exptSummary.experimentInfo.type;
if strcmpi(ratGrp,'chr2_during')
    figColor = [.12 .16 .67];
elseif strcmpi(ratGrp,'chr2_between')
    figColor = [.23 .84 .94];
elseif strcmpi(ratGrp,'arch_during')
    figColor = [.17 .7 .26];
else strcmpi(ratGrp,'eyfp')
    figColor = [.84 .14 .63];
end

% figure properties
figProps.m = 1;
figProps.n = 1;

figProps.panelWidth = ones(figProps.n,1) * 11;
figProps.panelHeight = ones(figProps.m,1) * 9;

figProps.colSpacing = ones(figProps.n-1,1) * 0.5;
figProps.rowSpacing = ones(figProps.m-1,1) * 1;

figProps.width = 12;
figProps.height = 10;

figProps.topMargin = 5;
figProps.leftMargin = 2.54;

[h_fig,h_axes] = createFigPanels5(figProps);

% calculate averages, stdevs, and plot
avgRetrain = nanmean(exptSummary.anyReachSuccess(1:2,:));
for i = 1:size(avgRetrain,2)
    normData(:,i) = exptSummary.anyReachSuccess(1:22,i)./avgRetrain(i);
end
avgData = nanmean(normData,2);
numDataPts = sum(~isnan(exptSummary.anyReachSuccess),2);
errBars = nanstd(normData,0,2)./sqrt(numDataPts);
hold on
scatter(retrainSess,avgData(retrainSess),'MarkerEdgeColor','k');
scatter(laserSess,avgData(laserSess),'filled','MarkerEdgeColor',figColor,'MarkerFaceColor',figColor);
scatter(occludedSess,avgData(occludedSess),'MarkerEdgeColor',figColor);
e = errorbar(retrainSess,avgData(retrainSess),errBars(retrainSess),'linestyle','none');
e1 = errorbar(3:22,avgData(3:22),errBars(3:22),'linestyle','none');

e.Color = 'k';
e1.Color = figColor;

line([0 23],[1 1],'Color','k')
patch(patchX,patchY,figColor,'FaceAlpha',0.07,'LineStyle','none')
text(5.75,maxValue+.03,textLaser)
text(16,maxValue+.03,textOcclude)

ylabel('normalized any reach success')
xlabel('session number')
set(gca,'ylim',[0 maxValue]);
set(gca,'xlim',[0 23]);
set(gca,'ytick',[0 1 maxValue]);
set(gca,'xtick',[1 2 3 12 13 22]);
set(gca,'xticklabels',[1 2 1 10 1 10]);
set(gca,'FontSize',10);