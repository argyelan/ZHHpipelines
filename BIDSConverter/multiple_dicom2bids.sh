#!/bin/bash

MY_PATH="`dirname \"$0\"`"
MY_FULL_PATH=`readlink -f ${MY_PATH}`


while read LINE; do 

SUBJ=`echo "$LINE" | cut -f1 -d","`
SESS=`echo "$LINE" | cut -f2 -d","`

echo ${SUBJ} ${SESS} 

  if [ -z "$SGE_ROOT" ]; then
     ${MY_FULL_PATH}/dicom2bids.sh ${SUBJ} ${SESS} $LINE </dev/null
  else
	 echo "${MY_FULL_PATH}/dicom2bids.sh ${SUBJ} ${SESS}" | qsub -q long.q@crick
  fi

done < ${1}
