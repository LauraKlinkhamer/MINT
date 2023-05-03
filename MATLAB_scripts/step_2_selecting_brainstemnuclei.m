% Preparation of brain atlases for MINT study MRI analysis
% Step 2: Brainstem Nuclei
% Joana Leitão & Laura Klinkhamer
% 18/12/2022 


%% Checking overlap between added bilateral images in Brainstem Navigator

% Loading the thresholded (>0.35 probability) original binary ROIs
% Initial selection based on relevance (for details on selection process see Brainstem Nuclei Selection_18-10-2022.docx)
% Left and right files for brainstem ROIs are added together using SPM ImCalc, i1 + i2 
% The lateral and medial parts of the inferior medullary reticular formation were also added together, 
% as well as the lateral and medial parts of the superior medullary reticular formation

% Check here if the images have been added correctly and there was no
% overlap: values should be 0 and 1 (not 2 in case of overlap)

bilateral_brainstemFolder = '<path>';
bilateral_ROI_images = dir(fullfile(bilateral_brainstemFolder,"*bilateral.nii"));
orderbilateralImages = {bilateral_ROI_images(:).name};

% for roi_i = 1:length(bilateral_ROI_images)
%     roi_hdr = spm_vol(fullfile(bilateral_brainstemFolder, bilateral_ROI_images(roi_i).name));
%     roi_image = spm_read_vols(roi_hdr);
%     roi_values = unique(roi_image);
%     indices_roi= find(roi_image == 1);
%     size_ROI(roi_i) = length(indices_roi);
%    
% end
% 
% clear % clear workspace

% discovered here that 1 is actually rounded (0.99+), not exactly 1, 
% the code above therefore gave no results and with roi_image > 0 it did give results. 
% in original l and r and singular images ROI voxels have intensity value 0.99609, in bilateral images 0.99219

% check here for overlap with > 1 criterion (i.e. if there was overlap the voxel intensity value should be higher than 1).
% no overlap found 

for roi_i = 1:length(bilateral_ROI_images)
    roi_hdr = spm_vol(fullfile(bilateral_brainstemFolder, bilateral_ROI_images(roi_i).name));
    roi_image = spm_read_vols(roi_hdr);
    roi_values = unique(roi_image);
    indices_roi= find(roi_image > 1);
    size_ROI(roi_i) = length(indices_roi);
   
end

T = table(orderbilateralImages',(1:length(bilateral_ROI_images))',size_ROI', 'VariableNames', {'ROIname', 'label', 'numVoxels'})

clear % clear workspace


%% Checking voxel sizes in original space selected images from Brainstem Navigator

% all bilateral ROIs contain =>25 voxels 
% using threshold 0.99 from now on (consistent with roi_image > 0)
% checking voxel sizes for all files in selected folder (original space)

brainstemFolder = 'H:\MINT\MRI\Analyses\Atlases\applied\Brainstem\BrainstemNavigator0.9\original\selected_rois_BrainstemNavigator'; 
ROI_images = dir(fullfile(brainstemFolder,"*.nii"));
orderImages = {ROI_images(:).name};

for roi_i = 1:length(ROI_images)
    roi_hdr = spm_vol(fullfile(brainstemFolder, ROI_images(roi_i).name));
    roi_image = spm_read_vols(roi_hdr);
    roi_values = unique(roi_image);
    indices_roi= find(roi_image >= 0.99);
    size_ROI(roi_i) = length(indices_roi);
end

T = table(orderImages',(1:length(ROI_images))',size_ROI', 'VariableNames', {'ROIname','label', 'numVoxels'})

clear % clear workspace

% ROIs with < 10 voxels excluded 
% MnR excluded (7 voxels)
% RMg excluded (11 voxels)


% Checking voxel sizes in original space RVM mask from FMRIB pain group %

brainstemFolder = 'H:\MINT\MRI\Analyses\Atlases\applied\Brainstem\RVM_from_FMRIB_Oxford'; 
ROI_images = dir(fullfile(brainstemFolder,"*.nii"));
orderImages = {ROI_images(:).name};

for roi_i = 1:length(ROI_images)
    roi_hdr = spm_vol(fullfile(brainstemFolder, ROI_images(roi_i).name));
    roi_image = spm_read_vols(roi_hdr);
    roi_values = unique(roi_image);
    indices_roi= find(roi_image == 1);
    size_ROI(roi_i) = length(indices_roi);
end

T = table(orderImages',(1:length(ROI_images))',size_ROI', 'VariableNames', {'ROIname','label', 'numVoxels'})

clear % clear workspace

% RVM mask has 57 voxels in original space (voxels labeled 0 or 1) 


%% Preparing brainstem atlas based on final resliced ROI selection

% ROI images were re-sliced (Brainstem Navigator: -1 x 1 x 1, 182 x 218 x 182 RVM mask: -2 x 2 x 2, 91 x 109 x 91) to match the dimensions of 
% the Halfpipe preprocessed images (2 x 2 x 2 , 97 x 115 x 97 first using SPM12 - Coregister/Reslice, hence the voxel-specific values are not 
% exactly binary (0 and >0.99) anymore. Therefore the data needs to be thresholded again (selected threshold: 0.7) 
% ROI voxel sizes are reduced, ROIs with < 25 voxels after reslicing were removed

% loading the resliced ROI files
resliced_brainstemFolder = 'H:\MINT\MRI\Analyses\Atlases\applied\Brainstem\resliced_rois'; 
resliced_ROI_images = dir(fullfile(resliced_brainstemFolder,"*.nii"));
order_reslicedImages = {resliced_ROI_images(:).name};

% creating a base image that is blank (populated with 0s) but has the same dimensions as the resliced nii files 
base_hdr = spm_vol(fullfile(resliced_brainstemFolder, resliced_ROI_images(1).name));
base_image = zeros(base_hdr.dim);

label_val = 1;
thresh = 0.9; % threshold for coding voxels as 1: 0.5, 0.7, 0.9 were considered.
               % 0.7 selected based on ROI sizes and not having too many overlapping voxels 

for roi_i = 1:length(resliced_ROI_images)

    roi_hdr = spm_vol(fullfile(resliced_brainstemFolder, resliced_ROI_images(roi_i).name));
    roi_image = spm_read_vols(roi_hdr);
    indices_roi = find(roi_image >= thresh); % find indices i.e. voxels surpassing the 0.75 threshold
    disp(resliced_ROI_images(roi_i).name)
    disp(indices_roi)
    size_resliced_ROI(roi_i) = length(indices_roi); % number of voxels
    tmp_image(indices_roi) = label_val; % incrementally add labels to ROIs 
    label_val = label_val+1;
end

%checking the number of voxels in each ROI
T = table(order_reslicedImages',(1:length(resliced_ROI_images))',size_resliced_ROI', 'VariableNames', {'ROIname','label', 'numVoxels'})

clear % clear workspace

% Final selection: 
% Copied the voxel IDs (indices) for each ROI into reslicedROI_voxels.xlsx, highlighting duplicates. 
% Overlapping voxels assigned to the smallest ROIs


%% creating the Brainstem atlas with the final selection

resliced_brainstemFolder = 'H:\MINT\MRI\Analyses\Atlases\applied\Brainstem\resliced_rois\final_selection'; 
resliced_ROI_images = dir(fullfile(resliced_brainstemFolder,"*.nii"));
order_reslicedImages = {resliced_ROI_images(:).name};

base_hdr = spm_vol(fullfile(resliced_brainstemFolder, resliced_ROI_images(1).name));
base_image = zeros(base_hdr.dim);

label_val = 1;
thresh = 0.7; % threshold for coding voxels as 1, 0.7 selected based on ROI sizes and 
               % not too many overlapping voxels (2 between RPa & RVM and 2 between SN and VTA_PBP)

for roi_i = 1:length(resliced_ROI_images)

    roi_hdr = spm_vol(fullfile(resliced_brainstemFolder, resliced_ROI_images(roi_i).name));
    roi_image = spm_read_vols(roi_hdr);
    indices_roi = find(roi_image >= thresh); % find indices i.e. voxels surpassing the 0.7 threshold
    disp(resliced_ROI_images(roi_i).name)
    disp(indices_roi)
    size_resliced_ROI(roi_i) = length(indices_roi); % number of voxels
    base_image(indices_roi) = label_val; % incrementally add labels to ROIs 
    label_val = label_val+1;
end

T = table(order_reslicedImages',(1:length(resliced_ROI_images))',size_resliced_ROI', 'VariableNames', {'ROIname','label', 'numVoxels'})

% assigning the overlapping voxels to the smaller ROI

% SN & VTA_PBP --> to VTA_PBP, label nr 4
base_image([373788, 384844, 385046]) = 4;

% double checking that the voxel sizes of the ROIs are correct - they are

length(find(base_image == 3))
length(find(base_image == 4))


brainstem_image = base_image;

% saving the atlas with the multiple ROIs indicated with different labels

brainstem_hdr = base_hdr;
brainstem_hdr.dt(1) = spm_type('float64');
brainstem_hdr.fname = ('<path>\brainstemROIs_resliced.nii');
spm_write_vol(brainstem_hdr, brainstem_image);

