function cycleFunctionThroughFiles(folderinfile, MB, outputfolder)


    try
        

        % Get a list of .nii files in the folder
        niiFiles = dir([folderinfile, '/*.nii']);

        % Iterate through each .nii file
        for k = 1:length(niiFiles)
            % Full path to the current file
            niiFilePath = fullfile(niiFiles(k).folder, niiFiles(k).name);

            % Call the function on the current file with optional arguments
            MARSS(niiFilePath, MB, outputfolder);
        end
    catch ME
        % Display an error message if something goes wrong
        disp(['Error occurred: ', ME.message]);
    end


end



folderPath = '/analysis/Argyelan/MARSS';
folderinfile = '/analysis/Argyelan/new_pipeline/MARSS_preprocess/files_v1';
% Save the current folder
currentFolder = pwd;
% Change to the specified folder
cd(folderPath);

cycleFunctionThroughFiles(folderinfile, 8, '/analysis/Argyelan/new_pipeline/MARSS_preprocess/folder_out'); 

% Return to the original folder
cd(currentFolder);

%MARSS('/analysis/Argyelan/temp/sub-12381_ses-23001_task-rest_acq-PA_run-01_bold.nii',8,'/analysis/Argyelan/temp')
