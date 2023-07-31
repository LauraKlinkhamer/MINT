
%%%% Check for NaN values in timeseries %%%%
%%% By Laura Klinkhamer
%%% Last updated on: 20-01-2023


%%% ses-2 %%%


%%% 0mm ses-2 %%%

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


for sub_i = 1:length(subList)

% ICA

load (fullfile(complete_atlas_folder, [['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_task-rest_run-1_setting-preproc0mmICA_complete_atlas_timeseries.mat']));
load (fullfile(cortical_atlas_folder, [['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_task-rest_run-1_setting-preproc0mmICA_cortical_atlas_timeseries.mat']));

    if sum(isnan(timeseries_complete_atlas(:))) > 0 
        disp([['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] 'NaN present in ses-2 0mm ICA complete atlas'])
        [rows, columns] = find(isnan(timeseries_complete_atlas)); % find NaN values in timeseries
        disp(unique(rows))
        
        ICA_0mm_complete_rows_with_na = unique(rows); % store all row numbers (equal to ROI label number) for which NaN values are found 

        region_list = [1:251]'; % create a column with the numerical labels for all complete atlas ROIs
        index_NaN_regions = ismember(region_list, ICA_0mm_complete_rows_with_na); % create an index for which of the ROI labels values have NaN values
        NaN_complete_ICA_0mm = [region_list, index_NaN_regions]; % add these together, create one such file for each timeseries        
      
        clear columns
        clear rows
        clear region_list
        clear index_NaN_regions

    else
        ICA_0mm_complete_rows_with_na = 0; % in case there are no NaN values in the timeseries, create an index with just 0s, can later be used for summing

        region_list = [1:251]';
        index_NaN_regions = ismember(region_list, ICA_0mm_complete_rows_with_na);
        NaN_complete_ICA_0mm = [region_list, index_NaN_regions];            
      
        clear columns
        clear rows
        clear region_list
        clear index_NaN_regions
    end 
    
    if sum(isnan(timeseries_brainnetome_cortical_atlas(:))) > 0
        disp([['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] ' NaN present in ses-2 0mm ICA cortical atlas'])
        [rows, columns] = find(isnan(timeseries_brainnetome_cortical_atlas));
        disp(unique(rows))

        ICA_0mm_cortical_rows_with_na = unique(rows);

        region_list = [1:210]';
        index_NaN_regions = ismember(region_list, ICA_0mm_cortical_rows_with_na);
        NaN_cortical_ICA_0mm = [region_list, index_NaN_regions];            
      
        clear columns
        clear rows
        clear region_list
        clear index_NaN_regions

    else
        ICA_0mm_cortical_rows_with_na = 0;
        region_list = [1:210]';
        index_NaN_regions = ismember(region_list, ICA_0mm_cortical_rows_with_na);
        NaN_cortical_ICA_0mm = [region_list, index_NaN_regions];            
      
        clear columns
        clear rows
        clear region_list
        clear index_NaN_regions
    end

clear timeseries_complete_atlas
clear timeseries_brainnetome_cortical_atlas

 % ACompCor

load (fullfile(complete_atlas_folder, [['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_task-rest_run-1_setting-preproc0mmACompCor_complete_atlas_timeseries.mat']));
load (fullfile(cortical_atlas_folder, [['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_task-rest_run-1_setting-preproc0mmACompCor_cortical_atlas_timeseries.mat']));

    if sum(isnan(timeseries_complete_atlas(:))) > 0
       disp([['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] ' NaN present in ses-2 0mm ACompCor complete atlas'])
        [rows, columns] = find(isnan(timeseries_complete_atlas));
        disp(unique(rows))

        ACompCor_0mm_complete_rows_with_na = unique(rows);
        
        region_list = [1:251]';
        index_NaN_regions = ismember(region_list, ACompCor_0mm_complete_rows_with_na);
        NaN_complete_ACompCor_0mm = [region_list, index_NaN_regions];            
      
        clear columns
        clear rows
        clear region_list
        clear index_NaN_regions

    else
        ACompCor_0mm_complete_rows_with_na = 0;

        region_list = [1:251]';
        index_NaN_regions = ismember(region_list, ACompCor_0mm_complete_rows_with_na);
        NaN_complete_ACompCor_0mm = [region_list, index_NaN_regions];            
      
        clear columns
        clear rows
        clear region_list
        clear index_NaN_regions
    end

    if sum(isnan(timeseries_brainnetome_cortical_atlas(:))) > 0
        disp([['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] ' NaN present in ses-2 0mm ACompCor cortical atlas'])
        [rows, columns] = find(isnan(timeseries_brainnetome_cortical_atlas));
        disp(unique(rows))

        ACompCor_0mm_cortical_rows_with_na = unique(rows);

        region_list = [1:210]';
        index_NaN_regions= ismember(region_list, ACompCor_0mm_cortical_rows_with_na);
        NaN_cortical_ACompCor_0mm = [region_list, index_NaN_regions];            
      
        clear columns
        clear rows
        clear region_list
        clear index_NaN_regions
    else
        ACompCor_0mm_cortical_rows_with_na = 0;
        region_list = [1:210]';
        index_NaN_regions = ismember(region_list, ACompCor_0mm_cortical_rows_with_na);
        NaN_cortical_ACompCor_0mm = [region_list, index_NaN_regions];            
      
        clear columns
        clear rows
        clear region_list
        clear index_NaN_regions

    end

% add all the NaN indexes together and save as csv files 
% further indexing will be done in R 

NaN_regions_complete_0mm = table(NaN_complete_ICA_0mm(:,1), NaN_complete_ICA_0mm(:,2), NaN_complete_ACompCor_0mm(:,2), ...
                            'VariableNames',["Region_label", char([['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_NaN_complete_ICA_0mm']), ...
                            char([['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_NaN_complete_ACompCor_0mm'])]);

saveName = [['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_complete_NaN_regions_0mm.csv'];
writetable(NaN_regions_complete_0mm, fullfile('<results_path>', saveName))


NaN_regions_cortical_0mm = table(NaN_cortical_ICA_0mm(:,1), NaN_cortical_ICA_0mm(:,2), NaN_cortical_ACompCor_0mm(:,2), ...
                            'VariableNames',["Region_label", char([['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_NaN_cortical_ICA_0mm']), ...
                            char([['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_NaN_cortical_ACompCor_0mm'])]);

saveName = [['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_cortical_NaN_regions_0mm.csv'];
writetable(NaN_regions_cortical_0mm, fullfile('<results_path>', saveName))


end

clear


%%% 3mm ses-2 %%%    

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


for sub_i = 1:length(subList)

% ICA

load (fullfile(complete_atlas_folder, [['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_task-rest_run-1_setting-preproc3mmICA_complete_atlas_timeseries.mat']));
load (fullfile(cortical_atlas_folder, [['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_task-rest_run-1_setting-preproc3mmICA_cortical_atlas_timeseries.mat']));

    if sum(isnan(timeseries_complete_atlas(:))) > 0
        disp([['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] 'NaN present in ses-2 3mm ICA complete atlas'])
        [rows, columns] = find(isnan(timeseries_complete_atlas));
        disp(unique(rows))

        ICA_3mm_complete_rows_with_na = unique(rows);
        
        region_list = [1:251]';
        index_NaN_regions = ismember(region_list, ICA_3mm_complete_rows_with_na);
        NaN_complete_ICA_3mm = [region_list, index_NaN_regions];            
      
        clear columns
        clear rows
        clear region_list
        clear index_NaN_regions

        
    else 
        ICA_3mm_complete_rows_with_na = 0;

        region_list = [1:251]';
        index_NaN_regions = ismember(region_list, ICA_3mm_complete_rows_with_na);
        NaN_complete_ICA_3mm = [region_list, index_NaN_regions];            
      
        clear columns
        clear rows
        clear region_list
        clear Lia
        clear index_NaN_regions
    end 
    
    if sum(isnan(timeseries_brainnetome_cortical_atlas(:))) > 0
        disp([['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] ' NaN present in ses-2 3mm ICA cortical atlas'])
        [rows, columns] = find(isnan(timeseries_brainnetome_cortical_atlas));
        disp(unique(rows))

        ICA_3mm_cortical_rows_with_na = unique(rows);

        region_list = [1:210]';
        index_NaN_regions = ismember(region_list, ICA_3mm_cortical_rows_with_na);
        NaN_cortical_ICA_3mm = [region_list, index_NaN_regions];            
      
        clear columns
        clear rows
        clear region_list
        clear index_NaN_regions
    else
        ICA_3mm_cortical_rows_with_na = 0;

        region_list = [1:210]';
        index_NaN_regions = ismember(region_list, ICA_3mm_cortical_rows_with_na);
        NaN_cortical_ICA_3mm = [region_list, index_NaN_regions];            
      
        clear columns
        clear rows
        clear region_list
        clear index_NaN_regions
    end

clear timeseries_complete_atlas
clear timeseries_brainnetome_cortical_atlas

 % ACompCor

load (fullfile(complete_atlas_folder, [['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_task-rest_run-1_setting-preproc3mmACompCor_complete_atlas_timeseries.mat']));
load (fullfile(cortical_atlas_folder, [['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_task-rest_run-1_setting-preproc3mmACompCor_cortical_atlas_timeseries.mat']));

    if sum(isnan(timeseries_complete_atlas(:))) > 0
       disp([['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] ' NaN present in ses-2 3mm ACompCor complete atlas'])
        [rows, columns] = find(isnan(timeseries_complete_atlas));
        disp(unique(rows))

        ACompCor_3mm_complete_rows_with_na = unique(rows);
            
        region_list = [1:251]';
        index_NaN_regions = ismember(region_list, ACompCor_3mm_complete_rows_with_na);
        NaN_complete_ACompCor_3mm = [region_list, index_NaN_regions];            
      
        clear columns
        clear rows
        clear region_list
        clear index_NaN_regions

    else
        ACompCor_3mm_complete_rows_with_na = 0;

        region_list = [1:251]';
        index_NaN_regions = ismember(region_list, ACompCor_3mm_complete_rows_with_na);
        NaN_complete_ACompCor_3mm = [region_list, index_NaN_regions];            
      
        clear columns
        clear rows
        clear region_list
        clear index_NaN_regions
    end

    if sum(isnan(timeseries_brainnetome_cortical_atlas(:))) > 0
        disp([['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] ' NaN present in ses-2 3mm ACompCor cortical atlas'])
        [rows, columns] = find(isnan(timeseries_brainnetome_cortical_atlas));
        disp(unique(rows))

        ACompCor_3mm_cortical_rows_with_na = unique(rows);

        region_list = [1:210]';
        index_NaN_regions = ismember(region_list, ACompCor_3mm_cortical_rows_with_na);
        NaN_cortical_ACompCor_3mm = [region_list, index_NaN_regions];            
      
        clear columns
        clear rows
        clear region_list
        clear index_NaN_regions

    else
        ACompCor_3mm_cortical_rows_with_na = 0;

        region_list = [1:210]';
        index_NaN_regions = ismember(region_list, ACompCor_3mm_cortical_rows_with_na);
        NaN_cortical_ACompCor_3mm = [region_list, index_NaN_regions];            
      
        clear columns
        clear rows
        clear region_list
        clear index_NaN_regions
    end

% add all the NaN indexes together and save as csv files 
% further indexing will be done in R 

NaN_regions_complete_3mm = table(NaN_complete_ICA_3mm(:,1), NaN_complete_ICA_3mm(:,2), NaN_complete_ACompCor_3mm(:,2), ...
                            'VariableNames',["Region_label", char([['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_NaN_complete_ICA_3mm']), ...
                            char([['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_NaN_complete_ACompCor_3mm'])]);

saveName = [['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_complete_NaN_regions_3mm.csv'];
writetable(NaN_regions_complete_3mm, fullfile('<results_path>', saveName))


NaN_regions_cortical_3mm = table(NaN_cortical_ICA_3mm(:,1), NaN_cortical_ICA_3mm(:,2), NaN_cortical_ACompCor_3mm(:,2), ...
                            'VariableNames',["Region_label", char([['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_NaN_cortical_ICA_3mm']), ...
                            char([['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_NaN_cortical_ACompCor_3mm'])]);

saveName = [['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_cortical_NaN_regions_3mm.csv'];
writetable(NaN_regions_cortical_3mm, fullfile('<results_path>', saveName))

end

clear


%%% 6mm ses-2 %%%    

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


for sub_i = 1:length(subList)

% ICA

load (fullfile(complete_atlas_folder, [['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_task-rest_run-1_setting-preproc6mmICA_complete_atlas_timeseries.mat']));
load (fullfile(cortical_atlas_folder, [['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_task-rest_run-1_setting-preproc6mmICA_cortical_atlas_timeseries.mat']));

    if sum(isnan(timeseries_complete_atlas(:))) > 0
        disp([['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] 'NaN present in ses-2 6mm ICA complete atlas'])
        [rows, columns] = find(isnan(timeseries_complete_atlas));
        disp(unique(rows))

        ICA_6mm_complete_rows_with_na = unique(rows);
        
        region_list = [1:251]';
        index_NaN_regions = ismember(region_list, ICA_6mm_complete_rows_with_na);
        NaN_complete_ICA_6mm = [region_list, index_NaN_regions];            
      
        clear columns
        clear rows
        clear region_list
        clear index_NaN_regions
    else
        ICA_6mm_complete_rows_with_na = 0;

        region_list = [1:251]';
        index_NaN_regions = ismember(region_list, ICA_6mm_complete_rows_with_na);
        NaN_complete_ICA_6mm = [region_list, index_NaN_regions];            
      
        clear columns
        clear rows
        clear region_list
        clear index_NaN_regions
    end 
    
    if sum(isnan(timeseries_brainnetome_cortical_atlas(:))) > 0
        disp([['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] ' NaN present in ses-2 6mm ICA cortical atlas'])
        [rows, columns] = find(isnan(timeseries_brainnetome_cortical_atlas));
        disp(unique(rows))

        ICA_6mm_cortical_rows_with_na = unique(rows);

        region_list = [1:210]';
        index_NaN_regions = ismember(region_list, ICA_6mm_cortical_rows_with_na);
        NaN_cortical_ICA_6mm = [region_list, index_NaN_regions];            
      
        clear columns
        clear rows
        clear region_list
        clear index_NaN_regions

    else
        ICA_6mm_cortical_rows_with_na = 0;

        region_list = [1:210]';
        index_NaN_regions = ismember(region_list, ICA_6mm_cortical_rows_with_na);
        NaN_cortical_ICA_6mm = [region_list, index_NaN_regions];            
      
        clear columns
        clear rows
        clear region_list
        clear index_NaN_regions
    end

clear timeseries_complete_atlas
clear timeseries_brainnetome_cortical_atlas

 % ACompCor

load (fullfile(complete_atlas_folder, [['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_task-rest_run-1_setting-preproc6mmACompCor_complete_atlas_timeseries.mat']));
load (fullfile(cortical_atlas_folder, [['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_task-rest_run-1_setting-preproc6mmACompCor_cortical_atlas_timeseries.mat']));

    if sum(isnan(timeseries_complete_atlas(:))) > 0
       disp([['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] ' NaN present in ses-2 6mm ACompCor complete atlas'])
       [rows, columns] = find(isnan(timeseries_complete_atlas));
        disp(unique(rows))

        ACompCor_6mm_complete_rows_with_na = unique(rows);
        
        region_list = [1:251]';
        index_NaN_regions = ismember(region_list, ACompCor_6mm_complete_rows_with_na);
        NaN_complete_ACompCor_6mm = [region_list, index_NaN_regions];            
      
        clear columns
        clear rows
        clear region_list
        clear index_NaN_regions

    else
        ACompCor_6mm_complete_rows_with_na = 0;

        region_list = [1:251]';
        index_NaN_regions = ismember(region_list, ACompCor_6mm_complete_rows_with_na);
        NaN_complete_ACompCor_6mm = [region_list, index_NaN_regions];            
      
        clear columns
        clear rows
        clear region_list
        clear index_NaN_regions
    end

    if sum(isnan(timeseries_brainnetome_cortical_atlas(:))) > 0
        disp([['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] ' NaN present in ses-2 6mm ACompCor cortical atlas'])
        [rows, columns] = find(isnan(timeseries_brainnetome_cortical_atlas));
        disp(unique(rows))

        ACompCor_6mm_cortical_rows_with_na = unique(rows)
        
        region_list = [1:210]';
        index_NaN_regions = ismember(region_list, ACompCor_6mm_cortical_rows_with_na);
        NaN_cortical_ACompCor_6mm = [region_list, index_NaN_regions];            
      
        clear columns
        clear rows
        clear region_list
        clear index_NaN_regions

    else
        ACompCor_6mm_cortical_rows_with_na = 0;

        region_list = [1:210]';
        index_NaN_regions = ismember(region_list, ACompCor_6mm_cortical_rows_with_na);
        NaN_cortical_ACompCor_6mm = [region_list, index_NaN_regions];            
      
        clear columns
        clear rows
        clear region_list
        clear index_NaN_regions
    end

% add all the NaN indexes together and save as csv files 
% further indexing will be done in R 

NaN_regions_complete_6mm = table(NaN_complete_ICA_6mm(:,1), NaN_complete_ICA_6mm(:,2), NaN_complete_ACompCor_6mm(:,2), ...
                            'VariableNames',["Region_label", char([['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_NaN_complete_ICA_6mm']), ...
                            char([['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_NaN_complete_ACompCor_6mm'])]);

saveName = [['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_complete_NaN_regions_6mm.csv'];
writetable(NaN_regions_complete_6mm, fullfile('<results_path>', saveName))


NaN_regions_cortical_6mm = table(NaN_cortical_ICA_6mm(:,1), NaN_cortical_ICA_6mm(:,2), NaN_cortical_ACompCor_6mm(:,2), ...
                            'VariableNames',["Region_label", char([['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_NaN_cortical_ICA_6mm']), ...
                            char([['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_NaN_cortical_ACompCor_6mm'])]);

saveName = [['sub-' num2str(subList(sub_i),'%02.f')] ['_ses-' sesName] '_cortical_NaN_regions_6mm.csv'];
writetable(NaN_regions_cortical_6mm, fullfile('<results_path>', saveName))

end

clear
