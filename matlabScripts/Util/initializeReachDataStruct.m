function reachData = initializeReachDataStruct()

reachData.reachEnds = [];
reachData.graspEnds = [];
reachData.reachStarts = [];
reachData.graspStarts = [];
reachData.pdEndPoints = [];
reachData.slotBreachFrame = [];
reachData.firstDigitKinematicsFrame = [];
reachData.pd_trajectory = {};
reachData.pd_pathlength = {};
reachData.segmented_pd_trajectory = {};
reachData.pd_v = {};
reachData.max_pd_v = [];
reachData.dig_trajectory = {};
reachData.dig_pathlength = {};
reachData.segmented_dig_trajectory = {};
reachData.dig2_v = {};
reachData.max_dig2_v = [];
reachData.dig2_endPoints = [];
reachData.orientation = {};
reachData.aperture = {};
reachData.trialScores = [];
reachData.trialNumbers = [];
reachData.slot_z_wrt_pellet = [];