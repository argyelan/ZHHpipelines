#!/bin/bash

# one argument: subject id

docker run -i --rm -v /analysis/BIDS:/data:ro -v /analysis/BIDS_QUALITY/:/out -v /analysis/.BIDS_QUALITYwork/:/work poldracklab/mriqc --participant_label ${1} -w /work --ica --verbose-reports --no-sub /data /out participant
