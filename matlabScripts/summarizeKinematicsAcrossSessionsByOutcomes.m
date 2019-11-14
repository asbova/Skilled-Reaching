function exptOutcomeSummary = summarizeKinematicsAcrossSessionsByOutcomes(summary)

num_outcomes = 7;
num_sessions = size(summary(1).sessions_analyzed,1);
num_rats = length(summary);

exptOutcomeSummary.outcomePercent = zeros(num_sessions, num_outcomes, num_rats);
exptOutcomeSummary.mean_num_reaches = zeros(num_sessions, num_outcomes);
exptOutcomeSummary.mean_pd_v = zeros(num_sessions, num_outcomes);
exptOutcomeSummary.mean_end_orientations = zeros(num_sessions, num_outcomes);
exptOutcomeSummary.end_MRL = zeros(num_sessions, num_outcomes);
exptOutcomeSummary.mean_end_aperture = zeros(num_sessions, num_outcomes);
exptOutcomeSummary.std_end_aperture = zeros(num_sessions, num_outcomes);

exptOutcomeSummary.mean_pd_endPt_x = zeros(num_sessions,num_outcomes,num_rats);
exptOutcomeSummary.mean_dig2_endPt_x = zeros(num_sessions,num_outcomes,num_rats);
exptOutcomeSummary.mean_pd_endPt_y = zeros(num_sessions,num_outcomes,num_rats);
exptOutcomeSummary.mean_dig2_endPt_y = zeros(num_sessions,num_outcomes,num_rats);
exptOutcomeSummary.mean_pd_endPt_z = zeros(num_sessions,num_outcomes,num_rats);
exptOutcomeSummary.mean_dig2_endPt_z = zeros(num_sessions,num_outcomes,num_rats);

% num_z_points = size(summary(1).ratSummary.mean_aperture_traj,2);
% exptOutcomeSummary.mean_aperture_traj = NaN(num_outcomes,num_sessions,num_rats,num_z_points);
% exptOutcomeSummary.std_aperture_traj = NaN(num_outcomes,num_sessions,num_z_points);
% exptOutcomeSummary.sem_aperture_traj = NaN(num_outcomes,num_sessions,num_z_points);
% exptOutcomeSummary.mean_orientation_traj = NaN(num_outcomes,num_sessions,num_z_points);
% exptOutcomeSummary.MRL_traj = NaN(num_outcomes,num_sessions,num_z_points);

for i_rat = 1 : num_rats
    
    exptOutcomeSummary.pawPref(i_rat) = summary(i_rat).thisRatInfo.pawPref;
    
    exptOutcomeSummary.outcomePercent(:,:,i_rat) = summary(i_rat).ratSummary.outcomePercent(:,:);
    exptOutcomeSummary.mean_num_reaches(:,:,i_rat) = summary(i_rat).ratSummary.mean_num_reaches(:,:);
    exptOutcomeSummary.mean_pd_v(:,:,i_rat) = summary(i_rat).ratSummary.mean_pd_v(:,:);
    exptOutcomeSummary.end_MRL(:,:,i_rat) = summary(i_rat).ratSummary.end_MRL(:,:);
    exptOutcomeSummary.mean_end_aperture(:,:,i_rat) = summary(i_rat).ratSummary.mean_end_aperture(:,:);
    exptOutcomeSummary.std_end_aperture(:,:,i_rat) = summary(i_rat).ratSummary.std_end_aperture(:,:);
    
    exptOutcomeSummary.mean_pd_endPt_x(:,:,i_rat) = summary(i_rat).ratSummary.mean_pd_endPt(:,:,1);
    exptOutcomeSummary.mean_dig2_endPt_x(:,:,i_rat) = summary(i_rat).ratSummary.mean_dig2_endPt(:,:,1);
    
    exptOutcomeSummary.mean_pd_endPt_y(:,:,i_rat) = summary(i_rat).ratSummary.mean_pd_endPt(:,:,2);
    exptOutcomeSummary.mean_dig2_endPt_y(:,:,i_rat) = summary(i_rat).ratSummary.mean_dig2_endPt(:,:,2);
    
    exptOutcomeSummary.mean_pd_endPt_z(:,:,i_rat) = summary(i_rat).ratSummary.mean_pd_endPt(:,:,3);
    exptOutcomeSummary.mean_dig2_endPt_z(:,:,i_rat) = summary(i_rat).ratSummary.mean_dig2_endPt(:,:,3);
    
    if exptOutcomeSummary.pawPref(i_rat) == 'left'
        exptOutcomeSummary.mean_end_orientations(:,:,i_rat) = pi - summary(i_rat).ratSummary.mean_end_orientations(:,:);
    else 
        exptOutcomeSummary.mean_end_orientations(:,:,i_rat) = summary(i_rat).ratSummary.mean_end_orientations(:,:);
    end

    
    % mean apertures and orientations as a function of z
%     exptOutcomeSummary.mean_aperture_traj(:,:,i_rat,:) = summary(i_rat).ratSummary.mean_aperture_traj;
%     exptOutcomeSummary.std_aperture_traj(i_rat,:,:) = summary(i_rat).ratSummary.std_aperture_traj;
%     exptOutcomeSummary.sem_aperture_traj(i_rat,:,:) = summary(i_rat).ratSummary.sem_aperture_traj;
%     
%     if exptOutcomeSummary.pawPref(i_rat) == 'left'
%         exptOutcomeSummary.mean_orientation_traj(i_rat,:,:) = pi - summary(i_rat).ratSummary.mean_orientation_traj;
%     else
%         exptOutcomeSummary.mean_orientation_traj(i_rat,:,:) = summary(i_rat).ratSummary.mean_orientation_traj;
%     end
%     exptOutcomeSummary.MRL_traj(i_rat,:,:) = summary(i_rat).ratSummary.MRL_traj;
%     
%     exptOutcomeSummary.z_interp_digits = summary(i_rat).ratSummary.z_interp_digits;
    
end

end
    