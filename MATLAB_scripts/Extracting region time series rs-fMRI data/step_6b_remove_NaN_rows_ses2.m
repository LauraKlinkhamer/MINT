
%%% Removing rows in timeseries for which some participants have NaN values
%%% by Laura Klinkhamer
%%% last updated on 20-01-2023

%%% ses-2

%%%% ses-2 0mm %%%%

mainPath = fullfile('<data_path>');
complete_atlas_folder = fullfile(mainPath, 'timeseries_0mm\complete_atlas');
cortical_atlas_folder = fullfile(mainPath, 'timeseries_0mm\cortical');
subList = [3, 4, 6, 8:10, 12, 13, 17, 18, 22, 24, 25, 27:35, 37, 38, 39, 40:46, 48, 50:52];
sesNum = 2;

if isstring(sesNum)
    sesName = sesNum;
else
    sesName = num2str(sesNum,'%2.f');
end


% ses-2 0mm ICA

for sub_i = 1:length(subList)

load (fullfile(complete_atlas_folder, [['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_task-rest_run-1_setting-preproc0mmICA_complete_atlas_timeseries.mat']));


% remove rows for which some participants have NaN values in complete atlas
timeseries_complete_atlas([27, 45, 47, 48, 49, 50, 69, 70, 81, 82 ...
                           89, 90, 92, 93, 94, 95, 96, 99, 100, 101, ...
                          102, 103, 104, 109, 111, 115, 116, 117, 118],:) = [];

% save the reduced timeseries file 

saveName = [['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_task-rest_run-1_setting-preproc0mmICA_complete_atlas_timeseries_NaN_rem.mat']
        save(fullfile('<results_path>\timeseries_NaN_rem\timeseries_0mm\complete_atlas', saveName), 'timeseries_complete_atlas'); 
        clear timeseries_complete_atlas;
        clear saveName
        
   
load (fullfile(cortical_atlas_folder, [['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_task-rest_run-1_setting-preproc0mmICA_cortical_atlas_timeseries.mat']));

% remove rows for which some participants have NaN values in cortical atlas
timeseries_brainnetome_cortical_atlas([27, 45, 47, 48, 49, 50, 69, 70, 81, 82 ...
                           89, 90, 92, 93, 94, 95, 96, 99, 100, 101, ...
                          102, 103, 104, 109, 111, 115, 116, 117, 118],:) = [];

saveName = [['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_task-rest_run-1_setting-preproc0mmICA_cortical_atlas_timeseries_NaN_rem.mat']
        save(fullfile('<results_path>\timeseries_NaN_rem\timeseries_0mm\cortical_atlas', saveName), 'timeseries_brainnetome_cortical_atlas'); 
        clear timeseries_brainnetome_cortical_atlas;
        clear saveName
end


% ses-2 0mm ACompCor


for sub_i = 1:length(subList)

load (fullfile(complete_atlas_folder, [['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_task-rest_run-1_setting-preproc0mmACompCor_complete_atlas_timeseries.mat']));


% remove rows for which some participants have NaN values in complete atlas
timeseries_complete_atlas([27, 45, 47, 48, 49, 50, 69, 70, 81, 82 ...
                           89, 90, 92, 93, 94, 95, 96, 99, 100, 101, ...
                          102, 103, 104, 109, 111, 115, 116, 117, 118],:) = [];
% save the reduced timeseries file 

saveName = [['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_task-rest_run-1_setting-preproc0mmACompCor_complete_atlas_timeseries_NaN_rem.mat']
        save(fullfile('<results_path>\timeseries_NaN_rem\timeseries_0mm\complete_atlas', saveName), 'timeseries_complete_atlas'); 
        clear timeseries_complete_atlas;
        clear saveName
        
   
load (fullfile(cortical_atlas_folder, [['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_task-rest_run-1_setting-preproc0mmACompCor_cortical_atlas_timeseries.mat']));

% remove rows for which some participants have NaN values in cortical atlas
timeseries_brainnetome_cortical_atlas([27, 45, 47, 48, 49, 50, 69, 70, 81, 82 ...
                           89, 90, 92, 93, 94, 95, 96, 99, 100, 101, ...
                          102, 103, 104, 109, 111, 115, 116, 117, 118],:) = [];

saveName = [['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_task-rest_run-1_setting-preproc0mmACompCor_cortical_atlas_timeseries_NaN_rem.mat']
        save(fullfile('<results_path>\timeseries_NaN_rem\timeseries_0mm\cortical_atlas', saveName), 'timeseries_brainnetome_cortical_atlas'); 
        clear timeseries_brainnetome_cortical_atlas;
        clear saveName
end

clear




%%%%%  ses-2 3mm %%%%%

mainPath = fullfile('<data_path>');
complete_atlas_folder = fullfile(mainPath, 'timeseries_3mm\complete_atlas');
cortical_atlas_folder = fullfile(mainPath, 'timeseries_3mm\cortical');
subList = [3, 4, 6, 8:10, 12, 13, 17, 18, 22, 24, 25, 27:35, 37, 38, 39, 40:46, 48, 50:52];
sesNum = 2;

if isstring(sesNum)
    sesName = sesNum;
else
    sesName = num2str(sesNum,'%2.f');
end


% ses-2 3mm ICA

for sub_i = 1:length(subList)

load (fullfile(complete_atlas_folder, [['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_task-rest_run-1_setting-preproc3mmICA_complete_atlas_timeseries.mat']));


% remove rows for which some participants have NaN values in complete atlas
timeseries_complete_atlas([27, 45, 47, 48, 49, 50, 69, 70, 81, 82 ...
                           89, 90, 92, 93, 94, 95, 96, 99, 100, 101, ...
                          102, 103, 104, 109, 111, 115, 116, 117, 118],:) = [];

% save the reduced timeseries file 

saveName = [['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_task-rest_run-1_setting-preproc3mmICA_complete_atlas_timeseries_NaN_rem.mat']
        save(fullfile('<results_path>\timeseries_NaN_rem\timeseries_3mm\complete_atlas', saveName), 'timeseries_complete_atlas'); 
        clear timeseries_complete_atlas;
        clear saveName
        
   
load (fullfile(cortical_atlas_folder, [['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_task-rest_run-1_setting-preproc3mmICA_cortical_atlas_timeseries.mat']));

% remove rows for which some participants have NaN values in cortical atlas
timeseries_brainnetome_cortical_atlas([27, 45, 47, 48, 49, 50, 69, 70, 81, 82 ...
                           89, 90, 92, 93, 94, 95, 96, 99, 100, 101, ...
                          102, 103, 104, 109, 111, 115, 116, 117, 118],:) = [];

saveName = [['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_task-rest_run-1_setting-preproc3mmICA_cortical_atlas_timeseries_NaN_rem.mat']
        save(fullfile('<results_path>\timeseries_NaN_rem\timeseries_3mm\cortical_atlas', saveName), 'timeseries_brainnetome_cortical_atlas'); 
        clear timeseries_brainnetome_cortical_atlas;
        clear saveName
end


% ses-2 3mm ACompCor


for sub_i = 1:length(subList)

load (fullfile(complete_atlas_folder, [['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_task-rest_run-1_setting-preproc3mmACompCor_complete_atlas_timeseries.mat']));


% remove rows for which some participants have NaN values in complete atlas
timeseries_complete_atlas([27, 45, 47, 48, 49, 50, 69, 70, 81, 82 ...
                           89, 90, 92, 93, 94, 95, 96, 99, 100, 101, ...
                          102, 103, 104, 109, 111, 115, 116, 117, 118],:) = [];
% save the reduced timeseries file 

saveName = [['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_task-rest_run-1_setting-preproc3mmACompCor_complete_atlas_timeseries_NaN_rem.mat']
        save(fullfile('<results_path>\timeseries_NaN_rem\timeseries_3mm\complete_atlas', saveName), 'timeseries_complete_atlas'); 
        clear timeseries_complete_atlas;
        clear saveName
        
   
load (fullfile(cortical_atlas_folder, [['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_task-rest_run-1_setting-preproc3mmACompCor_cortical_atlas_timeseries.mat']));

% remove rows for which some participants have NaN values in cortical atlas
timeseries_brainnetome_cortical_atlas([27, 45, 47, 48, 49, 50, 69, 70, 81, 82 ...
                           89, 90, 92, 93, 94, 95, 96, 99, 100, 101, ...
                          102, 103, 104, 109, 111, 115, 116, 117, 118],:) = [];

saveName = [['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_task-rest_run-1_setting-preproc3mmACompCor_cortical_atlas_timeseries_NaN_rem.mat']
        save(fullfile('<results_path>\timeseries_NaN_rem\timeseries_3mm\cortical_atlas', saveName), 'timeseries_brainnetome_cortical_atlas'); 
        clear timeseries_brainnetome_cortical_atlas;
        clear saveName
end

clear



%%%%%  ses-2 6mm %%%%%

mainPath = fullfile('<data_path>');
complete_atlas_folder = fullfile(mainPath, 'timeseries_6mm\complete_atlas');
cortical_atlas_folder = fullfile(mainPath, 'timeseries_6mm\cortical');
subList = [3, 4, 6, 8:10, 12, 13, 17, 18, 22, 24, 25, 27:35, 37, 38, 39, 40:46, 48, 50:52];
sesNum = 2;

if isstring(sesNum)
    sesName = sesNum;
else
    sesName = num2str(sesNum,'%2.f');
end


% ses-2 6mm ICA

for sub_i = 1:length(subList)

load (fullfile(complete_atlas_folder, [['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_task-rest_run-1_setting-preproc6mmICA_complete_atlas_timeseries.mat']));


% remove rows for which some participants have NaN values in complete atlas
timeseries_complete_atlas([27, 45, 47, 48, 49, 50, 69, 70, 81, 82 ...
                           89, 90, 92, 93, 94, 95, 96, 99, 100, 101, ...
                          102, 103, 104, 109, 111, 115, 116, 117, 118],:) = [];
% save the reduced timeseries file 

saveName = [['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_task-rest_run-1_setting-preproc6mmICA_complete_atlas_timeseries_NaN_rem.mat']
        save(fullfile('<results_path>\timeseries_NaN_rem\timeseries_6mm\complete_atlas', saveName), 'timeseries_complete_atlas'); 
        clear timeseries_complete_atlas;
        clear saveName
        
   
load (fullfile(cortical_atlas_folder, [['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_task-rest_run-1_setting-preproc6mmICA_cortical_atlas_timeseries.mat']));

% remove rows for which some participants have NaN values in cortical atlas
timeseries_brainnetome_cortical_atlas([27, 45, 47, 48, 49, 50, 69, 70, 81, 82 ...
                           89, 90, 92, 93, 94, 95, 96, 99, 100, 101, ...
                          102, 103, 104, 109, 111, 115, 116, 117, 118],:) = [];

saveName = [['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_task-rest_run-1_setting-preproc6mmICA_cortical_atlas_timeseries_NaN_rem.mat']
        save(fullfile('<results_path>\timeseries_NaN_rem\timeseries_6mm\cortical_atlas', saveName), 'timeseries_brainnetome_cortical_atlas'); 
        clear timeseries_brainnetome_cortical_atlas;
        clear saveName
end


% ses-2 6mm ACompCor


for sub_i = 1:length(subList)

load (fullfile(complete_atlas_folder, [['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_task-rest_run-1_setting-preproc6mmACompCor_complete_atlas_timeseries.mat']));


% remove rows for which some participants have NaN values in complete atlas
timeseries_complete_atlas([27, 45, 47, 48, 49, 50, 69, 70, 81, 82 ...
                           89, 90, 92, 93, 94, 95, 96, 99, 100, 101, ...
                          102, 103, 104, 109, 111, 115, 116, 117, 118],:) = [];

% save the reduced timeseries file 

saveName = [['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_task-rest_run-1_setting-preproc6mmACompCor_complete_atlas_timeseries_NaN_rem.mat']
        save(fullfile('<results_path>\timeseries_NaN_rem\timeseries_6mm\complete_atlas', saveName), 'timeseries_complete_atlas'); 
        clear timeseries_complete_atlas;
        clear saveName
        
   
load (fullfile(cortical_atlas_folder, [['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_task-rest_run-1_setting-preproc6mmACompCor_cortical_atlas_timeseries.mat']));

% remove rows for which some participants have NaN values in cortical atlas
timeseries_brainnetome_cortical_atlas([27, 45, 47, 48, 49, 50, 69, 70, 81, 82 ...
                           89, 90, 92, 93, 94, 95, 96, 99, 100, 101, ...
                          102, 103, 104, 109, 111, 115, 116, 117, 118],:) = [];

saveName = [['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_task-rest_run-1_setting-preproc6mmACompCor_cortical_atlas_timeseries_NaN_rem.mat']
        save(fullfile('<results_path>\timeseries_NaN_rem\timeseries_6mm\cortical_atlas', saveName), 'timeseries_brainnetome_cortical_atlas'); 
        clear timeseries_brainnetome_cortical_atlas;
        clear saveName
end

clear