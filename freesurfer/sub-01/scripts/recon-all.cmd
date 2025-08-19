\n\n#---------------------------------
# New invocation of recon-all Wed May 21 12:54:03 CEST 2025 
\n mri_convert /Users/martinnorgaard/Documents/MIB/parcon/AgingStudy/data/work/smriprep_wf/single_subject_01_wf/anat_preproc_wf/anat_template_wf/anat_merge/sub-01_T1w_ras_template.nii /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri/orig/001.mgz \n
#--------------------------------------------
#@# MotionCor Wed May 21 12:54:11 CEST 2025
\n cp /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri/orig/001.mgz /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri/rawavg.mgz \n
\n mri_info /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri/rawavg.mgz \n
\n mri_convert /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri/rawavg.mgz /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri/orig.mgz --conform \n
\n mri_add_xform_to_header -c /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri/transforms/talairach.xfm /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri/orig.mgz /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri/orig.mgz \n
\n mri_info /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri/orig.mgz \n
#--------------------------------------------
#@# Talairach Wed May 21 12:54:20 CEST 2025
\n mri_nu_correct.mni --no-rescale --i orig.mgz --o orig_nu.mgz --ants-n4 --n 1 --proto-iters 1000 --distance 50 \n
\n talairach_avi --i orig_nu.mgz --xfm transforms/talairach.auto.xfm \n
talairach_avi log file is transforms/talairach_avi.log...
\n cp transforms/talairach.auto.xfm transforms/talairach.xfm \n
lta_convert --src orig.mgz --trg /Applications/freesurfer/7.4.1/average/mni305.cor.mgz --inxfm transforms/talairach.xfm --outlta transforms/talairach.xfm.lta --subject fsaverage --ltavox2vox
#--------------------------------------------
#@# Talairach Failure Detection Wed May 21 12:57:37 CEST 2025
\n talairach_afd -T 0.005 -xfm transforms/talairach.xfm \n
\n awk -f /Applications/freesurfer/7.4.1/bin/extract_talairach_avi_QA.awk /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri/transforms/talairach_avi.log \n
\n tal_QC_AZS /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri/transforms/talairach_avi.log \n
#--------------------------------------------
#@# Nu Intensity Correction Wed May 21 12:57:38 CEST 2025
\n mri_nu_correct.mni --i orig.mgz --o nu.mgz --uchar transforms/talairach.xfm --n 2 --ants-n4 \n
\n mri_add_xform_to_header -c /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri/transforms/talairach.xfm nu.mgz nu.mgz \n
#--------------------------------------------
#@# Intensity Normalization Wed May 21 13:00:30 CEST 2025
\n mri_normalize -g 1 -seed 1234 -mprage nu.mgz T1.mgz \n
\n\n#---------------------------------
# New invocation of recon-all Wed May 21 16:42:05 CEST 2025 
#-------------------------------------
#@# EM Registration Wed May 21 16:42:10 CEST 2025
\n mri_em_register -uns 3 -mask brainmask.mgz nu.mgz /Applications/freesurfer/7.4.1/average/RB_all_2020-01-02.gca transforms/talairach.lta \n
\n\n#---------------------------------
# New invocation of recon-all Wed May 21 17:05:58 CEST 2025 
#--------------------------------------
#@# CA Normalize Wed May 21 17:06:03 CEST 2025
\n mri_ca_normalize -c ctrl_pts.mgz -mask brainmask.mgz nu.mgz /Applications/freesurfer/7.4.1/average/RB_all_2020-01-02.gca transforms/talairach.lta norm.mgz \n
#--------------------------------------
#@# CA Reg Wed May 21 17:07:02 CEST 2025
\n mri_ca_register -nobigventricles -T transforms/talairach.lta -align-after -mask brainmask.mgz norm.mgz /Applications/freesurfer/7.4.1/average/RB_all_2020-01-02.gca transforms/talairach.m3z \n
#--------------------------------------
#@# SubCort Seg Wed May 21 18:47:05 CEST 2025
\n mri_ca_label -relabel_unlikely 9 .3 -prior 0.5 -align norm.mgz transforms/talairach.m3z /Applications/freesurfer/7.4.1/average/RB_all_2020-01-02.gca aseg.auto_noCCseg.mgz \n
#--------------------------------------
#@# CC Seg Wed May 21 19:14:40 CEST 2025
\n mri_cc -aseg aseg.auto_noCCseg.mgz -o aseg.auto.mgz -lta /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri/transforms/cc_up.lta sub-01 \n
#--------------------------------------
#@# Merge ASeg Wed May 21 19:15:19 CEST 2025
\n cp aseg.auto.mgz aseg.presurf.mgz \n
#--------------------------------------------
#@# Intensity Normalization2 Wed May 21 19:15:20 CEST 2025
\n mri_normalize -seed 1234 -mprage -aseg aseg.presurf.mgz -mask brainmask.mgz norm.mgz brain.mgz \n
#--------------------------------------------
#@# Mask BFS Wed May 21 19:18:28 CEST 2025
\n mri_mask -T 5 brain.mgz brainmask.mgz brain.finalsurfs.mgz \n
#--------------------------------------------
#@# WM Segmentation Wed May 21 19:18:30 CEST 2025
\n AntsDenoiseImageFs -i brain.mgz -o antsdn.brain.mgz \n
\n mri_segment -wsizemm 13 -mprage antsdn.brain.mgz wm.seg.mgz \n
\n mri_edit_wm_with_aseg -keep-in wm.seg.mgz brain.mgz aseg.presurf.mgz wm.asegedit.mgz \n
\n mri_pretess wm.asegedit.mgz wm norm.mgz wm.mgz \n
#--------------------------------------------
#@# Fill Wed May 21 19:20:44 CEST 2025
\n mri_fill -a ../scripts/ponscc.cut.log -xform transforms/talairach.lta -segmentation aseg.presurf.mgz -ctab /Applications/freesurfer/7.4.1/SubCorticalMassLUT.txt wm.mgz filled.mgz \n
 cp filled.mgz filled.auto.mgz
\n\n#---------------------------------
# New invocation of recon-all Wed May 21 22:46:26 CEST 2025 
#@# white curv lh Wed May 21 22:46:31 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --curv-map ../surf/lh.white 2 10 ../surf/lh.curv
   Update not needed
#@# white area lh Wed May 21 22:46:31 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --area-map ../surf/lh.white ../surf/lh.area
   Update not needed
#@# pial curv lh Wed May 21 22:46:32 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --curv-map ../surf/lh.pial 2 10 ../surf/lh.curv.pial
   Update not needed
#@# pial area lh Wed May 21 22:46:32 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --area-map ../surf/lh.pial ../surf/lh.area.pial
   Update not needed
#@# thickness lh Wed May 21 22:46:33 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --thickness ../surf/lh.white ../surf/lh.pial 20 5 ../surf/lh.thickness
   Update not needed
#@# area and vertex vol lh Wed May 21 22:46:33 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --thickness ../surf/lh.white ../surf/lh.pial 20 5 ../surf/lh.thickness
   Update not needed
#@# white curv rh Wed May 21 22:46:33 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --curv-map ../surf/rh.white 2 10 ../surf/rh.curv
   Update not needed
#@# white area rh Wed May 21 22:46:34 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --area-map ../surf/rh.white ../surf/rh.area
   Update not needed
#@# pial curv rh Wed May 21 22:46:34 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --curv-map ../surf/rh.pial 2 10 ../surf/rh.curv.pial
   Update not needed
#@# pial area rh Wed May 21 22:46:34 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --area-map ../surf/rh.pial ../surf/rh.area.pial
   Update not needed
#@# thickness rh Wed May 21 22:46:34 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --thickness ../surf/rh.white ../surf/rh.pial 20 5 ../surf/rh.thickness
   Update not needed
#@# area and vertex vol rh Wed May 21 22:46:35 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --thickness ../surf/rh.white ../surf/rh.pial 20 5 ../surf/rh.thickness
   Update not needed
#--------------------------------------------
#@# Cortical ribbon mask Wed May 21 22:46:35 CEST 2025
\n mris_volmask --aseg_name aseg.presurf --label_left_white 2 --label_left_ribbon 3 --label_right_white 41 --label_right_ribbon 42 --save_ribbon sub-01 \n
\n\n#---------------------------------
# New invocation of recon-all Thu May 22 00:17:31 CEST 2025 
#--------------------------------------------
#@# WhiteSurfs lh Thu May 22 00:17:41 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --adgws-in ../surf/autodet.gw.stats.lh.dat --seg aseg.presurf.mgz --threads 8 --wm wm.mgz --invol brain.finalsurfs.mgz --lh --i ../surf/lh.white.preaparc --o ../surf/lh.white --white --nsmooth 0 --rip-label ../label/lh.cortex.label --rip-bg --rip-surf ../surf/lh.white.preaparc --aparc ../label/lh.aparc.annot
   Update not needed
#--------------------------------------------
#@# WhiteSurfs rh Thu May 22 00:17:42 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --adgws-in ../surf/autodet.gw.stats.rh.dat --seg aseg.presurf.mgz --threads 8 --wm wm.mgz --invol brain.finalsurfs.mgz --rh --i ../surf/rh.white.preaparc --o ../surf/rh.white --white --nsmooth 0 --rip-label ../label/rh.cortex.label --rip-bg --rip-surf ../surf/rh.white.preaparc --aparc ../label/rh.aparc.annot
   Update not needed
#@# white curv lh Thu May 22 00:17:43 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --curv-map ../surf/lh.white 2 10 ../surf/lh.curv
   Update not needed
#@# white area lh Thu May 22 00:17:44 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --area-map ../surf/lh.white ../surf/lh.area
   Update not needed
#@# pial curv lh Thu May 22 00:17:44 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --curv-map ../surf/lh.pial 2 10 ../surf/lh.curv.pial
   Update not needed
#@# pial area lh Thu May 22 00:17:45 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --area-map ../surf/lh.pial ../surf/lh.area.pial
   Update not needed
#@# thickness lh Thu May 22 00:17:45 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --thickness ../surf/lh.white ../surf/lh.pial 20 5 ../surf/lh.thickness
   Update not needed
#@# area and vertex vol lh Thu May 22 00:17:46 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --thickness ../surf/lh.white ../surf/lh.pial 20 5 ../surf/lh.thickness
   Update not needed
#@# white curv rh Thu May 22 00:17:47 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --curv-map ../surf/rh.white 2 10 ../surf/rh.curv
   Update not needed
#@# white area rh Thu May 22 00:17:47 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --area-map ../surf/rh.white ../surf/rh.area
   Update not needed
#@# pial curv rh Thu May 22 00:17:48 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --curv-map ../surf/rh.pial 2 10 ../surf/rh.curv.pial
   Update not needed
#@# pial area rh Thu May 22 00:17:49 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --area-map ../surf/rh.pial ../surf/rh.area.pial
   Update not needed
#@# thickness rh Thu May 22 00:17:49 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --thickness ../surf/rh.white ../surf/rh.pial 20 5 ../surf/rh.thickness
   Update not needed
#@# area and vertex vol rh Thu May 22 00:17:50 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --thickness ../surf/rh.white ../surf/rh.pial 20 5 ../surf/rh.thickness
   Update not needed
\n#-----------------------------------------
#@# Curvature Stats lh Thu May 22 00:17:51 CEST 2025
\n mris_curvature_stats -m --writeCurvatureFiles -G -o ../stats/lh.curv.stats -F smoothwm sub-01 lh curv sulc \n
\n#-----------------------------------------
#@# Curvature Stats rh Thu May 22 00:18:03 CEST 2025
\n mris_curvature_stats -m --writeCurvatureFiles -G -o ../stats/rh.curv.stats -F smoothwm sub-01 rh curv sulc \n
#-----------------------------------------
#@# Relabel Hypointensities Thu May 22 00:18:22 CEST 2025
\n mri_relabel_hypointensities aseg.presurf.mgz ../surf aseg.presurf.hypos.mgz \n
#-----------------------------------------
#@# APas-to-ASeg Thu May 22 00:19:19 CEST 2025
\n mri_surf2volseg --o aseg.mgz --i aseg.presurf.hypos.mgz --fix-presurf-with-ribbon /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri/ribbon.mgz --threads 8 --lh-cortex-mask /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/label/lh.cortex.label --lh-white /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/surf/lh.white --lh-pial /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/surf/lh.pial --rh-cortex-mask /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/label/rh.cortex.label --rh-white /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/surf/rh.white --rh-pial /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/surf/rh.pial \n
\n mri_brainvol_stats --subject sub-01 \n
#-----------------------------------------
#@# AParc-to-ASeg aparc Thu May 22 00:20:06 CEST 2025
\n mri_surf2volseg --o aparc+aseg.mgz --label-cortex --i aseg.mgz --threads 8 --lh-annot /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/label/lh.aparc.annot 1000 --lh-cortex-mask /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/label/lh.cortex.label --lh-white /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/surf/lh.white --lh-pial /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/surf/lh.pial --rh-annot /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/label/rh.aparc.annot 2000 --rh-cortex-mask /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/label/rh.cortex.label --rh-white /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/surf/rh.white --rh-pial /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/surf/rh.pial \n
#-----------------------------------------
#@# AParc-to-ASeg aparc.a2009s Thu May 22 00:26:01 CEST 2025
\n mri_surf2volseg --o aparc.a2009s+aseg.mgz --label-cortex --i aseg.mgz --threads 8 --lh-annot /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/label/lh.aparc.a2009s.annot 11100 --lh-cortex-mask /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/label/lh.cortex.label --lh-white /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/surf/lh.white --lh-pial /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/surf/lh.pial --rh-annot /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/label/rh.aparc.a2009s.annot 12100 --rh-cortex-mask /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/label/rh.cortex.label --rh-white /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/surf/rh.white --rh-pial /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/surf/rh.pial \n
#-----------------------------------------
#@# AParc-to-ASeg aparc.DKTatlas Thu May 22 00:33:19 CEST 2025
\n mri_surf2volseg --o aparc.DKTatlas+aseg.mgz --label-cortex --i aseg.mgz --threads 8 --lh-annot /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/label/lh.aparc.DKTatlas.annot 1000 --lh-cortex-mask /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/label/lh.cortex.label --lh-white /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/surf/lh.white --lh-pial /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/surf/lh.pial --rh-annot /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/label/rh.aparc.DKTatlas.annot 2000 --rh-cortex-mask /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/label/rh.cortex.label --rh-white /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/surf/rh.white --rh-pial /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/surf/rh.pial \n
#-----------------------------------------
#@# WMParc Thu May 22 00:40:03 CEST 2025
\n mri_surf2volseg --o wmparc.mgz --label-wm --i aparc+aseg.mgz --threads 8 --lh-annot /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/label/lh.aparc.annot 3000 --lh-cortex-mask /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/label/lh.cortex.label --lh-white /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/surf/lh.white --lh-pial /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/surf/lh.pial --rh-annot /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/label/rh.aparc.annot 4000 --rh-cortex-mask /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/label/rh.cortex.label --rh-white /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/surf/rh.white --rh-pial /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/surf/rh.pial \n
\n mri_segstats --seed 1234 --seg mri/wmparc.mgz --sum stats/wmparc.stats --pv mri/norm.mgz --excludeid 0 --brainmask mri/brainmask.mgz --in mri/norm.mgz --in-intensity-name norm --in-intensity-units MR --subject sub-01 --surf-wm-vol --ctab /Applications/freesurfer/7.4.1/WMParcStatsLUT.txt --etiv \n
#--------------------------------------------
#@# ASeg Stats Thu May 22 01:06:06 CEST 2025
\n mri_segstats --seed 1234 --seg mri/aseg.mgz --sum stats/aseg.stats --pv mri/norm.mgz --empty --brainmask mri/brainmask.mgz --brain-vol-from-seg --excludeid 0 --excl-ctxgmwm --supratent --subcortgray --in mri/norm.mgz --in-intensity-name norm --in-intensity-units MR --etiv --surf-wm-vol --surf-ctx-vol --totalgray --euler --ctab /Applications/freesurfer/7.4.1/ASegStatsLUT.txt --subject sub-01 \n
