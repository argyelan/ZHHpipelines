#!/bin/bash
#using nipy/heudiconv which was pulled as latest on 2018-SEP-11

BIDS=/analysis/BIDS
MY_PATH="`dirname \"$0\"`"
MY_FULL_PATH=`readlink -f ${MY_PATH}`

if [ ${3} == "TMS" ]; then

  rawloc=`echo $(dirname $(findsession $2))|grep TMS`

  docker run -it --rm -v ${BIDS}/:/output -v ${rawloc}:/input/${1}:ro -v ${MY_FULL_PATH}:/heuristic:ro nipy/heudiconv -d /input/{subject}/{session}/dicom/*/* -s ${1} --ses ${2} -o /output -f /heuristic/configfiles/heuristicTMSv6.py  -b
  
  docker run -it --rm -v ${MY_FULL_PATH}:/data -v ${BIDS}:/output --entrypoint=Rscript library/r-base --vanilla /data/configfiles/overwrite_events.R ${1} ${2} #/data and /output should be left since it is in the overwrite_events.R 
fi


if [ ${3} == "clozapineECT" ]; then

  rawloc=`echo $(dirname $(findsession $2))|grep Clozapine`
  docker run -it --rm -v ${BIDS}/:/output -v ${rawloc}:/input/${1}:ro -v ${MY_FULL_PATH}:/heuristic:ro nipy/heudiconv -d /input/{subject}/{session}/dicom/*/* -s ${1} --ses ${2} -o /output -f /heuristic/configfiles/heuristicTMSv6.py  -b
  
fi
