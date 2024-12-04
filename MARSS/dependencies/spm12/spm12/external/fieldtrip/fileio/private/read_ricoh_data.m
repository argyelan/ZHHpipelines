function [dat] = read_ricoh_data(filename, hdr, begsample, endsample, chanindx)

%function [dat] = read_ricoh_data(filename, hdr, begsample, endsample, chanindx)
%
%% READ_RICOH_DATA reads continuous or averaged MEG data
%% generated by the RICOH MEG system and software,
%% and allows the data to be used in FieldTrip.
%%
%% Use as
%%   [dat] = read_ricoh_data(filename, hdr, begsample, endsample, chanindx)
%%
%% This is a wrapper function around the function getRData
%%
%% See also READ_RICOH_HEADER, READ_RICOH_EVENT

if ~ft_hastoolbox('ricoh_meg_reader')
    ft_error('cannot determine whether Ricoh toolbox is present');
end

hdr = hdr.orig; % use the original Ricoh header, not the FieldTrip header

% default is to select all channels
if nargin<5
  chanindx = 1:hdr.channel_count;
end

handles = definehandles;

switch hdr.acq_type
  case handles.AcqTypeEvokedAve
    % dat is returned as double
    start_sample  = begsample - 1; % samples start at 0
    sample_length = endsample - begsample + 1;
    epoch_count   = 1;
    start_epoch   = 0;
    dat = getRData(filename, start_sample, sample_length);

  case handles.AcqTypeContinuousRaw
    % dat is returned as double
    start_sample  = begsample - 1; % samples start at 0
    sample_length = endsample - begsample + 1;
    epoch_count   = 1;
    start_epoch   = 0;
    dat = getRData(filename, start_sample, sample_length);

  % Unlike Yokogawa system, "AcqTypeEvokedRaw" is not supported for Ricoh system.

  otherwise
    ft_error('unknown data type');
end


if size(dat,1)~=hdr.channel_count
  ft_error('could not read all channels');
elseif size(dat,2)~=(endsample-begsample+1)
  ft_error('could not read all samples');
end

% select only the desired channels
dat = dat(chanindx,:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% this defines some usefull constants
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function handles = definehandles
handles.output = [];
handles.sqd_load_flag = false;
handles.mri_load_flag = false;
handles.NullChannel         = 0;
handles.MagnetoMeter        = 1;
handles.AxialGradioMeter    = 2;
handles.PlannerGradioMeter  = 3;
handles.RefferenceChannelMark = hex2dec('0100');
handles.RefferenceMagnetoMeter       = bitor( handles.RefferenceChannelMark, handles.MagnetoMeter );
handles.RefferenceAxialGradioMeter   = bitor( handles.RefferenceChannelMark, handles.AxialGradioMeter );
handles.RefferencePlannerGradioMeter = bitor( handles.RefferenceChannelMark, handles.PlannerGradioMeter );
handles.TriggerChannel      = -1;
handles.EegChannel          = -2;
handles.EcgChannel          = -3;
handles.EtcChannel          = -4;
handles.NonMegChannelNameLength = 32;
handles.DefaultMagnetometerSize       = (4.0/1000.0);       % Square of 4.0mm in length
handles.DefaultAxialGradioMeterSize   = (15.5/1000.0);      % Circle of 15.5mm in diameter
handles.DefaultPlannerGradioMeterSize = (12.0/1000.0);      % Square of 12.0mm in length
handles.AcqTypeContinuousRaw = 1;
handles.AcqTypeEvokedAve     = 2;
handles.AcqTypeEvokedRaw     = 3;
handles.sqd = [];
handles.sqd.selected_start  = [];
handles.sqd.selected_end    = [];
handles.sqd.axialgradiometer_ch_no      = [];
handles.sqd.axialgradiometer_ch_info    = [];
handles.sqd.axialgradiometer_data       = [];
handles.sqd.plannergradiometer_ch_no    = [];
handles.sqd.plannergradiometer_ch_info  = [];
handles.sqd.plannergradiometer_data     = [];
handles.sqd.eegchannel_ch_no   = [];
handles.sqd.eegchannel_data    = [];
handles.sqd.nullchannel_ch_no   = [];
handles.sqd.nullchannel_data    = [];
handles.sqd.selected_time       = [];
handles.sqd.sample_rate         = [];
handles.sqd.sample_count        = [];
handles.sqd.pretrigger_length   = [];
handles.sqd.matching_info   = [];
handles.sqd.source_info     = [];
handles.sqd.mri_info        = [];
handles.mri                 = [];
