function h_fig = plotReachExtent(exptSummary)

plotIndiv = true; % plot individual data points or not
plotPawDorsum = false; % plot paw dorsum points or not

retrainSess = 1:2;
laserSess = 3:12;
occludedSess = 13:22;

if ~plotPawDorsum && ~plotIndiv
    minValue = -10;
    maxValue = 10;
elseif ~plotPawDorsum
    minValue = -25;
    maxValue = 20;
elseif ~plotIndiv
    minValue = -10;
    maxValue = 25;
else
    minValue = -25;
    maxValue = 35;
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

% calculate averages, stdevs, and plot
% dig2 
% plot individual dig2 data points
if plotIndiv
    for i = 1:size(exptSummary.mean_dig2_endPt,1)
        plot(1:22,exptSummary.mean_dig2_endPt(i,:,3),'-o','MarkerSize',indMarkerSize,'Color',indivColor,'MarkerEdgeColor',indivColor,'MarkerFaceColor',indivColor);
        hold on
    end 
end 

avgData = nanmean(exptSummary.mean_dig2_endPt(:,:,3));
numDataPts = sum(~isnan(exptSummary.mean_dig2_endPt(:,:,3)));
errBars = nanstd(exptSummary.mean_dig2_endPt(:,:,3),0)./sqrt(numDataPts);
hold on
scatter(retrainSess,avgData(retrainSess),avgMarkerSize,'MarkerEdgeColor','k');
scatter(laserSess,avgData(laserSess),avgMarkerSize,'filled','MarkerEdgeColor',figColor,'MarkerFaceColor',figColor);
scatter(occludedSess,avgData(occludedSess),avgMarkerSize,'MarkerEdgeColor',figColor);
e = errorbar(retrainSess,avgData(retrainSess),errBars(retrainSess),'linestyle','none');
e1 = errorbar(3:22,avgData(3:22),errBars(3:22),'linestyle','none');

e.Color = 'k';
e1.Color = figColor;

box off
% paw dorsum
% plot individual dig2 data points
if plotPawDorsum
    if plotIndiv
        for i = 1:size(exptSummary.mean_pd_endPt,1)
            plot(1:22,exptSummary.mean_pd_endPt(i,:,3),'-o','MarkerSize',indMarkerSize,'Color',indivColor,'MarkerEdgeColor',indivColor,'MarkerFaceColor',indivColor);
            hold on
        end 
    end 

    avgDorsumData = nanmean(exptSummary.mean_pd_endPt(:,:,3));
    numDataPtsDorsum = sum(~isnan(exptSummary.mean_pd_endPt(:,:,3)));
    errBarsDorsum = nanstd(exptSummary.mean_pd_endPt(:,:,3),0)./sqrt(numDataPtsDorsum);
    hold on
    d = scatter(retrainSess,avgDorsumData(retrainSess),avgMarkerSize,'MarkerEdgeColor','k');
    d1 = scatter(laserSess,avgDorsumData(laserSess),avgMarkerSize,'filled','MarkerEdgeColor',figColor,'MarkerFaceColor',figColor);
    d2 = scatter(occludedSess,avgDorsumData(occludedSess),avgMarkerSize,'MarkerEdgeColor',figColor);
    e2 = errorbar(retrainSess,avgDorsumData(retrainSess),errBarsDorsum(retrainSess),'linestyle','none');
    e3 = errorbar(3:22,avgDorsumData(3:22),errBarsDorsum(3:22),'linestyle','none');

    transValue = 0.3;

    d.MarkerEdgeAlpha = transValue;
    d1.MarkerFaceAlpha = transValue;
    d1.MarkerEdgeAlpha = transValue;
    d2.MarkerEdgeAlpha = transValue;
    e2.Color = 'k';
    e3.Color = figColor;
end
    
% figure settings
patch(patchX,patchY,figColor,'FaceAlpha',0.07,'LineStyle','none')
line([0 23],[0 0],'Color','k')

ylabel('final z w.r.t pellet (mm)')
xlabel('session number')
set(gca,'ylim',[minValue maxValue])
set(gca,'xlim',[0 23]);
set(gca,'xtick',[1 2 3 12 13 22]);
set(gca,'xticklabels',[1 2 1 10 1 10]);
set(gca,'FontSize',10);
box off

text(3.1,maxValue - 1.2,textLaser)
text(13.1,maxValue - 1.2,textOcclude)

