function [ pixelPrecision, pixelAccuracy, pixelSpecificity, pixelSensitivity, pixelTP, pixelFP, pixelFN,pixelTN, time_per_frame ] = evaluateResults(paths_for_validation, computed_mask) 
%Calculate precison and accuracy of the segmentation algorithm


    % windowTP=0; windowFN=0; windowFP=0; % (Needed after Week 3)
    pixelTP=0; pixelFN=0; pixelFP=0; pixelTN=0;
    start=tic
    for i=1:size(paths_for_validation,1),

%       i
        
        % Read result mask
        pixelCandidates = imread(computed_mask(i,:));
        % Read expected mask
        pixelAnnotation = imread(paths_for_validation(i,:));
        
        % Accumulate pixel performance of the current image %%%%%%%%%%%%%%%%%
        [localPixelTP, localPixelFP, localPixelFN, localPixelTN] = PerformanceAccumulationPixel(pixelCandidates, pixelAnnotation);
        pixelTP = pixelTP + localPixelTP;
        pixelFP = pixelFP + localPixelFP;
        pixelFN = pixelFN + localPixelFN;
        pixelTN = pixelTN + localPixelTN;
        
    end
    time_per_frame = toc/size(paths_for_validation,1);
    % Plot performance evaluation
    [pixelPrecision, pixelAccuracy, pixelSpecificity, pixelSensitivity] = PerformanceEvaluationPixel(pixelTP, pixelFP, pixelFN, pixelTN);
    % [windowPrecision, windowAccuracy] = PerformanceEvaluationWindow(windowTP, windowFN, windowFP); % (Needed after Week 3)
    
    [pixelPrecision, pixelAccuracy, pixelSpecificity, pixelSensitivity, time_per_frame]
    

end

