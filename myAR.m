function myAR()
% Main file to run
    addpath(genpath('src'));
    addpath(genpath('images'));
    [v, f, col] = getHumanoidCoordinates();
    referenceImage = imread('texture.bmp');
    referenceImageGray = rgb2gray(referenceImage);
    referencePts = detectSURFFeatures(referenceImageGray);
    referenceFeatures = extractFeatures(referenceImageGray, referencePts);
    
    %% display surf features
%     figure;
%     imshow(referenceImage); hold on;
%     plot(referencePts.selectStrongest(50));
    
    %% Video output
%     video = vision.VideoFileReader('JnK.wmv', ...
%                                     'VideoOutputDataType', 'uint8');
%     
%     for k = 1:50
%         step(video);
%     end;
    
    
    %% input
    inputframe = imread('test2.jpg');

    inputframeGray = rgb2gray(inputframe);
%     figure(2);
%     imshow(inputframe);

    inputPts = detectSURFFeatures(inputframeGray);
    
%     figure(1);
%     imshow(inputframe); hold on;
%     plot(inputPts.selectStrongest(50));
    
    inputFeatures = extractFeatures(inputframeGray, inputPts);
    
    idxPairs = matchFeatures(inputFeatures, referenceFeatures);
    matchedInputPts = inputPts(idxPairs(:, 1));
    matchedReferencePts = referencePts(idxPairs(:, 2));
    
%     figure(1);
%     showMatchedFeatures(inputframe, referenceImage, ...
%                         matchedInputPts, matchedReferencePts, 'Montage');
                    
    %% Geometric transformation
    [referenceTransform, inlierReferencePts, inlierCameraPts] ...
        = estimateGeometricTransform(...
                matchedReferencePts, matchedInputPts, 'Similarity');
    
%      figure(1);
%      showMatchedFeatures(inputframe, referenceImage, ...
%                         inlierCameraPts, inlierReferencePts, 'Montage');
    
                    
      [outputFrame, map, alpha] = imread('Pranay.png');
      %{
      repDims = size(outputFrame(:, :, 1));
      disp(repDims);
      refDims = size(referenceImage);
      disp(refDims);
      scaleTransform = findScaleTransform(refDims, repDims);
      
      outputView = imref2d(size(referenceImage));
      
      videoFrameScaled = imwarp(outputFrame, scaleTransform, ...
                                'OutputView', outputView);
      
      figure(1);
      imshowpair(referenceImage, videoFrameScaled, 'Montage');
      
      %}
      disp(referenceTransform)
      outputView = imref2d(size(inputframe));
      videoFrameTransformed = imwarp(outputFrame, referenceTransform, ...
                                    'OutputView', outputView);
                                
      figure(1);
%       imshowpair(inputframe, videoFrameTransformed, 'Montage');
      I = imshow(videoFrameTransformed, 'Parent');
      set(I,'AlphaData',alpha);
      imshow(inputframe,'Parent');
      %%
      %{
      alphaBlender = vision.AlphaBlender( ...
     'Operation', 'Binary mask', 'MaskSource', 'Input port');

mask = videoFrameTransformed(:, :, 1) | ...
       videoFrameTransformed(:, :, 2) | ...
       videoFrameTransformed(:, :, 3) > 0;

outputFrame = step(alphaBlender, inputframe, videoFrameTransformed, mask);

figure(1)
imshow(outputFrame);

pointTracker = vision.PointTracker('MaxBidirectionalError', 2);
initialize(pointTracker, inlierCameraPts.Location, ...
'Size', 7, 'Color', 'yellow');

figure(1)
imshow(trackingMarkers);
%}
%124
% prevCameraFrame = inputframe;
% 
% cameraFrame = snapshot(camera);
% 
% [trackedPoints, isValid] = step(pointTracker, cameraFrame);
% 
% newValidLocations = trackedPoints(isValid, :);
% oldValidLocations = inlierCameraPts.Location(isValid, :);
% 
% if(nnz(isValid) >= 2)
% [trackingTransform, oldInlierLocations, newInlierLocations] = ...
%   estimateGeometricTransform( ...
%      oldValidLocations, newValidLocations, 'Similarity');
% end

% figure(1)
% showMatchedFeatures(prevCameraFrame, cameraFrame, ...
%    oldInlierLocations, newInlierLocations, 'Montage');
% 
% setPoints(pointTracker, newValidLocations);

%155
% trackingTransform.T = referenceTransform.T * trackingTransform.T;
% 
% repFrame = step(video);
% 
% outputView = imref2d(size(referenceImage));
% videoFrameScaled = imwarp(videoFrame, sclaeTransform, ...
%    'OutputView', outputView);
% 
% figure(1)
% imshowpair(referenceImage, videoFrameScaled, 'Montage');

%170
% outputView = imref2d(size(cameraFrame));
% videoFrameTransformed = imwarp(videoFrameScaled, trackingTransform, ... 
%   'OutputView', outputView);
% figure(1)
% imshowpair(referenceImage, videoFrameTransformed, 'Montage');
% 
% mask = videoFrameTransformed(:, :, 1) | ...
%        videoFrameTransformed(:, :, 2) | ...
%        videoFrameTransformed(:, :, 3) > 0;
% 
% outputFrame = step(alphaBlender, cameraFrame, videoFrameTransformed, mask);
% 
% figure(1)
% imshow(outputFrame);
% 
% release(video)
% delete(camera)
    %%
%     H = getHomography('test.bmp', 'texture.bmp');
%     disp(H);
    disp((referenceTransform.T));
    
end

