\n\n#---------------------------------
# New invocation of recon-all Wed May 21 21:59:50 CEST 2025 
#--------------------------------------------
#@# Tessellate lh Wed May 21 21:59:56 CEST 2025
\n mri_pretess ../mri/filled.mgz 255 ../mri/norm.mgz ../mri/filled-pretess255.mgz \n
\n mri_tessellate ../mri/filled-pretess255.mgz 255 ../surf/lh.orig.nofix \n
\n rm -f ../mri/filled-pretess255.mgz \n
\n mris_extract_main_component ../surf/lh.orig.nofix ../surf/lh.orig.nofix \n
#--------------------------------------------
#@# Smooth1 lh Wed May 21 22:00:02 CEST 2025
\n mris_smooth -nw -seed 1234 ../surf/lh.orig.nofix ../surf/lh.smoothwm.nofix \n
#--------------------------------------------
#@# Inflation1 lh Wed May 21 22:00:05 CEST 2025
\n mris_inflate -no-save-sulc ../surf/lh.smoothwm.nofix ../surf/lh.inflated.nofix \n
#--------------------------------------------
#@# QSphere lh Wed May 21 22:00:22 CEST 2025
\n mris_sphere -q -p 6 -a 128 -seed 1234 ../surf/lh.inflated.nofix ../surf/lh.qsphere.nofix \n
#@# Fix Topology lh Wed May 21 22:02:22 CEST 2025
\n mris_fix_topology -mgz -sphere qsphere.nofix -inflated inflated.nofix -orig orig.nofix -out orig.premesh -ga -seed 1234 sub-01 lh \n
\n mris_euler_number ../surf/lh.orig.premesh \n
\n mris_remesh --remesh --iters 3 --input /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/surf/lh.orig.premesh --output /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/surf/lh.orig \n
\n mris_remove_intersection ../surf/lh.orig ../surf/lh.orig \n
\n rm -f ../surf/lh.inflated \n
#--------------------------------------------
#@# AutoDetGWStats lh Wed May 21 22:03:42 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_autodet_gwstats --o ../surf/autodet.gw.stats.lh.dat --i brain.finalsurfs.mgz --wm wm.mgz --surf ../surf/lh.orig.premesh
#--------------------------------------------
#@# WhitePreAparc lh Wed May 21 22:03:47 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --adgws-in ../surf/autodet.gw.stats.lh.dat --wm wm.mgz --threads 8 --invol brain.finalsurfs.mgz --lh --i ../surf/lh.orig --o ../surf/lh.white.preaparc --white --seg aseg.presurf.mgz --nsmooth 5
#--------------------------------------------
#@# CortexLabel lh Wed May 21 22:07:07 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mri_label2label --label-cortex ../surf/lh.white.preaparc aseg.presurf.mgz 0 ../label/lh.cortex.label
#--------------------------------------------
#@# CortexLabel+HipAmyg lh Wed May 21 22:07:29 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mri_label2label --label-cortex ../surf/lh.white.preaparc aseg.presurf.mgz 1 ../label/lh.cortex+hipamyg.label
#--------------------------------------------
#@# Smooth2 lh Wed May 21 22:07:49 CEST 2025
\n mris_smooth -n 3 -nw -seed 1234 ../surf/lh.white.preaparc ../surf/lh.smoothwm \n
#--------------------------------------------
#@# Inflation2 lh Wed May 21 22:07:52 CEST 2025
\n mris_inflate ../surf/lh.smoothwm ../surf/lh.inflated \n
#--------------------------------------------
#@# Curv .H and .K lh Wed May 21 22:08:13 CEST 2025
\n mris_curvature -w -seed 1234 lh.white.preaparc \n
\n mris_curvature -seed 1234 -thresh .999 -n -a 5 -w -distances 10 10 lh.inflated \n
#--------------------------------------------
#@# Sphere lh Wed May 21 22:08:55 CEST 2025
\n mris_sphere -seed 1234 ../surf/lh.inflated ../surf/lh.sphere \n
#--------------------------------------------
#@# Surf Reg lh Wed May 21 22:16:34 CEST 2025
\n mris_register -curv ../surf/lh.sphere /Applications/freesurfer/7.4.1/average/lh.folding.atlas.acfb40.noaparc.i12.2016-08-02.tif ../surf/lh.sphere.reg \n
\n ln -sf lh.sphere.reg lh.fsaverage.sphere.reg \n
#--------------------------------------------
#@# Jacobian white lh Wed May 21 22:30:16 CEST 2025
\n mris_jacobian ../surf/lh.white.preaparc ../surf/lh.sphere.reg ../surf/lh.jacobian_white \n
#--------------------------------------------
#@# AvgCurv lh Wed May 21 22:30:17 CEST 2025
\n mrisp_paint -a 5 /Applications/freesurfer/7.4.1/average/lh.folding.atlas.acfb40.noaparc.i12.2016-08-02.tif#6 ../surf/lh.sphere.reg ../surf/lh.avg_curv \n
#-----------------------------------------
#@# Cortical Parc lh Wed May 21 22:30:19 CEST 2025
\n mris_ca_label -l ../label/lh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 sub-01 lh ../surf/lh.sphere.reg /Applications/freesurfer/7.4.1/average/lh.DKaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/lh.aparc.annot \n
#--------------------------------------------
#@# WhiteSurfs lh Wed May 21 22:30:30 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --adgws-in ../surf/autodet.gw.stats.lh.dat --seg aseg.presurf.mgz --threads 8 --wm wm.mgz --invol brain.finalsurfs.mgz --lh --i ../surf/lh.white.preaparc --o ../surf/lh.white --white --nsmooth 0 --rip-label ../label/lh.cortex.label --rip-bg --rip-surf ../surf/lh.white.preaparc --aparc ../label/lh.aparc.annot
#--------------------------------------------
#@# T1PialSurf lh Wed May 21 22:33:36 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --adgws-in ../surf/autodet.gw.stats.lh.dat --seg aseg.presurf.mgz --threads 8 --wm wm.mgz --invol brain.finalsurfs.mgz --lh --i ../surf/lh.white --o ../surf/lh.pial.T1 --pial --nsmooth 0 --rip-label ../label/lh.cortex+hipamyg.label --pin-medial-wall ../label/lh.cortex.label --aparc ../label/lh.aparc.annot --repulse-surf ../surf/lh.white --white-surf ../surf/lh.white
#@# white curv lh Wed May 21 22:37:44 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --curv-map ../surf/lh.white 2 10 ../surf/lh.curv
#@# white area lh Wed May 21 22:37:47 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --area-map ../surf/lh.white ../surf/lh.area
#@# pial curv lh Wed May 21 22:37:48 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --curv-map ../surf/lh.pial 2 10 ../surf/lh.curv.pial
#@# pial area lh Wed May 21 22:37:51 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --area-map ../surf/lh.pial ../surf/lh.area.pial
#@# thickness lh Wed May 21 22:37:53 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --thickness ../surf/lh.white ../surf/lh.pial 20 5 ../surf/lh.thickness
#@# area and vertex vol lh Wed May 21 22:38:28 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --thickness ../surf/lh.white ../surf/lh.pial 20 5 ../surf/lh.thickness
\n#-----------------------------------------
#@# Curvature Stats lh Wed May 21 22:38:31 CEST 2025
\n mris_curvature_stats -m --writeCurvatureFiles -G -o ../stats/lh.curv.stats -F smoothwm sub-01 lh curv sulc \n
#-----------------------------------------
#@# Cortical Parc 2 lh Wed May 21 22:38:36 CEST 2025
\n mris_ca_label -l ../label/lh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 sub-01 lh ../surf/lh.sphere.reg /Applications/freesurfer/7.4.1/average/lh.CDaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/lh.aparc.a2009s.annot \n
#-----------------------------------------
#@# Cortical Parc 3 lh Wed May 21 22:38:52 CEST 2025
\n mris_ca_label -l ../label/lh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 sub-01 lh ../surf/lh.sphere.reg /Applications/freesurfer/7.4.1/average/lh.DKTaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/lh.aparc.DKTatlas.annot \n
#-----------------------------------------
#@# WM/GM Contrast lh Wed May 21 22:39:08 CEST 2025
\n pctsurfcon --s sub-01 --lh-only \n
\n\n#---------------------------------
# New invocation of recon-all Thu May 22 00:04:06 CEST 2025 
#--------------------------------------------
#@# AutoDetGWStats lh Thu May 22 00:04:14 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_autodet_gwstats --o ../surf/autodet.gw.stats.lh.dat --i brain.finalsurfs.mgz --wm wm.mgz --surf ../surf/lh.orig.premesh
  Update not needed
#--------------------------------------------
#@# WhitePreAparc lh Thu May 22 00:04:15 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --adgws-in ../surf/autodet.gw.stats.lh.dat --wm wm.mgz --threads 8 --invol brain.finalsurfs.mgz --lh --i ../surf/lh.orig --o ../surf/lh.white.preaparc --white --seg aseg.presurf.mgz --nsmooth 5
   Update not needed
#--------------------------------------------
#@# CortexLabel lh Thu May 22 00:04:16 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mri_label2label --label-cortex ../surf/lh.white.preaparc aseg.presurf.mgz 0 ../label/lh.cortex.label
   Update not needed
#--------------------------------------------
#@# CortexLabel+HipAmyg lh Thu May 22 00:04:16 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mri_label2label --label-cortex ../surf/lh.white.preaparc aseg.presurf.mgz 1 ../label/lh.cortex+hipamyg.label
   Update not needed
#@# white curv lh Thu May 22 00:04:17 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --curv-map ../surf/lh.white 2 10 ../surf/lh.curv
   Update not needed
#@# white area lh Thu May 22 00:04:17 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --area-map ../surf/lh.white ../surf/lh.area
   Update not needed
#@# pial curv lh Thu May 22 00:04:18 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --curv-map ../surf/lh.pial 2 10 ../surf/lh.curv.pial
   Update not needed
#@# pial area lh Thu May 22 00:04:18 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --area-map ../surf/lh.pial ../surf/lh.area.pial
   Update not needed
#@# thickness lh Thu May 22 00:04:19 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --thickness ../surf/lh.white ../surf/lh.pial 20 5 ../surf/lh.thickness
   Update not needed
#@# area and vertex vol lh Thu May 22 00:04:19 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --thickness ../surf/lh.white ../surf/lh.pial 20 5 ../surf/lh.thickness
   Update not needed
#-----------------------------------------
#@# Parcellation Stats lh Thu May 22 00:04:20 CEST 2025
\n mris_anatomical_stats -th3 -mgz -noglobal -cortex ../label/lh.cortex.label -f ../stats/lh.aparc.stats -b -a ../label/lh.aparc.annot -c ../label/aparc.annot.ctab sub-01 lh white \n
\n mris_anatomical_stats -th3 -mgz -noglobal -cortex ../label/lh.cortex.label -f ../stats/lh.aparc.pial.stats -b -a ../label/lh.aparc.annot -c ../label/aparc.annot.ctab sub-01 lh pial \n
#-----------------------------------------
#@# Parcellation Stats 2 lh Thu May 22 00:05:05 CEST 2025
\n mris_anatomical_stats -th3 -mgz -noglobal -cortex ../label/lh.cortex.label -f ../stats/lh.aparc.a2009s.stats -b -a ../label/lh.aparc.a2009s.annot -c ../label/aparc.annot.a2009s.ctab sub-01 lh white \n
#-----------------------------------------
#@# Parcellation Stats 3 lh Thu May 22 00:05:30 CEST 2025
\n mris_anatomical_stats -th3 -mgz -noglobal -cortex ../label/lh.cortex.label -f ../stats/lh.aparc.DKTatlas.stats -b -a ../label/lh.aparc.DKTatlas.annot -c ../label/aparc.annot.DKTatlas.ctab sub-01 lh white \n
#--------------------------------------------
#@# BA_exvivo Labels lh Thu May 22 00:05:53 CEST 2025
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/lh.BA1_exvivo.label --trgsubject sub-01 --trglabel ./lh.BA1_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/lh.BA2_exvivo.label --trgsubject sub-01 --trglabel ./lh.BA2_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/lh.BA3a_exvivo.label --trgsubject sub-01 --trglabel ./lh.BA3a_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/lh.BA3b_exvivo.label --trgsubject sub-01 --trglabel ./lh.BA3b_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/lh.BA4a_exvivo.label --trgsubject sub-01 --trglabel ./lh.BA4a_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/lh.BA4p_exvivo.label --trgsubject sub-01 --trglabel ./lh.BA4p_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/lh.BA6_exvivo.label --trgsubject sub-01 --trglabel ./lh.BA6_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/lh.BA44_exvivo.label --trgsubject sub-01 --trglabel ./lh.BA44_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/lh.BA45_exvivo.label --trgsubject sub-01 --trglabel ./lh.BA45_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/lh.V1_exvivo.label --trgsubject sub-01 --trglabel ./lh.V1_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/lh.V2_exvivo.label --trgsubject sub-01 --trglabel ./lh.V2_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/lh.MT_exvivo.label --trgsubject sub-01 --trglabel ./lh.MT_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/lh.entorhinal_exvivo.label --trgsubject sub-01 --trglabel ./lh.entorhinal_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/lh.perirhinal_exvivo.label --trgsubject sub-01 --trglabel ./lh.perirhinal_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/lh.FG1.mpm.vpnl.label --trgsubject sub-01 --trglabel ./lh.FG1.mpm.vpnl.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/lh.FG2.mpm.vpnl.label --trgsubject sub-01 --trglabel ./lh.FG2.mpm.vpnl.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/lh.FG3.mpm.vpnl.label --trgsubject sub-01 --trglabel ./lh.FG3.mpm.vpnl.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/lh.FG4.mpm.vpnl.label --trgsubject sub-01 --trglabel ./lh.FG4.mpm.vpnl.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/lh.hOc1.mpm.vpnl.label --trgsubject sub-01 --trglabel ./lh.hOc1.mpm.vpnl.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/lh.hOc2.mpm.vpnl.label --trgsubject sub-01 --trglabel ./lh.hOc2.mpm.vpnl.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/lh.hOc3v.mpm.vpnl.label --trgsubject sub-01 --trglabel ./lh.hOc3v.mpm.vpnl.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/lh.hOc4v.mpm.vpnl.label --trgsubject sub-01 --trglabel ./lh.hOc4v.mpm.vpnl.label --hemi lh --regmethod surface \n
\n mris_label2annot --s sub-01 --ctab /Applications/freesurfer/7.4.1/average/colortable_vpnl.txt --hemi lh --a mpm.vpnl --maxstatwinner --noverbose --l lh.FG1.mpm.vpnl.label --l lh.FG2.mpm.vpnl.label --l lh.FG3.mpm.vpnl.label --l lh.FG4.mpm.vpnl.label --l lh.hOc1.mpm.vpnl.label --l lh.hOc2.mpm.vpnl.label --l lh.hOc3v.mpm.vpnl.label --l lh.hOc4v.mpm.vpnl.label \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/lh.BA1_exvivo.thresh.label --trgsubject sub-01 --trglabel ./lh.BA1_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/lh.BA2_exvivo.thresh.label --trgsubject sub-01 --trglabel ./lh.BA2_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/lh.BA3a_exvivo.thresh.label --trgsubject sub-01 --trglabel ./lh.BA3a_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/lh.BA3b_exvivo.thresh.label --trgsubject sub-01 --trglabel ./lh.BA3b_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/lh.BA4a_exvivo.thresh.label --trgsubject sub-01 --trglabel ./lh.BA4a_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/lh.BA4p_exvivo.thresh.label --trgsubject sub-01 --trglabel ./lh.BA4p_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/lh.BA6_exvivo.thresh.label --trgsubject sub-01 --trglabel ./lh.BA6_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/lh.BA44_exvivo.thresh.label --trgsubject sub-01 --trglabel ./lh.BA44_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/lh.BA45_exvivo.thresh.label --trgsubject sub-01 --trglabel ./lh.BA45_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/lh.V1_exvivo.thresh.label --trgsubject sub-01 --trglabel ./lh.V1_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/lh.V2_exvivo.thresh.label --trgsubject sub-01 --trglabel ./lh.V2_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/lh.MT_exvivo.thresh.label --trgsubject sub-01 --trglabel ./lh.MT_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/lh.entorhinal_exvivo.thresh.label --trgsubject sub-01 --trglabel ./lh.entorhinal_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/lh.perirhinal_exvivo.thresh.label --trgsubject sub-01 --trglabel ./lh.perirhinal_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mris_label2annot --s sub-01 --hemi lh --ctab /Applications/freesurfer/7.4.1/average/colortable_BA.txt --l lh.BA1_exvivo.label --l lh.BA2_exvivo.label --l lh.BA3a_exvivo.label --l lh.BA3b_exvivo.label --l lh.BA4a_exvivo.label --l lh.BA4p_exvivo.label --l lh.BA6_exvivo.label --l lh.BA44_exvivo.label --l lh.BA45_exvivo.label --l lh.V1_exvivo.label --l lh.V2_exvivo.label --l lh.MT_exvivo.label --l lh.perirhinal_exvivo.label --l lh.entorhinal_exvivo.label --a BA_exvivo --maxstatwinner --noverbose \n
\n mris_label2annot --s sub-01 --hemi lh --ctab /Applications/freesurfer/7.4.1/average/colortable_BA.txt --l lh.BA1_exvivo.thresh.label --l lh.BA2_exvivo.thresh.label --l lh.BA3a_exvivo.thresh.label --l lh.BA3b_exvivo.thresh.label --l lh.BA4a_exvivo.thresh.label --l lh.BA4p_exvivo.thresh.label --l lh.BA6_exvivo.thresh.label --l lh.BA44_exvivo.thresh.label --l lh.BA45_exvivo.thresh.label --l lh.V1_exvivo.thresh.label --l lh.V2_exvivo.thresh.label --l lh.MT_exvivo.thresh.label --l lh.perirhinal_exvivo.thresh.label --l lh.entorhinal_exvivo.thresh.label --a BA_exvivo.thresh --maxstatwinner --noverbose \n
\n mris_anatomical_stats -th3 -mgz -noglobal -f ../stats/lh.BA_exvivo.stats -b -a ./lh.BA_exvivo.annot -c ./BA_exvivo.ctab sub-01 lh white \n
\n mris_anatomical_stats -th3 -mgz -f ../stats/lh.BA_exvivo.thresh.stats -noglobal -b -a ./lh.BA_exvivo.thresh.annot -c ./BA_exvivo.thresh.ctab sub-01 lh white \n
