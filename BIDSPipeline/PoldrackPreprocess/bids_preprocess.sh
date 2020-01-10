

docker run -ti --rm -v /analysis/BIDS/:/data:ro -v /analysis/BIDS_PREPROC/POLDRACK:/out -v $FREESURFER_HOME/license.txt:/opt/freesurfer/license.txt:ro poldracklab/fmriprep:latest --participant-label 12658 /data /out participant
