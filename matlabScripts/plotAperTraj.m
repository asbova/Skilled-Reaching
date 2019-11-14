function h_fig = plotAperTraj(exptSummary)

retrainSess = 1:2;
laserSess = 3:12;
occludedSess = 13:22;

minValue = 5;
maxValue = 20;

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
for i = 1:size(exptSummary.mean_aperture_traj,3)
    avgData(:,i) = nanmean(exptSummary.mean_aperture_traj(:,:,i));
end

for k = laserSess
    plot(avgData(k,:),'Color',figColor)
    hold on
end 

for l = occludedSess
    plot(avgData(l,:),'k')
    hold on
end

line([201 201],[minValue maxValue],'Color','k')

box off
ylabel('aperture (mm)')
xlabel('z (mm)')
set(gca,'ylim',[minValue maxValue]);
set(gca,'xlim',[0 350]);
set(gca,'ytick',[0 10 20]);
set(gca,'xtick',[0 201 350]);
set(gca,'xticklabels',[20 0 -15]);
set(gca,'FontSize',10);