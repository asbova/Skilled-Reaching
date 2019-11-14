function h_fig = plotAperture(exptSummary)

plotIndiv = true; % plot individual data points for each rat under average

retrainSess = 1:2;
laserSess = 3:12;
occludedSess = 13:22;

minValue = 10;
maxValue = 20;

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
avgData = nanmean(exptSummary.mean_end_aperture,2);
numDataPts = sum(~isnan(exptSummary.mean_end_aperture),2);
errBars = nanstd(exptSummary.mean_end_aperture,0,2)./sqrt(numDataPts);

% plot individual data points
if plotIndiv
    for i = 1:size(exptSummary.mean_end_aperture,2)
        plot(1:22,exptSummary.mean_end_aperture(:,i),'-o','MarkerSize',indMarkerSize,'Color',indivColor,'MarkerEdgeColor',indivColor,'MarkerFaceColor',indivColor);
        hold on
    end 
    set(gca,'ylim',[5 25],'ytick',[5 10 15 20 25]);
    patch(patchX,[5 5 10 10],figColor,'FaceAlpha',.07,'LineStyle','none')
    patch(patchX,[20 20 25 25],figColor,'FaceAlpha',.07,'LineStyle','none')
end 

% plot averaged data
hold on
scatter(retrainSess,avgData(retrainSess),avgMarkerSize,'MarkerEdgeColor','k');
scatter(laserSess,avgData(laserSess),avgMarkerSize,'filled','MarkerEdgeColor',figColor,'MarkerFaceColor',figColor);
scatter(occludedSess,avgData(occludedSess),avgMarkerSize,'MarkerEdgeColor',figColor);
e = errorbar(retrainSess,avgData(retrainSess),errBars(retrainSess),'linestyle','none');
e1 = errorbar(3:22,avgData(3:22),errBars(3:22),'linestyle','none');

e.Color = 'k';
e1.Color = figColor;

line([0 23],[0 0],'Color','k')
patch(patchX,patchY,figColor,'FaceAlpha',0.07,'LineStyle','none')

% figure settings
ylabel('aperture at reach end (mm)')
xlabel('session number')
set(gca,'xlim',[0 23]);
set(gca,'xtick',[1 2 3 12 13 22]);
set(gca,'xticklabels',[1 2 1 10 1 10]);
set(gca,'FontSize',10);
box off

if ~plotIndiv
    set(gca,'ylim',[minValue maxValue]);
    set(gca,'ytick',[10 15 20]);
end 

% text(3.1,maxValue-1.2,textLaser)
% text(13.1,maxValue-1.2,textOcclude)

