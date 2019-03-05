#!/bin/bash

MY_PATH="`dirname \"$0\"`"
MY_FULL_PATH=`readlink -f ${MY_PATH}`
VERSION=${3}

m=0
while read LINE; do 
m=`expr $m + 1`
k=`expr $m % 2`
SUBJ=`echo "$LINE" | cut -f1 -d","`
SESS=`echo "$LINE" | cut -f2 -d","`
OUTPUT=${2}

echo ${SUBJ} ${SESS} ${MY_FULL_PATH}

  if [ -z "$SGE_ROOT" ]; then
     ${MY_FULL_PATH}/bids_hcppipeline.sh ${SUBJ} ${SESS} ${MY_FULL_PATH} ${OUTPUT} $LINE </dev/null
  else
     if [ ${VERSION} == "regular" ];
     then  
	 echo "${MY_FULL_PATH}/bids_hcppipeline.sh ${SUBJ} ${SESS} ${MY_FULL_PATH} ${OUTPUT}" | qsub -q long.q@adrian -o /nethome/amiklos/QSUB_OUTPUT/o_${SESS}.txt -e /nethome/amiklos/QSUB_OUTPUT/e_${SESS}.txt 
	 elif [ ${VERSION} == "alternate" ];
	 then
		if [ $k -eq 0 ];
		then
			echo "${MY_FULL_PATH}/alt_bids_hcppipeline.sh ${SUBJ} ${SESS} ${MY_FULL_PATH} ${OUTPUT}" | qsub -q long.q@adrian -o /nethome/amiklos/QSUB_OUTPUT/o_${SESS}.txt -e /nethome/amiklos/QSUB_OUTPUT/e_${SESS}.txt 
		else
			echo "${MY_FULL_PATH}/alt_bids_hcppipeline.sh ${SUBJ} ${SESS} ${MY_FULL_PATH} ${OUTPUT}" | qsub -q long.q@moon -o /nethome/amiklos/QSUB_OUTPUT/o_${SESS}.txt -e /nethome/amiklos/QSUB_OUTPUT/e_${SESS}.txt 
		fi	
	 fi
  fi

done < ${1}

