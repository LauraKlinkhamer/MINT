% Preparation of brain atlases for MINT study MRI analysis
% Step 3: Merging the brainstem and brainnetome atlases
% Laura Klinkhamer & Joana Leitão 
% 18/12/2022 

%% Loading both atlases 

brainnetome_folder = '<path>\Brainnetome_Buckner_combined';
brainnetome_atlas = fullfile(brainnetome_folder, 'Brainnetome_atlas.nii');
brainnetome_hdr = spm_vol(brainnetome_atlas);
brainnetome_image = spm_read_vols(brainnetome_hdr);

brainstem_folder = '<path>\Brainstem';
brainstem_atlas = fullfile(brainstem_folder, 'BrainstemROIs_resliced.nii');
brainstem_hdr = spm_vol(brainstem_atlas);
brainstem_image = spm_read_vols(brainstem_hdr);

%% Find maximum label value of brainnetome to add brainstem ROI labels on top of it

max_ind = max(max(max(brainnetome_image)));

% adding the highest label nr of brainnetome to the brainstem label nrs 
% now instead of the brainstem  labels going from 1 to number of brainstem ROIs (8)
% they will start at max_ind + 1 (i.e. 247 - 254)

brainstem_image(find(brainstem_image>0)) = brainstem_image(find(brainstem_image>0)) + max_ind;

%% Adding the two atlases together, checking for overlaps

% unique(completeAtlas_temp) should have total number of labels only (251)
completeAtlas_temp = brainnetome_image + brainstem_image;
unique(completeAtlas_temp) % gives 3 surprsing nrs: 484, 485 and 495

find(completeAtlas_temp == 484)
%       406957 - SN
%       407452 - VTA PBP
%       418607 - VTA PBP
%       418608 - VTA PBP
%       418609 - VTA PBP

find(completeAtlas_temp == 485)
%       406971 - SN

find(completeAtlas_temp == 495)

%       407349 - VTA PBP
%       407446 - VTA PBP
%       407447 - VTA PBP
%       418600 - VTA PBP
%       418601 - VTA PBP
%       418602 - VTA PBP
%       418603 - VTA PBP


% Check these voxel IDs in the reslicedROI_voxels.xlsx, subtract brainstem
% ROI from this nr to find the ROI they overlap with 
% 484 - 249 (SN - 142 voxels) = 235 (Brainnetome_Stha_L - 167 voxels)
% 484 - 250 (VTA_PBP - 72 voxels) = 234 (Brainnetome_mPMtha_R - 185 voxels)
% 485 - 249 (SN - 142 voxels) = 236 (Brainnetome_Stha_R - 167 voxels)
% 495 - 250 (VTA_PBP - 72 voxels) = 245 (Brainnetome_lPFtha_L - 377 voxels)


% removing overlapping voxels from the brainnetome subcortical areas (i.e.
% designating them to the brainstem areas), as the brainstem areas are smaller:
% overlap between SN_bilateral and Stha_R = 1 voxel
% overlap between SN_bilateral and Stha_L = 1 voxel
% overlap between VTA_PBP_bilateral and mPMtha_R = 4 voxels
% overlap between VTA_PBP_bilateral and lPFtha_L = 7 voxels 

brainnetome_image([406957, 406971]) = 0;
brainnetome_image([407452, 418607, 418608, 418609]) = 0;
brainnetome_image([407349, 407446, 407447, 418600, 418601, 418602, 418603]) = 0;


% adding the two atlases together -> make sure there are no overlaps
% (unique(completeAtlas) should have total number of labels only
completeAtlas = brainnetome_image + brainstem_image;

% checking that all overlap has been removed - no more overlap
unique(completeAtlas)

%% Saving the atlas 
complete_hdr = brainnetome_hdr;
complete_hdr.dt(1) = spm_type('float64');
complete_hdr.fname = '<path>\Brainnetome_brainstem_combined.nii';
spm_write_vol(complete_hdr, completeAtlas)
