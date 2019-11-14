function h_fig = plotFirstSuccess(exptSummary)

plotIndiv = true; % plot individual data points for each rat under average

retrainSess = 1:2;
laserSess = 3:12;
occludedSess = 13:22;

maxValue = 1.5;

patchX = [2.5 12.5 12.5 2.5];
patchY = [0 0 maxValue maxValue];

avgMarkerSize = 45;
indMarkerSize = 4;

textLaser = 'Laser On';
textOcclude = 'Occluded';

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

indivColor = [.85 .85 .85];

% calculate averages, stdevs
avgRetrain = nanmean(exptSummary.firstReachSuccess(1:2,:));
for i = 1:size(avgRetrain,2)
    normData(:,i) = exptSummary.firstReachSuccess(1:22,i)./avgRetrain(i);
end
avgData = nanmean(normData,2);
numDataPts = sum(~isnan(exptSummary.firstReachSuccess),2);
errBars = nanstd(normData,0,2)./sqrt(numDataPts);

% plot individual
if plotIndiv
    for i = 1:size(normData,2)
        plot(1:22,normData(:,i),'-o','MarkerSize',indMarkerSize,'Color',indivColor,'MarkerEdgeColor',indivColor,'MarkerFaceColor',indivColor);
        hold on
    end 
    set(gca,'ylim',[-.25 3],'ytick',[0 1 2 3]);
    patch(patchX,[-.5 -.5 0 0],figColor,'FaceAlpha',.07,'LineStyle','none')
    patch(patchX,[1.5 1.5 3 3],figColor,'FaceAlpha',.07,'LineStyle','none')
    text(3.25,2.9,textLaser)
    text(13.25,2.9,textOcclude)
end 

%plot average
hold on
scatter(retrainSess,avgData(retrainSess),avgMarkerSize,'MarkerEdgeColor','k');
scatter(laserSess,avgData(laserSess),avgMarkerSize,'filled','MarkerEdgeColor',figColor,'MarkerFaceColor',figColor);
scatter(occludedSess,avgData(occludedSess),avgMarkerSize,'MarkerEdgeColor',figColor);
e = errorbar(retrainSess,avgData(retrainSess),errBars(retrainSess),'linestyle','none');
e1 = errorbar(3:22,avgData(3:22),errBars(3:22),'linestyle','none');

e.Color = 'k';
e1.Color = figColor;

%figure properties
line([0 23],[1 1],'Color','k')
patch(patchX,patchY,figColor,'FaceAlpha',0.07,'LineStyle','none')

ylabel('normalized first reach success')
xlabel('session number')
set(gca,'xlim',[0 23]);
set(gca,'xtick',[3 12 13 22]);
set(gca,'xticklabels',[1 10 1 10]);
set(gca,'FontSize',10);
box off

if ~plotIndiv
    set(gca,'ylim',[0 maxValue]);
    set(gca,'ytick',[0 1 maxValue]);
    text(5.75,maxValue+.03,textLaser)
    text(16,maxValue+.03,textOcclude)
end 