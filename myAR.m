function myAR(testImage, referenceImage)
% Main file to run
% https://stackoverflow.com/questions/42608708/how-to-get-the-transformation-matrix-of-a-3d-model-to-object-in-a-2d-image
% This article mentions the problem in finding a transformation matrix to
% place a 3D model over a 2D object detected
% For object detection we reffered https://in.mathworks.com/videos/object-recognition-and-tracking-for-augmented-reality-90546.html

    addpath(genpath('src'));
    addpath(genpath('images'));
%     [v, f, col] = getHumanoidCoordinates();


    texture = imread(referenceImage);
    textureGray = rgb2gray(texture);
    texturePts = detectSURFFeatures(textureGray);
    textureFeatures = extractFeatures(textureGray, texturePts);
    
    %% 
%     figure;
%     imshow(referenceImage); hold on;
%     plot(referencePts.selectStrongest(50));    
    
    %% input
    inputframe = imread(testImage);

    inputframeGray = rgb2gray(inputframe);
    
%%
%     figure(2);
%     imshow(inputframe);

    inputPts = detectSURFFeatures(inputframeGray);
    
%     figure(1);
%     imshow(inputframe); hold on;
%     plot(inputPts.selectStrongest(50));
    
%%
    inputFeatures = extractFeatures(inputframeGray, inputPts);
    
    idxPairs = matchFeatures(inputFeatures, textureFeatures);
    matchedInputPts = inputPts(idxPairs(:, 1));
    matchedTexturePts = texturePts(idxPairs(:, 2));
    
%%
%     figure(1);
%     showMatchedFeatures(inputframe, referenceImage, ...
%                         matchedInputPts, matchedReferencePts, 'Montage');
                    
%% Geometric transformation
    [textureTransformMatrix, ~, ~, status] ...
        = estimateGeometricTransform(...
                matchedTexturePts, matchedInputPts, 'Similarity');
    if(status~=0)
        disp('Cannot find reference image');
        %quit;
    else
        
        outputFrame = imread('temp.jpg'); % template to be placed over the image
%%
%      figure(1);
%      showMatchedFeatures(inputframe, referenceImage, ...
%                         inlierCameraPts, inlierReferencePts, 'Montage');

%%
      disp(textureTransformMatrix)
      outputView = imref2d(size(inputframe));
      outputTransformed = imwarp(outputFrame, textureTransformMatrix, ...
                                    'OutputView', outputView);
%%
      figure(1);
      imshowpair(inputframe, outputTransformed, 'Montage');

%%

    disp((textureTransformMatrix.T));
    end;
end

