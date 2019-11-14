function h_fig = plotNormOrient(exptSummary)

retrainSess = 1:2;
laserSess = 3:12;
occludedSess = 13:22;

minValue = .5;
maxValue = 1.5;

patchX = [2.5 12.5 12.5 2.5];
patchY = [minValue minValue maxValue maxValue];

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

% calculate averages, stdevs, and plot
avgRetrain = nanmean(exptSummary.mean_end_orientations(1:2,:));
for i = 1:size(avgRetrain,2)
    normData(:,i) = exptSummary.mean_end_orientations(1:22,i)./avgRetrain(i);
end
avgData = nanmean(normData,2);
numDataPts = sum(~isnan(exptSummary.mean_end_orientations),2);
errBars = nanstd(normData,0,2)./sqrt(numDataPts);

hold on
scatter(retrainSess,avgData(retrainSess),'MarkerEdgeColor','k');
scatter(laserSess,avgData(laserSess),'filled','MarkerEdgeColor',figColor,'MarkerFaceColor',figColor);
scatter(occludedSess,avgData(occludedSess),'MarkerEdgeColor',figColor);
e = errorbar(retrainSess,avgData(retrainSess),errBars(retrainSess),'linestyle','none');
e1 = errorbar(3:22,avgData(3:22),errBars(3:22),'linestyle','none');

e.Color = 'k';
e1.Color = figColor;

line([0 23],[0 0],'Color','k')
patch(patchX,patchY,figColor,'FaceAlpha',0.07,'LineStyle','none')
text(5.75,maxValue+.03,textLaser)
text(16,maxValue+.03,textOcclude)

ylabel('normalized orientation reach end')
xlabel('session number')
set(gca,'ylim',[minValue maxValue]);
set(gca,'xlim',[0 23]);
set(gca,'ytick',[.5 1 1.5]);
set(gca,'xtick',[3 12 13 22]);
set(gca,'xticklabels',[1 10 1 10]);
set(gca,'FontSize',10);