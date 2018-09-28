#!/bin/bash

MY_PATH="`dirname \"$0\"`"
MY_FULL_PATH=`readlink -f ${MY_PATH}`


while read LINE; do 

SUBJ=`echo "$LINE" | cut -f1 -d","`
SESS=`echo "$LINE" | cut -f2 -d","`
TYPE=`echo "$LINE" | cut -f3 -d","`

echo ${SUBJ} ${SESS} ${TYPE}

  if [ -z "$SGE_ROOT" ]; then
     ${MY_FULL_PATH}/dicom2bids.sh ${SUBJ} ${SESS} ${TYPE} $LINE </dev/null
  else
	 echo "${MY_FULL_PATH}/dicom2bids.sh ${SUBJ} ${SESS} ${TYPE}" | qsub -q long.q
  fi

done < ${1}
