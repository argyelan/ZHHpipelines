#!/bin/bash

MY_PATH="`dirname \"$0\"`"
MY_FULL_PATH=`readlink -f ${MY_PATH}`
OUTPUT=${2}

while read LINE; do 

SUBJ=`echo "$LINE" | cut -f1 -d","`
SESS=`echo "$LINE" | cut -f2 -d","`


echo ${SUBJ} ${SESS} 

  if [ -z "$SGE_ROOT" ]; then
     ${MY_FULL_PATH}/temp.dicom2bids.sh ${SUBJ} ${SESS} ${OUTPUT} $LINE </dev/null
  else
	 echo "${MY_FULL_PATH}/temp.dicom2bids.sh ${SUBJ} ${SESS} ${OUTPUT}" | qsub -q all.q@adrian -o /nethome/amiklos/QSUB_OUTPUT/o_${SESS}.txt -e /nethome/amiklos/QSUB_OUTPUT/e_${SESS}.txt 
  fi

done < ${1}
