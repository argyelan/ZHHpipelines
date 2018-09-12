#!/bin/bash


BIDS=/analysis/BIDS
MY_PATH="`dirname \"$0\"`"
MY_FULL_PATH=`readlink -f ${MY_PATH}`

if [ ${3} == "TMS" ]; then

  docker run -it --rm -v ${BIDS}/:/output -v /data/rTMS:/input/${1}:ro -v ${MY_FULL_PATH}:/heuristic:ro nipy/heudiconv -d /input/{subject}/{session}/dicom/*/* -s ${1} --ses ${2} -o /output -f /heuristic/configfiles/heuristicTMSv6.py  -b
  
  docker run -it --rm -v ${MY_FULL_PATH}:/data -v ${BIDS}:/output --entrypoint=Rscript library/r-base /data/config_files/overwrite_events.R --vanilla ${1} ${2} #/data and /output should be left since it is in the overwrite_events.R 
fi
