\n\n#---------------------------------
# New invocation of recon-all Wed May 21 22:00:41 CEST 2025 
#--------------------------------------------
#@# Tessellate rh Wed May 21 22:00:47 CEST 2025
\n mri_pretess ../mri/filled.mgz 127 ../mri/norm.mgz ../mri/filled-pretess127.mgz \n
\n mri_tessellate ../mri/filled-pretess127.mgz 127 ../surf/rh.orig.nofix \n
\n rm -f ../mri/filled-pretess127.mgz \n
\n mris_extract_main_component ../surf/rh.orig.nofix ../surf/rh.orig.nofix \n
#--------------------------------------------
#@# Smooth1 rh Wed May 21 22:00:53 CEST 2025
\n mris_smooth -nw -seed 1234 ../surf/rh.orig.nofix ../surf/rh.smoothwm.nofix \n
#--------------------------------------------
#@# Inflation1 rh Wed May 21 22:00:57 CEST 2025
\n mris_inflate -no-save-sulc ../surf/rh.smoothwm.nofix ../surf/rh.inflated.nofix \n
#--------------------------------------------
#@# QSphere rh Wed May 21 22:01:15 CEST 2025
\n mris_sphere -q -p 6 -a 128 -seed 1234 ../surf/rh.inflated.nofix ../surf/rh.qsphere.nofix \n
#@# Fix Topology rh Wed May 21 22:03:14 CEST 2025
\n mris_fix_topology -mgz -sphere qsphere.nofix -inflated inflated.nofix -orig orig.nofix -out orig.premesh -ga -seed 1234 sub-01 rh \n
\n mris_euler_number ../surf/rh.orig.premesh \n
\n mris_remesh --remesh --iters 3 --input /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/surf/rh.orig.premesh --output /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/surf/rh.orig \n
\n mris_remove_intersection ../surf/rh.orig ../surf/rh.orig \n
\n rm -f ../surf/rh.inflated \n
#--------------------------------------------
#@# AutoDetGWStats rh Wed May 21 22:06:56 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_autodet_gwstats --o ../surf/autodet.gw.stats.rh.dat --i brain.finalsurfs.mgz --wm wm.mgz --surf ../surf/rh.orig.premesh
#--------------------------------------------
#@# WhitePreAparc rh Wed May 21 22:07:02 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --adgws-in ../surf/autodet.gw.stats.rh.dat --wm wm.mgz --threads 8 --invol brain.finalsurfs.mgz --rh --i ../surf/rh.orig --o ../surf/rh.white.preaparc --white --seg aseg.presurf.mgz --nsmooth 5
#--------------------------------------------
#@# CortexLabel rh Wed May 21 22:10:13 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mri_label2label --label-cortex ../surf/rh.white.preaparc aseg.presurf.mgz 0 ../label/rh.cortex.label
#--------------------------------------------
#@# CortexLabel+HipAmyg rh Wed May 21 22:10:32 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mri_label2label --label-cortex ../surf/rh.white.preaparc aseg.presurf.mgz 1 ../label/rh.cortex+hipamyg.label
#--------------------------------------------
#@# Smooth2 rh Wed May 21 22:10:51 CEST 2025
\n mris_smooth -n 3 -nw -seed 1234 ../surf/rh.white.preaparc ../surf/rh.smoothwm \n
#--------------------------------------------
#@# Inflation2 rh Wed May 21 22:10:55 CEST 2025
\n mris_inflate ../surf/rh.smoothwm ../surf/rh.inflated \n
#--------------------------------------------
#@# Curv .H and .K rh Wed May 21 22:11:16 CEST 2025
\n mris_curvature -w -seed 1234 rh.white.preaparc \n
\n mris_curvature -seed 1234 -thresh .999 -n -a 5 -w -distances 10 10 rh.inflated \n
#--------------------------------------------
#@# Sphere rh Wed May 21 22:11:58 CEST 2025
\n mris_sphere -seed 1234 ../surf/rh.inflated ../surf/rh.sphere \n
#--------------------------------------------
#@# Surf Reg rh Wed May 21 22:19:14 CEST 2025
\n mris_register -curv ../surf/rh.sphere /Applications/freesurfer/7.4.1/average/rh.folding.atlas.acfb40.noaparc.i12.2016-08-02.tif ../surf/rh.sphere.reg \n
\n ln -sf rh.sphere.reg rh.fsaverage.sphere.reg \n
#--------------------------------------------
#@# Jacobian white rh Wed May 21 22:36:19 CEST 2025
\n mris_jacobian ../surf/rh.white.preaparc ../surf/rh.sphere.reg ../surf/rh.jacobian_white \n
#--------------------------------------------
#@# AvgCurv rh Wed May 21 22:36:21 CEST 2025
\n mrisp_paint -a 5 /Applications/freesurfer/7.4.1/average/rh.folding.atlas.acfb40.noaparc.i12.2016-08-02.tif#6 ../surf/rh.sphere.reg ../surf/rh.avg_curv \n
#-----------------------------------------
#@# Cortical Parc rh Wed May 21 22:36:23 CEST 2025
\n mris_ca_label -l ../label/rh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 sub-01 rh ../surf/rh.sphere.reg /Applications/freesurfer/7.4.1/average/rh.DKaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/rh.aparc.annot \n
#--------------------------------------------
#@# WhiteSurfs rh Wed May 21 22:36:35 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --adgws-in ../surf/autodet.gw.stats.rh.dat --seg aseg.presurf.mgz --threads 8 --wm wm.mgz --invol brain.finalsurfs.mgz --rh --i ../surf/rh.white.preaparc --o ../surf/rh.white --white --nsmooth 0 --rip-label ../label/rh.cortex.label --rip-bg --rip-surf ../surf/rh.white.preaparc --aparc ../label/rh.aparc.annot
#--------------------------------------------
#@# T1PialSurf rh Wed May 21 22:40:11 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --adgws-in ../surf/autodet.gw.stats.rh.dat --seg aseg.presurf.mgz --threads 8 --wm wm.mgz --invol brain.finalsurfs.mgz --rh --i ../surf/rh.white --o ../surf/rh.pial.T1 --pial --nsmooth 0 --rip-label ../label/rh.cortex+hipamyg.label --pin-medial-wall ../label/rh.cortex.label --aparc ../label/rh.aparc.annot --repulse-surf ../surf/rh.white --white-surf ../surf/rh.white
#@# white curv rh Wed May 21 22:44:51 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --curv-map ../surf/rh.white 2 10 ../surf/rh.curv
#@# white area rh Wed May 21 22:44:54 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --area-map ../surf/rh.white ../surf/rh.area
#@# pial curv rh Wed May 21 22:44:56 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --curv-map ../surf/rh.pial 2 10 ../surf/rh.curv.pial
#@# pial area rh Wed May 21 22:44:59 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --area-map ../surf/rh.pial ../surf/rh.area.pial
#@# thickness rh Wed May 21 22:45:00 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --thickness ../surf/rh.white ../surf/rh.pial 20 5 ../surf/rh.thickness
#@# area and vertex vol rh Wed May 21 22:45:36 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --thickness ../surf/rh.white ../surf/rh.pial 20 5 ../surf/rh.thickness
\n#-----------------------------------------
#@# Curvature Stats rh Wed May 21 22:45:39 CEST 2025
\n mris_curvature_stats -m --writeCurvatureFiles -G -o ../stats/rh.curv.stats -F smoothwm sub-01 rh curv sulc \n
#-----------------------------------------
#@# Cortical Parc 2 rh Wed May 21 22:45:44 CEST 2025
\n mris_ca_label -l ../label/rh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 sub-01 rh ../surf/rh.sphere.reg /Applications/freesurfer/7.4.1/average/rh.CDaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/rh.aparc.a2009s.annot \n
#-----------------------------------------
#@# Cortical Parc 3 rh Wed May 21 22:46:01 CEST 2025
\n mris_ca_label -l ../label/rh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 sub-01 rh ../surf/rh.sphere.reg /Applications/freesurfer/7.4.1/average/rh.DKTaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/rh.aparc.DKTatlas.annot \n
#-----------------------------------------
#@# WM/GM Contrast rh Wed May 21 22:46:14 CEST 2025
\n pctsurfcon --s sub-01 --rh-only \n
\n\n#---------------------------------
# New invocation of recon-all Thu May 22 00:06:37 CEST 2025 
#--------------------------------------------
#@# AutoDetGWStats rh Thu May 22 00:06:46 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_autodet_gwstats --o ../surf/autodet.gw.stats.rh.dat --i brain.finalsurfs.mgz --wm wm.mgz --surf ../surf/rh.orig.premesh
  Update not needed
#--------------------------------------------
#@# WhitePreAparc rh Thu May 22 00:06:47 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --adgws-in ../surf/autodet.gw.stats.rh.dat --wm wm.mgz --threads 8 --invol brain.finalsurfs.mgz --rh --i ../surf/rh.orig --o ../surf/rh.white.preaparc --white --seg aseg.presurf.mgz --nsmooth 5
   Update not needed
#--------------------------------------------
#@# CortexLabel rh Thu May 22 00:06:48 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mri_label2label --label-cortex ../surf/rh.white.preaparc aseg.presurf.mgz 0 ../label/rh.cortex.label
   Update not needed
#--------------------------------------------
#@# CortexLabel+HipAmyg rh Thu May 22 00:06:48 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mri_label2label --label-cortex ../surf/rh.white.preaparc aseg.presurf.mgz 1 ../label/rh.cortex+hipamyg.label
   Update not needed
#@# white curv rh Thu May 22 00:06:49 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --curv-map ../surf/rh.white 2 10 ../surf/rh.curv
   Update not needed
#@# white area rh Thu May 22 00:06:49 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --area-map ../surf/rh.white ../surf/rh.area
   Update not needed
#@# pial curv rh Thu May 22 00:06:50 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --curv-map ../surf/rh.pial 2 10 ../surf/rh.curv.pial
   Update not needed
#@# pial area rh Thu May 22 00:06:50 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --area-map ../surf/rh.pial ../surf/rh.area.pial
   Update not needed
#@# thickness rh Thu May 22 00:06:51 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --thickness ../surf/rh.white ../surf/rh.pial 20 5 ../surf/rh.thickness
   Update not needed
#@# area and vertex vol rh Thu May 22 00:06:52 CEST 2025
cd /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/sub-01/mri
mris_place_surface --thickness ../surf/rh.white ../surf/rh.pial 20 5 ../surf/rh.thickness
   Update not needed
#-----------------------------------------
#@# Parcellation Stats rh Thu May 22 00:06:52 CEST 2025
\n mris_anatomical_stats -th3 -mgz -noglobal -cortex ../label/rh.cortex.label -f ../stats/rh.aparc.stats -b -a ../label/rh.aparc.annot -c ../label/aparc.annot.ctab sub-01 rh white \n
\n mris_anatomical_stats -th3 -mgz -noglobal -cortex ../label/rh.cortex.label -f ../stats/rh.aparc.pial.stats -b -a ../label/rh.aparc.annot -c ../label/aparc.annot.ctab sub-01 rh pial \n
#-----------------------------------------
#@# Parcellation Stats 2 rh Thu May 22 00:07:40 CEST 2025
\n mris_anatomical_stats -th3 -mgz -noglobal -cortex ../label/rh.cortex.label -f ../stats/rh.aparc.a2009s.stats -b -a ../label/rh.aparc.a2009s.annot -c ../label/aparc.annot.a2009s.ctab sub-01 rh white \n
#-----------------------------------------
#@# Parcellation Stats 3 rh Thu May 22 00:08:04 CEST 2025
\n mris_anatomical_stats -th3 -mgz -noglobal -cortex ../label/rh.cortex.label -f ../stats/rh.aparc.DKTatlas.stats -b -a ../label/rh.aparc.DKTatlas.annot -c ../label/aparc.annot.DKTatlas.ctab sub-01 rh white \n
#--------------------------------------------
#@# BA_exvivo Labels rh Thu May 22 00:08:27 CEST 2025
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/rh.BA1_exvivo.label --trgsubject sub-01 --trglabel ./rh.BA1_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/rh.BA2_exvivo.label --trgsubject sub-01 --trglabel ./rh.BA2_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/rh.BA3a_exvivo.label --trgsubject sub-01 --trglabel ./rh.BA3a_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/rh.BA3b_exvivo.label --trgsubject sub-01 --trglabel ./rh.BA3b_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/rh.BA4a_exvivo.label --trgsubject sub-01 --trglabel ./rh.BA4a_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/rh.BA4p_exvivo.label --trgsubject sub-01 --trglabel ./rh.BA4p_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/rh.BA6_exvivo.label --trgsubject sub-01 --trglabel ./rh.BA6_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/rh.BA44_exvivo.label --trgsubject sub-01 --trglabel ./rh.BA44_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/rh.BA45_exvivo.label --trgsubject sub-01 --trglabel ./rh.BA45_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/rh.V1_exvivo.label --trgsubject sub-01 --trglabel ./rh.V1_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/rh.V2_exvivo.label --trgsubject sub-01 --trglabel ./rh.V2_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/rh.MT_exvivo.label --trgsubject sub-01 --trglabel ./rh.MT_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/rh.entorhinal_exvivo.label --trgsubject sub-01 --trglabel ./rh.entorhinal_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/rh.perirhinal_exvivo.label --trgsubject sub-01 --trglabel ./rh.perirhinal_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/rh.FG1.mpm.vpnl.label --trgsubject sub-01 --trglabel ./rh.FG1.mpm.vpnl.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/rh.FG2.mpm.vpnl.label --trgsubject sub-01 --trglabel ./rh.FG2.mpm.vpnl.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/rh.FG3.mpm.vpnl.label --trgsubject sub-01 --trglabel ./rh.FG3.mpm.vpnl.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/rh.FG4.mpm.vpnl.label --trgsubject sub-01 --trglabel ./rh.FG4.mpm.vpnl.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/rh.hOc1.mpm.vpnl.label --trgsubject sub-01 --trglabel ./rh.hOc1.mpm.vpnl.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/rh.hOc2.mpm.vpnl.label --trgsubject sub-01 --trglabel ./rh.hOc2.mpm.vpnl.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/rh.hOc3v.mpm.vpnl.label --trgsubject sub-01 --trglabel ./rh.hOc3v.mpm.vpnl.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/rh.hOc4v.mpm.vpnl.label --trgsubject sub-01 --trglabel ./rh.hOc4v.mpm.vpnl.label --hemi rh --regmethod surface \n
\n mris_label2annot --s sub-01 --ctab /Applications/freesurfer/7.4.1/average/colortable_vpnl.txt --hemi rh --a mpm.vpnl --maxstatwinner --noverbose --l rh.FG1.mpm.vpnl.label --l rh.FG2.mpm.vpnl.label --l rh.FG3.mpm.vpnl.label --l rh.FG4.mpm.vpnl.label --l rh.hOc1.mpm.vpnl.label --l rh.hOc2.mpm.vpnl.label --l rh.hOc3v.mpm.vpnl.label --l rh.hOc4v.mpm.vpnl.label \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/rh.BA1_exvivo.thresh.label --trgsubject sub-01 --trglabel ./rh.BA1_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/rh.BA2_exvivo.thresh.label --trgsubject sub-01 --trglabel ./rh.BA2_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/rh.BA3a_exvivo.thresh.label --trgsubject sub-01 --trglabel ./rh.BA3a_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/rh.BA3b_exvivo.thresh.label --trgsubject sub-01 --trglabel ./rh.BA3b_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/rh.BA4a_exvivo.thresh.label --trgsubject sub-01 --trglabel ./rh.BA4a_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/rh.BA4p_exvivo.thresh.label --trgsubject sub-01 --trglabel ./rh.BA4p_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/rh.BA6_exvivo.thresh.label --trgsubject sub-01 --trglabel ./rh.BA6_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/rh.BA44_exvivo.thresh.label --trgsubject sub-01 --trglabel ./rh.BA44_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/rh.BA45_exvivo.thresh.label --trgsubject sub-01 --trglabel ./rh.BA45_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/rh.V1_exvivo.thresh.label --trgsubject sub-01 --trglabel ./rh.V1_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/rh.V2_exvivo.thresh.label --trgsubject sub-01 --trglabel ./rh.V2_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/rh.MT_exvivo.thresh.label --trgsubject sub-01 --trglabel ./rh.MT_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/rh.entorhinal_exvivo.thresh.label --trgsubject sub-01 --trglabel ./rh.entorhinal_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/martinnorgaard/Downloads/20M0157_MDD_COX1_COX2_BIDS/derivatives/freesurfer/fsaverage/label/rh.perirhinal_exvivo.thresh.label --trgsubject sub-01 --trglabel ./rh.perirhinal_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mris_label2annot --s sub-01 --hemi rh --ctab /Applications/freesurfer/7.4.1/average/colortable_BA.txt --l rh.BA1_exvivo.label --l rh.BA2_exvivo.label --l rh.BA3a_exvivo.label --l rh.BA3b_exvivo.label --l rh.BA4a_exvivo.label --l rh.BA4p_exvivo.label --l rh.BA6_exvivo.label --l rh.BA44_exvivo.label --l rh.BA45_exvivo.label --l rh.V1_exvivo.label --l rh.V2_exvivo.label --l rh.MT_exvivo.label --l rh.perirhinal_exvivo.label --l rh.entorhinal_exvivo.label --a BA_exvivo --maxstatwinner --noverbose \n
\n mris_label2annot --s sub-01 --hemi rh --ctab /Applications/freesurfer/7.4.1/average/colortable_BA.txt --l rh.BA1_exvivo.thresh.label --l rh.BA2_exvivo.thresh.label --l rh.BA3a_exvivo.thresh.label --l rh.BA3b_exvivo.thresh.label --l rh.BA4a_exvivo.thresh.label --l rh.BA4p_exvivo.thresh.label --l rh.BA6_exvivo.thresh.label --l rh.BA44_exvivo.thresh.label --l rh.BA45_exvivo.thresh.label --l rh.V1_exvivo.thresh.label --l rh.V2_exvivo.thresh.label --l rh.MT_exvivo.thresh.label --l rh.perirhinal_exvivo.thresh.label --l rh.entorhinal_exvivo.thresh.label --a BA_exvivo.thresh --maxstatwinner --noverbose \n
\n mris_anatomical_stats -th3 -mgz -noglobal -f ../stats/rh.BA_exvivo.stats -b -a ./rh.BA_exvivo.annot -c ./BA_exvivo.ctab sub-01 rh white \n
\n mris_anatomical_stats -th3 -mgz -f ../stats/rh.BA_exvivo.thresh.stats -noglobal -b -a ./rh.BA_exvivo.thresh.annot -c ./BA_exvivo.thresh.ctab sub-01 rh white \n
