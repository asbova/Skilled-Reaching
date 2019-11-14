function h_fig = plotIndNumReach(exptSummary)

minValue = -1;
maxValue = 3;

indMarkerSize = 5;
markerColor = 'k';

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

%
for k = 1:22
    for i = 1:size(exptSummary.mean_num_reaches,2)
        data(k,i) = exptSummary.mean_num_reaches(k,i) - exptSummary.mean_num_reaches(2,i);
    end
end 

avgData = nanmean(data,2);
plotData = [data(3,:); data(7,:); data(12,:); data(13,:); data(22,:)]; 
plotAvgData = [avgData(3,1) avgData(7,1) avgData(12,1) avgData(13,1) avgData(22,1)]; 

b = bar(plotAvgData);
hold on

for i = 1:size(plotData,2)
    plot(1:5,plotData(:,i),'-o','MarkerSize',indMarkerSize,'Color',markerColor,'MarkerEdgeColor',markerColor,'MarkerFaceColor',markerColor);
end 

b.FaceColor = figColor;

set(gca,'xticklabels',{'laser 1', 'laser 5', 'laser 10', 'occluded 1', 'occluded 10'});
ylabel('change in num reaches/trial')
set(gca,'ylim',[minValue maxValue]);
set(gca,'FontSize',10);
xtickangle(45)
box off
