import os

def create_key(template, outtype=('nii.gz',), annotation_classes=None):
   if template is None or not template:
       raise ValueError('Template must be a valid format string')
   return template, outtype, annotation_classes

def infotodict(seqinfo):
   t1w = create_key('sub-{subject}/{session}/anat/sub-{subject}_{session}_T1w')
   t2w = create_key('sub-{subject}/{session}/anat/sub-{subject}_{session}_T2w')
   dwi = create_key('sub-{subject}/{session}/dwi/sub-{subject}_{session}_run-{item:01d}_dwi')
   dwi_sbref = create_key('sub-{subject}/{session}/dwi/sub-{subject}_{session}_run-{item:02d}_sbref')
   fmap = create_key('sub-{subject}/{session}/fmap/sub-{subject}_{session}_dir-{dir}_run-{item:02d}_epi')
   rest_AP = create_key('sub-{subject}/{session}/func/sub-{subject}_{session}_task-rest_acq-AP_run-{item:02d}_bold')
   rest_sbref_AP = create_key('sub-{subject}/{session}/func/sub-{subject}_{session}_task-rest_acq-AP_run-{item:02d}_sbref')
   rest_PA = create_key('sub-{subject}/{session}/func/sub-{subject}_{session}_task-rest_acq-PA_run-{item:02d}_bold')
   rest_sbref_PA = create_key('sub-{subject}/{session}/func/sub-{subject}_{session}_task-rest_acq-PA_run-{item:02d}_sbref')
   nback = create_key('sub-{subject}/{session}/func/sub-{subject}_{session}_task-nback_run-{item:02d}_bold')
   nback_sbref = create_key('sub-{subject}/{session}/func/sub-{subject}_{session}_task-nback_run-{item:02d}_sbref')
   asl = create_key('sub-{subject}/{session}/func/sub-{subject}_{session}_task-none_run-{item:02d}_asl')
   # NO UNDERSCORE IN KEY NAMES!!!
   #rest = create_key('func/sub-{subject}_task-rest_rec-{rec}_run-{item:01d}_bold')
#   info = {t1w: [], dwi: [], rest: []}
   info = {t1w: [], t2w: [], dwi: [], dwi_sbref: [], fmap:[], rest_AP: [], rest_sbref_AP: [], rest_PA: [], rest_sbref_PA: [], nback: [], nback_sbref: [], asl: []}
   #info = {t1w: [], t2w: [], dwi: [], dwi_sbref: [], fmap:[], rest: [], rest_sbref: [], nback: [], nback_sbref: [], asl: []}
   for s in seqinfo:
       if ('T1w_MPR' in s.protocol_name):
         info[t1w] = [s.series_id] # assign if a single series meets criteria
       if ('T2w_SPC' in s.protocol_name):
         info[t2w] = [s.series_id] # assign if a single series meets criteria
       if (s.dim4 > 10) and ('dMRI' in s.protocol_name):
         info[dwi].append(s.series_id) # append if multiple series meet criteria
       if (s.dim4 == 1) and ('SBRef' in s.series_description) and ('dMRI' in s.protocol_name):
         info[dwi_sbref].append({'item': s.series_id})
       if (s.dim4 == 3) and ('SpinEchoFieldMap' in s.protocol_name):
         dirtype = s.protocol_name.split('_')[-1]
         info[fmap].append({'item': s.series_id, 'dir': dirtype})
       if ('Resting_' in s.protocol_name):
         tasktype = s.protocol_name.split('Resting_')[1].split('_')[0]
         key = None
         if (s.dim4 in [594]):
           if 'AP' in tasktype: key = rest_AP
           if 'PA' in tasktype: key = rest_PA
         if (s.dim4 == 1) and ('SBRef' in s.series_description):
           if 'AP' in tasktype: key = rest_sbref_AP
           if 'PA' in tasktype: key = rest_sbref_PA
         if key:
           info[key].append({'item': s.series_id})
       if ('N-BACK' in s.protocol_name):
         key = None
         if (s.dim4 in [487]):
           key = nback
         if (s.dim4 == 1) and ('SBRef' in s.series_description):
           key = nback_sbref
         if key:
           info[key].append({'item': s.series_id})
       if (s.dim4 == 8) and ('ASL_3D_HighRes' in s.series_description):
           info[asl].append(s.series_id)

#       if (s.dim4 > 10) and ('taskrest' in s.protocol_name):
#           if s.is_motion_corrected: # exclude non motion corrected series
#               info[rest].append({'item': s.series_number, 'rec': 'corrected'})
#           else:
#               info[rest].append({'item': s.series_number, 'rec': 'uncorrected'})
   return info
