function plotOutcomeVelocity(exptOutcomeSummary)

plotAll = false;

avgMarkerSize = 45;

if ~plotAll
    minValue = 300;
    maxValue = 1100;
else 
    minValue = 200;
    maxValue = 1400;
end 

patchX = [2.5 12.5 12.5 2.5];
patchY = [minValue minValue maxValue maxValue];

ratGrp = exptOutcomeSummary.experimentInfo.type;
if strcmpi(ratGrp,'chr2_during')
    patchColor = [.12 .16 .67];
elseif strcmpi(ratGrp,'chr2_between')
    patchColor = [.23 .84 .94];
elseif strcmpi(ratGrp,'arch_during')
    patchColor = [.17 .7 .26];
else strcmpi(ratGrp,'eyfp')
    patchColor = [.84 .14 .63];
end

outcomeColors = {[0 .37 .02],[.32 .94 .36],[.55 .09 .07],'k',[.99 .41 .39], [.63 .63 .63]};

% calculate averages

% calculate averages and standard deviations

for i_outcome = 1:7
    for i_sess = 1:22       
        avgData(i_sess,i_outcome) = nanmean(exptOutcomeSummary.mean_pd_v(i_sess,i_outcome,:));        
    end 
end 

for i_outcome = 1:7
    for i_sess = 1:22 
        numDataPoints = sum(~isnan(exptOutcomeSummary.mean_pd_v(i_sess,i_outcome,:)));
        errBars(i_sess,i_outcome) = nanstd(exptOutcomeSummary.mean_pd_v(i_sess,i_outcome,:),0)./sqrt(numDataPoints);        
    end 
end 

% plot 

if ~plotAll

    for i = [2 4 6]
        scatter(1:22,avgData(1:22,i),avgMarkerSize,'filled','MarkerFaceColor',outcomeColors{i-1});
        hold on
        e = errorbar(1:22,avgData(1:22,i),errBars(1:22,i),'linestyle','none','HandleVisibility','off');
        e.Color = outcomeColors{i-1};
    end
    
else 

     for i = 2:6
        scatter(1:22,avgData(1:22,i),avgMarkerSize,'filled','MarkerFaceColor',outcomeColors{i-1});
        hold on
        e = errorbar(1:22,avgData(1:22,i),errBars(1:22,i),'linestyle','none','HandleVisibility','off');
        e.Color = outcomeColors{i-1};
     end
    
end 

%figure properties
patch(patchX,patchY,patchColor,'FaceAlpha',0.07,'LineStyle','none')

set(gca,'xlim',[0 23],'xtick',[3 12 13 22],'ylim',[minValue maxValue],'ytick',minValue:200:maxValue);
set(gca,'xticklabels',[1 10 1 10]);
set(gca,'FontSize',10);

ylabel('max reach velocity (mm/s)')
xlabel('session number')

if ~plotAll
    legend('1st success', 'any success')
else 
    legend('1st success','any success','failed','no pellet','paw through slot')
end 

box off