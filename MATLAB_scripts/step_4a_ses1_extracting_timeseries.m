% Preparation of brain atlases for MINT study MRI analysis
% Step 4: extracting the time series
% Joana Leitão & Laura Klinkhamer
% 23/01/2022


% This function can only be ran after complete preprocessing of the functional data

mainFolder = fullfile('<data_path>');
subList = [2:13, 17, 18, 22, 24, 25, 27:48, 50:52]; 
sesNum = 1;


spm('Defaults','fMRI');
spm_jobman('initcfg');

if isstring(sesNum)
    sesName = sesNum;
else
    sesName = num2str(sesNum,'%2.f');
end

% Read in brain atlases

% Brainnetome + brainstem

complete_atlas_folder = '<atlas_path>';
complete_atlas = fullfile(complete_atlas_folder, 'Brainnetome_brainstem_combined.nii');
complete_atlas_hdr = spm_vol(complete_atlas);
complete_atlas_image = spm_read_vols(complete_atlas_hdr);

% Brainnetome cortical (for overlay with Yeo et al., 2011 in LEiDA)

brainnetome_cortical_folder = '<atlas_path>';
brainnetome_cortical_atlas = fullfile(brainnetome_cortical_folder, 'Brainnetome_cortical_atlas.nii');
brainnetome_cortical_atlas_hdr = spm_vol(brainnetome_cortical_atlas);
brainnetome_cortical_atlas_image = spm_read_vols(brainnetome_cortical_atlas_hdr);


for sub_i = 1:length(subList)
    
    % define current participant and func folder
    subFolder = fullfile(mainFolder, ['sub-' num2str(subList(sub_i),'%02.f')], ['ses-' sesName]);
    funcFolder = fullfile(subFolder, 'func');
   

    %reading in all BOLD time series that exist in the func folder 

    BOLD_dir_gz = dir(fullfile(funcFolder, '*0mm*bold.nii.gz')); % change mm
   

    % for each of the BOLD runs
    for bold_i = 1:length(BOLD_dir_gz)
        
        tic
        gunzip(fullfile(funcFolder, BOLD_dir_gz(bold_i).name), funcFolder);
        toc
        
        filename = fullfile(funcFolder,  BOLD_dir_gz(bold_i).name(1:end-3));
        
        % read in 4D nii (time is in the 4th dimension)
        %scans_hdr = spm_vol(fullfile(funcFolder, BOLD_dir(bold_i).name));
        scans_hdr = spm_vol(filename);
        scans_img = spm_read_vols(scans_hdr);
        
        for vol = 1:size(scans_img,4)
            % for each volume read in the corresponding data matrix
            currentVol = scans_img(:,:,:,vol);

            % identify the voxels in each ROI (i.e. the voxels that match
            % the label nr; in the combined brainnetome + brainstem atlas
            % there are 251 ROIs - see step 3

            non_zero_indices = find(currentVol > 0);

            for label_i = 1:251
                indices_complete_atlas = find(complete_atlas_image == label_i);

                values_ROI = currentVol(indices_complete_atlas);
                proportion_overlap = sum(values_ROI ~= 0)/length(indices_complete_atlas);

                if proportion_overlap >= 0.8 % only calculate mean timeseries for ROI if it has at least 80% overlap with atlas
                    % i.e. 80% voxels in the atlas ROI are actually populated in the image

                    % and extract the values of the indices define and calculate the mean across all tissue voxels
                    indices_to_use = intersect(indices_complete_atlas, non_zero_indices);
                    timeseries_complete_atlas(label_i, vol) = nanmean(currentVol(indices_to_use));

                else
                    timeseries_complete_atlas(label_i, vol) = NaN;

                end

            end

      
            clear label_i
            clear values_ROI
            clear proportion_overlap
            clear indices_to_use


            for label_i = 1:210

                indices_brainnetome_cortical_atlas = find(brainnetome_cortical_atlas_image == label_i);
                  
                values_ROI = currentVol(indices_brainnetome_cortical_atlas);
                proportion_overlap = sum(values_ROI ~= 0)/length(indices_brainnetome_cortical_atlas);
              
                if proportion_overlap >= 0.8 % only calculate mean timeseries for ROI if it has at least 80% overlap with atlas 
                                             % i.e. 80% voxels in the atlas ROI are actually populated in the image 

                  
                    % and extract the values of the indices define and calculate the mean across all tissue voxels
                    indices_to_use = intersect(indices_brainnetome_cortical_atlas, non_zero_indices);
                    timeseries_brainnetome_cortical_atlas(label_i, vol) = nanmean(currentVol(indices_to_use)); 

                else

                    % and extract the values of the indices define and calculate the mean across all tissue voxels
                    timeseries_brainnetome_cortical_atlas(label_i, vol) = NaN;

                end
            end

            clear label_i
            clear values_ROI
            clear proportion_overlap
            clear indices_to_use
            
        end
        
        saveName = [BOLD_dir_gz(bold_i).name(1:end-12) '_complete_atlas_timeseries'];
        save(fullfile('<results_path>', saveName), 'timeseries_complete_atlas'); % change folder
        clear timeseries_complete_atlas;
        
        saveName = [BOLD_dir_gz(bold_i).name(1:end-12) '_cortical_atlas_timeseries'];
        save(fullfile('<results_path>', saveName), 'timeseries_brainnetome_cortical_atlas') % change folder
        clear timeseries_brainnetome_cortical_atlas
        
        delete(filename)
        
    end
    
 end

 


