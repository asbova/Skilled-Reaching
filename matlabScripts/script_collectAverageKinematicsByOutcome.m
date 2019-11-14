% xlDir = '/Users/alexandrabova/Box Sync/Leventhal Lab/Skilled Reaching Project/Scoring Sheets';
xlDir = '/Users/alexandrabova/Box Sync/Leventhal Lab/Skilled Reaching Project/Scoring Sheets';
csvfname = fullfile(xlDir,'rat_info_pawtracking_DL.csv');

ratSummaryDir = fullfile('/Volumes/SharedX/Neuro-Leventhal/analysis/','rat kinematic summaries');
if ~exist(ratSummaryDir,'dir')
    mkdir(ratSummaryDir);
end

ratInfo = readRatInfoTable(csvfname);

% ratInfo_IDs = [ratInfo.ratID];
% ratFolders = ratSummaryDir('R*');
% numRatFolders = length(ratFolders);

experimentInfo = getExperimentFeatures();

%
for i_expt = 1:4 %length experimentInfo (for now excluding Arch_between, until data is collected)
    
    curRatList = getExptRats(ratInfo,experimentInfo(i_expt));
    
    if i_expt == 1
        % workaround for now to exclude R0185
        curRatList = curRatList(2:end,:);
    end
    if i_expt == 2
        % workaround for now to exclude R0230 and R0235 until completed
        curRatList = curRatList(1:9,:);
    end
    if i_expt == 4
        % workaround for now to exclude rats that haven't been completed
        curRatList = curRatList([2,4,5,6,7,8],:);
    end

    ratIDs = [curRatList.ratID];
    numRats = length(ratIDs);
    
    for i_rat = 1 : numRats
        
        % load kinematic session data for this rat 
        cd(ratSummaryDir);
        ratIDstring = sprintf('R%04d',ratIDs(i_rat));
        ratSummaryName = [ratIDstring '_kinematicsSummary.mat'];
        summary(i_rat) = load(ratSummaryName);

    end

    cur_summary = summarizeKinematicsAcrossSessionsByOutcomes(summary);
    cur_summary.experimentInfo = experimentInfo(i_expt);
    
    exptOutcomeSummary(i_expt) = cur_summary;
end 

save('experiment_summaries_by_outcome.mat','exptOutcomeSummary')

