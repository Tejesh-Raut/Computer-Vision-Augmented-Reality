function myAR_prev()
% Main file to run
    addpath(genpath('src'));
    addpath(genpath('images'));
    [v, f, col] = getHumanoidCoordinates();
    H = getHomography('test.bmp', 'test.bmp');
%     v1= v;
    v1 = applyHomography(v, H);
    drawMesh(v1, f, col, 'test.bmp');
end

