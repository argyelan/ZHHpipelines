#!/bin/bash
SBJID=$1

/opt/freesurfer/bin/recon-all -base base-${SBJID} -tp tp1  -tp tp2 -all
/opt/freesurfer/bin/recon-all -long tp1 base-${SBJID} -all
/opt/freesurfer/bin/recon-all -long tp2 base-${SBJID} -all
