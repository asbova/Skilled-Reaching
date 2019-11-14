function h_fig = plotVelocity(exptSummary)

plotIndiv = true;

retrainSess = 1:2;
laserSess = 3:12;
occludedSess = 13:22;

if ~plotIndiv %sets y axis limits
    minValue = 500; 
    maxValue = 900;
else
    minValue = 250; 
    maxValue = 1400;
end

patchX = [2.5 12.5 12.5 2.5];
patchY = [minValue minValue maxValue maxValue];

avgMarkerSize = 45;
indMarkerSize = 4;

textLaser = 'Laser On';
textOcclude = 'Occluded';
txtSz = 12;

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
avgData = nanmean(exptSummary.mean_pd_v,2);
numDataPts = sum(~isnan(exptSummary.mean_pd_v),2);
errBars = nanstd(exptSummary.mean_pd_v,0,2)./sqrt(numDataPts);

% plot individual data points
if plotIndiv
    for i = 1:size(exptSummary.mean_pd_v,2)
        plot(1:22,exptSummary.mean_pd_v(:,i),'-o','MarkerSize',indMarkerSize,'Color',indivColor,'MarkerEdgeColor',indivColor,'MarkerFaceColor',indivColor);
        hold on
    end 
end 

%plot averages
hold on
scatter(retrainSess,avgData(retrainSess),avgMarkerSize,'MarkerEdgeColor','k');
scatter(laserSess,avgData(laserSess),avgMarkerSize,'filled','MarkerEdgeColor',figColor,'MarkerFaceColor',figColor);
scatter(occludedSess,avgData(occludedSess),avgMarkerSize,'MarkerEdgeColor',figColor);
e = errorbar(retrainSess,avgData(retrainSess),errBars(retrainSess),'linestyle','none');
e1 = errorbar(3:22,avgData(3:22),errBars(3:22),'linestyle','none');

e.Color = 'k';
e1.Color = figColor;

% text(5.75,maxValue+.03,textLaser,'FontSize',txtSz)
% text(16,maxValue+.03,textOcclude,'FontSize',txtSz)

%figure properties
line([0 23],[0 0],'Color','k')
patch(patchX,patchY,figColor,'FaceAlpha',0.07,'LineStyle','none')

ylabel('max reach velocity (mm/s)')
xlabel('session number')
set(gca,'xlim',[0 23],'ylim',[minValue maxValue],'xtick',[3 12 13 22],'ytick',minValue:250:maxValue);
set(gca,'xticklabels',[1 10 1 10]);
set(gca,'FontSize',10);
box off