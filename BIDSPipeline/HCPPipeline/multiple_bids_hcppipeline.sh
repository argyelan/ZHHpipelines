#!/bin/bash

MY_PATH="`dirname \"$0\"`"
MY_FULL_PATH=`readlink -f ${MY_PATH}`


while read LINE; do 

SUBJ=`echo "$LINE" | cut -f1 -d","`
SESS=`echo "$LINE" | cut -f2 -d","`
OUTPUT=${2}

echo ${SUBJ} ${SESS} ${MY_FULL_PATH}

  if [ -z "$SGE_ROOT" ]; then
     ${MY_FULL_PATH}/bids_hcppipeline.sh ${SUBJ} ${SESS} ${MY_FULL_PATH} ${OUTPUT} $LINE </dev/null
  else
	 echo "${MY_FULL_PATH}/bids_hcppipeline.sh ${SUBJ} ${SESS} ${MY_FULL_PATH} ${OUTPUT}" | qsub -q long.q
  fi

done < ${1}

