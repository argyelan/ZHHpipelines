# Use Ubuntu 14.04 LTS
FROM ubuntu:trusty-20170119

## Install the validator
RUN apt-get update && \
    apt-get install -y curl && \
    curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
    apt-get remove -y curl && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN npm install -g bids-validator@0.19.2

# Download FreeSurfer
RUN apt-get -y update \
    && apt-get install -y wget && \
    wget -qO- ftp://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/5.3.0-HCP/freesurfer-Linux-centos4_x86_64-stable-pub-v5.3.0-HCP.tar.gz | tar zxv -C /opt \
    --exclude='freesurfer/trctrain' \
    --exclude='freesurfer/subjects/fsaverage_sym' \
    --exclude='freesurfer/subjects/fsaverage3' \
    --exclude='freesurfer/subjects/fsaverage4' \
    --exclude='freesurfer/subjects/fsaverage5' \
    --exclude='freesurfer/subjects/fsaverage6' \
    --exclude='freesurfer/subjects/cvs_avg35' \
    --exclude='freesurfer/subjects/cvs_avg35_inMNI152' \
    --exclude='freesurfer/subjects/bert' \
    --exclude='freesurfer/subjects/V1_average' \
    --exclude='freesurfer/average/mult-comp-cor' \
    --exclude='freesurfer/lib/cuda' \
    --exclude='freesurfer/lib/qt' && \
    apt-get install -y tcsh bc tar libgomp1 perl-modules curl  && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set up the environment
ENV OS Linux
ENV FS_OVERRIDE 0
ENV FIX_VERTEX_AREA=
ENV SUBJECTS_DIR /opt/freesurfer/subjects
ENV FSF_OUTPUT_FORMAT nii.gz
ENV MNI_DIR /opt/freesurfer/mni
ENV LOCAL_DIR /opt/freesurfer/local
ENV FREESURFER_HOME /opt/freesurfer
ENV FSFAST_HOME /opt/freesurfer/fsfast
ENV MINC_BIN_DIR /opt/freesurfer/mni/bin
ENV MINC_LIB_DIR /opt/freesurfer/mni/lib
ENV MNI_DATAPATH /opt/freesurfer/mni/data
ENV FMRI_ANALYSIS_DIR /opt/freesurfer/fsfast
ENV PERL5LIB /opt/freesurfer/mni/lib/perl5/5.8.5
ENV MNI_PERL5LIB /opt/freesurfer/mni/lib/perl5/5.8.5
ENV PATH /opt/freesurfer/bin:/opt/freesurfer/fsfast/bin:/opt/freesurfer/tktools:/opt/freesurfer/mni/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH

# Install FSL 5.0.9
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl && \
    curl -sSL http://neuro.debian.net/lists/trusty.us-ca.full >> /etc/apt/sources.list.d/neurodebian.sources.list && \
    apt-key adv --recv-keys --keyserver hkp://pgp.mit.edu:80 0xA5D32F012649A5A9 && \
    apt-get update && \
    apt-get install -y fsl-core=5.0.9-4~nd14.04+1 && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Configure environment
ENV FSLDIR=/usr/share/fsl/5.0
ENV FSL_DIR="${FSLDIR}"
ENV FSLOUTPUTTYPE=NIFTI_GZ
ENV PATH=/usr/lib/fsl/5.0:$PATH
ENV FSLMULTIFILEQUIT=TRUE
ENV POSSUMDIR=/usr/share/fsl/5.0
ENV LD_LIBRARY_PATH=/usr/lib/fsl/5.0:$LD_LIBRARY_PATH
ENV FSLTCLSH=/usr/bin/tclsh
ENV FSLWISH=/usr/bin/wish
ENV FSLOUTPUTTYPE=NIFTI_GZ
RUN echo "cHJpbnRmICJrcnp5c3p0b2YuZ29yZ29sZXdza2lAZ21haWwuY29tXG41MTcyXG4gKkN2dW12RVYzelRmZ1xuRlM1Si8yYzFhZ2c0RVxuIiA+IC9vcHQvZnJlZXN1cmZlci9saWNlbnNlLnR4dAo=" | base64 -d | sh

# Install Connectome Workbench
RUN apt-get update && apt-get -y install connectome-workbench=1.2.3-1~nd14.04+1

ENV CARET7DIR=/usr/bin

# Install HCP Pipelines
RUN apt-get -y update \
    && apt-get install -y --no-install-recommends python-numpy && \
    wget https://github.com/Washington-University/Pipelines/archive/v3.17.0.tar.gz -O pipelines.tar.gz && \
    cd /opt/ && \
    tar zxvf /pipelines.tar.gz && \
    mv /opt/Pipelines-* /opt/HCP-Pipelines && \
    rm /pipelines.tar.gz && \
    cd / && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV HCPPIPEDIR=/opt/HCP-Pipelines
ENV HCPPIPEDIR_Templates=${HCPPIPEDIR}/global/templates
ENV HCPPIPEDIR_Bin=${HCPPIPEDIR}/global/binaries
ENV HCPPIPEDIR_Config=${HCPPIPEDIR}/global/config
ENV HCPPIPEDIR_PreFS=${HCPPIPEDIR}/PreFreeSurfer/scripts
ENV HCPPIPEDIR_FS=${HCPPIPEDIR}/FreeSurfer/scripts
ENV HCPPIPEDIR_PostFS=${HCPPIPEDIR}/PostFreeSurfer/scripts
ENV HCPPIPEDIR_fMRISurf=${HCPPIPEDIR}/fMRISurface/scripts
ENV HCPPIPEDIR_fMRIVol=${HCPPIPEDIR}/fMRIVolume/scripts
ENV HCPPIPEDIR_tfMRI=${HCPPIPEDIR}/tfMRI/scripts
ENV HCPPIPEDIR_dMRI=${HCPPIPEDIR}/DiffusionPreprocessing/scripts
ENV HCPPIPEDIR_dMRITract=${HCPPIPEDIR}/DiffusionTractography/scripts
ENV HCPPIPEDIR_Global=${HCPPIPEDIR}/global/scripts
ENV HCPPIPEDIR_tfMRIAnalysis=${HCPPIPEDIR}/TaskfMRIAnalysis/scripts
ENV MSMBin=${HCPPIPEDIR}/MSMBinaries

RUN apt-get update && apt-get install -y --no-install-recommends python-pip python-six python-nibabel python-setuptools && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN pip install pybids==0.0.1
ENV PYTHONPATH=""

COPY run.py /run.py
RUN chmod +x /run.py

COPY coeff.grad /coeff.grad
RUN chmod +r /coeff.grad

#this needed for grad_unwarp and nibabel
RUN apt-get update && apt-get install -y --no-install-recommends gcc python-dev && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install grad_unwarp.py
RUN wget https://github.com/Washington-University/gradunwarp/archive/v1.0.3.tar.gz -O gradunwarp.tar.gz && \
    cd /opt/ && \
    tar zxvf /gradunwarp.tar.gz && \
    mv /opt/gradunwarp-* /opt/HCP-gradunwarp && \
    rm /gradunwarp.tar.gz && \
    cd /opt/HCP-gradunwarp && \
    python setup.py install && \
    cd /

# Install nibabel
RUN wget https://github.com/downloads/ksubramz/gradunwarp/nibabel-1.2.0.dev.tar.gz -O nibabel.tar.gz && \
    cd /opt/ && \
    tar zxvf /nibabel.tar.gz && \
    mv /opt/nibabel-* /opt/HCP-nibabel && \
    rm /nibabel.tar.gz && \
    cd /opt/HCP-nibabel && \
    python setup.py install && \
    cd /

##Install fix

  ##Install R Requires: R (and maybe R-devel), with the following commands run (ideally as root) to install packages:
RUN apt-get update && apt-get -y install r-base r-base-dev mc nano
  
RUN Rscript -e 'install.packages("kernlab", dependencies=TRUE,repos="http://cran.us.r-project.org")'
RUN Rscript -e 'install.packages("ROCR", dependencies=TRUE,repos="http://cran.us.r-project.org")'
RUN Rscript -e 'install.packages("class", dependencies=TRUE,repos="http://cran.us.r-project.org")'
RUN Rscript -e 'install.packages("party", dependencies=TRUE,repos="http://cran.us.r-project.org")'
RUN Rscript -e 'install.packages("e1071", dependencies=TRUE,repos="http://cran.us.r-project.org")'
RUN Rscript -e 'install.packages("randomForest", dependencies=TRUE,repos="http://cran.us.r-project.org")'

  ##download and install fix and isntall octave just in case
RUN wget http://www.fmrib.ox.ac.uk/~steve/ftp/fix.tar.gz -O fix.tar.gz && \
	cd /opt/ && \
	tar zxvf /fix.tar.gz && \
    mv /opt/fix* /opt/fix && \
    rm /fix.tar.gz && \
    cd /opt/fix && \
    apt-get -y install octave && \
    /bin/bash ./setup_octave.sh && \
    cd /
##environmnetal variables mode=0 means MATLAB compiled version , mode=2 would mean Octave   
ENV FSL_FIX_MATLAB_MODE=0
ENV FSL_FIXDIR=/opt/fix

#this is to install ocatave packages, setup_octave did not work in line 160
#RUN apt-get update && apt-get install -y liboctave-dev
#RUN octave --eval 'pkg install -auto -forge io; pkg install -auto -forge statistics; pkg install -auto -forge specfun; pkg install -auto -forge general; pkg install -auto -forge control; pkg install -auto -forge signal;' 
#different dependencies...

#try MALTAB already compiled
RUN cd $FSL_FIXDIR/compiled/Linux/x86_64 && \
	cp MCRInstaller.zip /tmp && \
	 cd /tmp && \
	 unzip MCRInstaller.zip && \ 
	 ./install -mode silent -agreeToLicense yes
	
COPY settings.sh /opt/fix/settings.sh
RUN chmod +x /opt/fix/settings.sh

#older version of party is required (I do it this way, becasue otherwise I would need all the dependencies of party which was already installed above)
RUN wget https://cran.r-project.org/src/contrib/Archive/party/party_1.0-25.tar.gz && \
	R CMD INSTALL party_1.0-25.tar.gz && \
	rm party_1.0-25.tar.gz
	
RUN ln -s $FSLDIR /usr/local/fsl
RUN mkdir -p /vols/Data/HCP && \
	cd /vols/Data/HCP && \
	wget https://ftp.humanconnectome.org/workbench/workbench-linux64-v1.2.3.zip && \
	unzip workbench-linux64-v1.2.3.zip && \
	cd /
	
RUN mv /opt/fix/hcp_fix /opt/fix/hcp_fix.old
COPY hcp_fix /opt/fix/hcp_fix
RUN chmod +x /opt/fix/hcp_fix	

COPY version /version
ENTRYPOINT ["/run.py"]
