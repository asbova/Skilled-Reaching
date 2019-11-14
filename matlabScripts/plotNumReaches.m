function h_fig = plotNumReaches(exptSummary)

plotIndiv = true;

retrainSess = 1:2;
laserSess = 3:12;
occludedSess = 13:22;

if ~plotIndiv %sets y axis limits
    minValue = 1; 
    maxValue = 3.5;
else
    minValue = .5; 
    maxValue = 4.5;
end

patchX = [2.5 12.5 12.5 2.5];
patchY = [minValue minValue maxValue maxValue];

avgMarkerSize = 45;
indMarkerSize = 4;

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

indivColor = [.85 .85 .85];

% calculate averages, stdevs
avgData = nanmean(exptSummary.mean_num_reaches,2);
numDataPts = sum(~isnan(exptSummary.mean_num_reaches),2);
errBars = nanstd(exptSummary.mean_num_reaches,0,2)./sqrt(numDataPts);

% plot indiv data
if plotIndiv
    for i = 1:size(exptSummary.mean_num_reaches,2)
        plot(1:22,exptSummary.mean_num_reaches(:,i),'-o','MarkerSize',indMarkerSize,'Color',indivColor,'MarkerEdgeColor',indivColor,'MarkerFaceColor',indivColor);
        hold on
    end 
end 

%plot average data
hold on
scatter(retrainSess,avgData(retrainSess),avgMarkerSize,'MarkerEdgeColor','k');
scatter(laserSess,avgData(laserSess),avgMarkerSize,'filled','MarkerEdgeColor',figColor,'MarkerFaceColor',figColor);
scatter(occludedSess,avgData(occludedSess),avgMarkerSize,'MarkerEdgeColor',figColor);
e = errorbar(retrainSess,avgData(retrainSess),errBars(retrainSess),'linestyle','none');
e1 = errorbar(3:22,avgData(3:22),errBars(3:22),'linestyle','none');

e.Color = 'k';
e1.Color = figColor;

% figure properties
line([0 23],[0 0],'Color','k')
patch(patchX,patchY,figColor,'FaceAlpha',0.07,'LineStyle','none')

ylabel('number reaches/trial')
xlabel('session number')
set(gca,'xlim',[0 23],'ylim',[minValue maxValue],'xtick',[1 2 3 12 13 22],'ytick',minValue:1:maxValue);
set(gca,'xticklabels',[1 2 1 10 1 10]);
set(gca,'FontSize',10);
box off

text(3.25,maxValue-.15,textLaser)
text(13.25,maxValue-.15,textOcclude)