#!/bin/bash

MY_PATH="`dirname \"$0\"`"
MY_FULL_PATH=`readlink -f ${MY_PATH}`


while read LINE; do 

SUBJ=`echo "$LINE" | cut -f1 -d","`
SESS=`echo "$LINE" | cut -f2 -d","`
TYPE=`echo "$LINE" | cut -f3 -d","`

echo ${SUBJ} ${SESS} ${TYPE} 
${MY_FULL_PATH}/dicom2bids.sh ${SUBJ} ${SESS} ${TYPE}

done < $1
