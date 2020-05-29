FROM freesurfer/freesurfer:6.0
COPY license.txt /opt/freesurfer/license.txt
COPY unifiedScript_2tp.sh /opt/freesurfer/bin/unifiedScript_2tp.sh
RUN chmod 755 /opt/freesurfer/bin/unifiedScript_2tp.sh
ENV SUBJECTS_DIR=/fs_subjects
RUN mkdir $SUBJECTS_DIR
CMD ["/opt/freesurfer/bin/recon-all"]
