% script_calculateRatSummaries

% calculate the following kinematic parameters:
% 1. max velocity, by reach type
% 2. average trajectory for a session, by reach time
% 3. deviation from that trajectory for a session
% 4. distance between trajectories
% 5. closest distance paw to pellet
% 6. minimum z, by type
% 7. number of reaches, by type

trialOutcomeColors = {'k','g','b','r','y','c','m'};
validTrialOutcomes = {0:10,1,2,[3,4,7],0,11,6};
validOutcomeNames = {'all','1st success','any success','failed','no pellet','paw through slot','no reach'};

labeledBodypartsFolder = '/Volumes/SharedX/Neuro-Leventhal/data/Skilled Reaching/DLC output';
histoFolder = '/Volumes/SharedX/Neuro-Leventhal/analysis/Opto Rat Complete Data';
xlDir = '/Users/alexandrabova/Box Sync/Leventhal Lab/Skilled Reaching Project/Scoring Sheets';
csvfname = fullfile(xlDir,'rat_info_pawtracking_DL.csv');
ratInfo = readRatInfoTable(csvfname);

ratSummaryDir = fullfile('/Volumes/SharedX/Neuro-Leventhal/analysis/','rat kinematic summaries');
if ~exist(ratSummaryDir,'dir')
    mkdir(ratSummaryDir);
end

ratInfo_IDs = [ratInfo.ratID];

cd(labeledBodypartsFolder)
ratFolders = dir('R*');
numRatFolders = length(ratFolders);

temp_reachData = initializeReachDataStruct();

z_interp_digits = 20:-0.1:-15;  % for interpolating z-coordinated for aperture and orientation calculations

for i_rat = 1 : numRatFolders
    
    ratID = ratFolders(i_rat).name
    ratIDnum = str2double(ratID(2:end));
    
    ratInfo_idx = find(ratInfo_IDs == ratIDnum);
    if isempty(ratInfo_idx)
        error('no entry in ratInfo structure for rat %d\n',C{1});
    end
    thisRatInfo = ratInfo(ratInfo_idx,:);
    pawPref = thisRatInfo.pawPref;
    if iscategorical(pawPref)
        pawPref = char(pawPref);
    end
    if iscell(pawPref)
        pawPref = pawPref{1};
    end
    
    ratRootFolder = fullfile(labeledBodypartsFolder,ratID);
    histo_ratFolder = fullfile(histoFolder,ratID);
    
    cd(ratRootFolder);
    ratSummaryName = [ratID '_kinematicsSummary.mat'];
    
    sessionDirectories = listFolders([ratID '_2*']);
%     numSessions = length(sessionDirectories);
    
    sessionCSV = [ratID '_sessions.csv'];
    sessionTable = readSessionInfoTable(sessionCSV);
    
    sessions_analyzed = getRetrainingThroughOcclusionSessions(sessionTable);
    numSessions = size(sessions_analyzed,1);
%     sessionType = determineSessionType(thisRatInfo, allSessionDates);

    ratSummary = initializeRatSummaryStruct(ratID,validTrialOutcomes,validOutcomeNames,numSessions,z_interp_digits);
    for iSession = 1 : numSessions
        
        sessionDate = sessions_analyzed.date(iSession);
        sessionDateString = datestr(sessionDate,'yyyymmdd');
        
        cd(ratRootFolder);
        testDirName = [ratID '_' sessionDateString '*'];
        validSessionDir = dir(testDirName);
        if isempty(validSessionDir)
            continue;
        end
        curSessionDir = validSessionDir.name;
        fullSessionDir = fullfile(ratRootFolder,curSessionDir);
        
        if ~isfolder(fullSessionDir)
            continue;
        end
        
        cd(fullSessionDir);
        % not sure if the following is necessary, but it's been working
        C = textscan(curSessionDir,[ratID '_%8c']);
        sessionDateString = C{1}; % this will be in format yyyymmdd
                            % note date formats from the scores spreadsheet
                            % are in m/d/yy
        sessionDate = datetime(sessionDateString,'inputformat','yyyyMMdd');
        
        curSessionTableRow = (sessions_analyzed.date == sessionDate);
        cur_sessionInfo = sessions_analyzed(curSessionTableRow,:);
        
        reachDataName = [ratID '_' sessionDateString '_processed_reaches.mat'];
        reachDataName = fullfile(fullSessionDir,reachDataName);
        
        if ~exist(reachDataName,'file')
            sprintf('no reach data summary found for %s\n',curSessionDir);
            continue;
        end
        
        load(reachDataName);
       
        numTrials = length(reachData);
        
        [ratSummary.num_trials(iSession,:),~] = breakDownTrialScores(reachData,validTrialOutcomes);
        ratSummary.outcomePercent(iSession,:) = ratSummary.num_trials(iSession,:) / ratSummary.num_trials(iSession,1);
        
        [ratSummary.mean_num_reaches(iSession,:), ratSummary.std_num_reaches(iSession,:)] = ...
            breakDownReachesByOutcome(reachData,validTrialOutcomes);
        
        [ratSummary.mean_pd_endPt(iSession,:,:),ratSummary.cov_pd_endPts(iSession,:,:,:),...
            ratSummary.mean_dig2_endPt(iSession,:,:),ratSummary.cov_dig2_endPts(iSession,:,:,:)] = ...
                breakDownReachEndPointsByOutcome(reachData,validTrialOutcomes);
            
        [ratSummary.mean_pd_v(iSession,:), ratSummary.std_pd_v(iSession,:)] = ...
            breakDownVelocityByOutcome(reachData,validTrialOutcomes);
        
        [ratSummary.mean_end_aperture(iSession,:), ratSummary.std_end_aperture(iSession,:)] = ...
            breakDownApertureByOutcome(reachData,validTrialOutcomes);
        
        [ratSummary.mean_end_orientations(iSession,:),ratSummary.end_MRL(iSession,:)] = breakDownOrientationByOutcome(reachData,validTrialOutcomes);
        
        [temp_aperture_traj,ratSummary.mean_aperture_traj(iSession,:),ratSummary.std_aperture_traj(iSession,:),ratSummary.sem_aperture_traj(iSession,:)] = ...
            breakDownFullApertureByOutcome(reachData,z_interp_digits);
        [temp_orientation_traj,ratSummary.mean_orientation_traj(iSession,:),ratSummary.MRL_traj(iSession,:)] = ...
            breakDownFullOrientationByOutcome(reachData,z_interp_digits);
    end
    
    cd(ratRootFolder);
    save(fullfile(ratSummaryDir,ratSummaryName),'ratSummary','sessions_analyzed','thisRatInfo');
    clear ratSummary
    clear sessions_analyzed;
    
end
        