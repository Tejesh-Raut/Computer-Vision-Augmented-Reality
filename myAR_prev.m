function myAR_prev()
% Main file to run
    addpath(genpath('src'));
    addpath(genpath('images'));
    [v, f, col] = getHumanoidCoordinates();
    H = getHomography('texture4.bmp', 'texture4.bmp');
%     v1= v;
    v1 = applyHomography(v, H);
    drawMesh(v1, f, col, 'texture4.bmp');
end

