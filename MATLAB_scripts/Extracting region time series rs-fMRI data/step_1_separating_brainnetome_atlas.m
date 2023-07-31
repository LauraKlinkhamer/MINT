% Preparation of brain atlases for MINT study MRI analysis
% Step 1: preparing the Brainnetome atlas, and a subatlas including 
% the cortical areas in the Brainnetome atlas 
% Laura Klinkhamer & Joana Leitão
% 18/12/2022 

%% Loading the Halfpipe Brainnetome_Buckner atlas (see ReadMe file in H:\MINT\Analyses\Atlases\Applied)

brainnetome_buckner_folder = '<path>'
brainnetome_buckner_atlas = fullfile(brainnetome_buckner_folder, 'tpl-MNI152NLin2009cAsym_atlas-brainnetomeCombined_dseg.nii')
brainnetome_buckner_hdr = spm_vol(brainnetome_buckner_atlas);
brainnetome_buckner_image = spm_read_vols(brainnetome_buckner_hdr);

%% Separating the Brainnetome_atlas
% only selecting the Brainnetome ROIs by setting Buckner Cerebellar Network ROI voxels to 0
brainnetome_max = 246; 
buckner_ind = find(brainnetome_buckner_image > brainnetome_max);
brainnetome_atlas = brainnetome_buckner_image;
brainnetome_atlas(buckner_ind) = 0;
length(unique(brainnetome_atlas)) % should be 247, 246 ROIs + 0

brainnetome_atlas_hdr = brainnetome_buckner_hdr;
brainnetome_atlas_hdr.fname = '<path>\Brainnetome_atlas.nii';
spm_write_vol(brainnetome_atlas_hdr, brainnetome_atlas)

%% Separating the cortical areas in the Brainnetome atlas 
% For overlaying with Yeo et al., 2011 cortical networks later in the LEiDA. 
% Regions 211-246 are considered subcortical nuclei in the Brainnetome
% atlas, setting those regions to 0 here 

brainnetome_cortical_max = 210;
subcortical_ind = find(brainnetome_atlas > brainnetome_cortical_max);
brainnetome_cortical_atlas = brainnetome_atlas;
brainnetome_cortical_atlas(subcortical_ind) = 0;
length(unique(brainnetome_cortical_atlas)) % should be 211, 210 ROIs + 0

brainnetome_cortical_atlas_hdr = brainnetome_atlas_hdr;
brainnetome_cortical_atlas_hdr.fname = '<path>\Brainnetome_cortical_atlas.nii';
spm_write_vol(brainnetome_cortical_atlas_hdr, brainnetome_cortical_atlas)
