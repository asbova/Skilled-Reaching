function h_fig = plotTotalReach(exptSummary)

plotIndiv = true; % plot individual data points for each rat under average

retrainSess = 1:2;
laserSess = 3:12;
occludedSess = 13:22;

maxValue = 2;

patchX = [2.5 12.5 12.5 2.5];
patchY = [0 0 2 2];

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
avgRetrain = nanmean(exptSummary.num_trials(1:2,:));
for i = 1:size(avgRetrain,2)
    normData(:,i) = exptSummary.num_trials(1:22,i)./avgRetrain(i);
end
avgData = nanmean(normData,2);
numDataPts = sum(~isnan(exptSummary.num_trials),2);
errBars = nanstd(normData,0,2)./sqrt(numDataPts);

% plot Indiv
if plotIndiv
    for i = 1:size(normData,2)
        plot(1:22,normData(:,i),'-o','MarkerSize',indMarkerSize,'Color',indivColor,'MarkerEdgeColor',indivColor,'MarkerFaceColor',indivColor);
        hold on
    end 
    set(gca,'ylim',[0 3],'ytick',[0 1 2 3]);
%     patch(patchX,[.5 .5 1 1],figColor,'FaceAlpha',.07,'LineStyle','none')
    patch(patchX,[2 2 3 3],figColor,'FaceAlpha',.07,'LineStyle','none')
    text(3.25,2.9,textLaser)
    text(13.25,2.9,textOcclude)
end 

% plot average
hold on
scatter(retrainSess,avgData(retrainSess),avgMarkerSize,'MarkerEdgeColor','k');
scatter(laserSess,avgData(laserSess),avgMarkerSize,'filled','MarkerEdgeColor',figColor,'MarkerFaceColor',figColor);
scatter(occludedSess,avgData(occludedSess),avgMarkerSize,'MarkerEdgeColor',figColor);
e = errorbar(retrainSess,avgData(retrainSess),errBars(retrainSess),'linestyle','none');
e1 = errorbar(3:22,avgData(3:22),errBars(3:22),'linestyle','none');

e.Color = 'k';
e1.Color = figColor;

line([0 23],[1 1],'Color','k')
patch(patchX,patchY,figColor,'FaceAlpha',0.07,'LineStyle','none')

ylabel('normalized trials/session')
xlabel('session number')
set(gca,'xlim',[0 23]);
set(gca,'xtick',[1 2 3 12 13 22]);
set(gca,'xticklabels',[1 2 1 10 1 10]);
set(gca,'FontSize',10);
box off

if ~plotIndiv
    set(gca,'ylim',[0 maxValue]);
    set(gca,'ytick',[0 1 2]);
    text(3.25,1.9,textLaser)
    text(13.25,1.9,textOcclude)
end 