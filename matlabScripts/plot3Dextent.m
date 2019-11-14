function h_fig = plot3Dextent(exptSummary)

% load('/Volumes/SharedX/Neuro-Leventhal/analysis/rat kinematic summaries/experiment_summaries.mat');

retrainSess = 1:2;
laserSess = 3:12;
occludedSess = 13:22;

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

%plot

for i = 1:3
    avgDigData(i,:) = nanmean(exptSummary.mean_dig2_endPt(:,:,i));
end 

for i = 1:3
    avgDorsumData(i,:) = nanmean(exptSummary.mean_pd_endPt(:,:,i));
end 

scatter3(avgDigData(1,retrainSess),avgDigData(3,retrainSess),avgDigData(2,retrainSess),'k')
hold on
scatter3(avgDigData(1,laserSess),avgDigData(3,laserSess),avgDigData(2,laserSess),'filled','MarkerEdgeColor',figColor,'MarkerFaceColor',figColor)
scatter3(avgDigData(1,occludedSess),avgDigData(3,occludedSess),avgDigData(2,occludedSess),'MarkerEdgeColor',figColor)
scatter3(0,0,0,'*','k')

d = scatter3(avgDorsumData(1,retrainSess),avgDorsumData(3,retrainSess),avgDorsumData(2,retrainSess),'k');
hold on
d1 = scatter3(avgDorsumData(1,laserSess),avgDorsumData(3,laserSess),avgDorsumData(2,laserSess),'filled','MarkerEdgeColor',figColor,'MarkerFaceColor',figColor);
d2 = scatter3(avgDorsumData(1,occludedSess),avgDorsumData(3,occludedSess),avgDorsumData(2,occludedSess),'MarkerEdgeColor',figColor);

transValue = 0.5;

d.MarkerEdgeAlpha = transValue;
d1.MarkerFaceAlpha = transValue;
d1.MarkerEdgeAlpha = transValue;
d2.MarkerEdgeAlpha = transValue;

% patch([-30 10 10 -30],[0 0 0 0],[10 10 -20 -20],'k','FaceAlpha',.07)

set(gca,'zdir','reverse')
set(gca,'xlim',[-30 10])
set(gca,'ylim',[-15 20])
set(gca,'zlim',[-20 10])
set(gca,'view',[-70 35])
set(gca,'ztick',[-20 -10 0 10]);
set(gca,'xtick',[-30 -20 -10 0 10]);

legend('retraining','laser on','occluded');

xlabel('x (mm)')
ylabel('z (mm)')
zlabel('y (mm)')
