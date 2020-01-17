#!/bin/bash

#this is for 2 timepoints, see separate wrapper for 3 timepoints
#arg1 freesurefer dir for tp 1
#arg2 freesurefer dir for tp 2
#arg3 output directory


FS1=$1
FS2=$2
OP=$3
SBJID=$4

mkdir -p ${OP}
#echo "docker run -i --rm -v /analysis/HCP/BIDS/ses-23532/sub-12921/T1w/sub-12921/:/fs_subjects/tp1:ro  -v /analysis/HCP/BIDS/ses-23563/sub-12921/T1w/sub-12921/:/fs_subjects/tp2:ro  -v /nethome/amiklos/work/ECT/IPER/LONG_FREESURFER/sub-12921:/fs_subjects --entrypoint=/opt/freesurfer/bin/recon-all amiklos/freesurfer:6.0  -base base-12921 -tp tp1  -tp tp2 -all" | qsub -q long.q@adrian -o /nethome/amiklos/QSUB_OUTPUT/o_SUB12921.txt -e /nethome/amiklos/QSUB_OUTPUT/e_SUB12921.txt 
#echo "docker run -i --rm -v ${FS1}:/fs_subjects/tp1:ro  -v ${FS2}:/fs_subjects/tp2:ro  -v ${OP}:/fs_subjects --entrypoint=/opt/freesurfer/bin/unifiedScript_2tp.sh amiklos/long-freesurfer:6.0  ${SBJID} " | qsub -q long.q@adrian -o /nethome/amiklos/QSUB_OUTPUT/o_SUB-${SBJID}.txt -e /nethome/amiklos/QSUB_OUTPUT/e_SUB-${SBJID}.txt 
echo "docker run -i --rm -v ${FS1}:/fs_subjects/tp1:ro  -v ${FS2}:/fs_subjects/tp2:ro  -v ${OP}:/fs_subjects --entrypoint=/opt/freesurfer/bin/unifiedScript_2tp.sh amiklos/long-freesurfer:6.0  ${SBJID} " | qsub -q all.q@adrian -o /nethome/amiklos/QSUB_OUTPUT/o_SUB-${SBJID}.txt -e /nethome/amiklos/QSUB_OUTPUT/e_SUB-${SBJID}.txt 

#test
#/nethome/amiklos/argyelan@gmail.com/howto/GitHub/ZHHpipelines/PostProcessing/LongitudinalFreesurfer/running_lfs.sh /analysis/HCP/BIDS/ses-23532/sub-12921/T1w/sub-12921/ /analysis/HCP/BIDS/ses-23563/sub-12921/T1w/sub-12921/ /nethome/amiklos/test/lftest/sub-12921 12921
