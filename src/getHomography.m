function [ H ] = getHomography(ftest, ftexture)
% Function to get homography matrix
    R = [1, 0, 0, 0;
        0, 0.5, 0.866, 0;
        0, -0.866, 0.5, 0;
        0, 0, 0, 1
        ];
    S = [125, 0, 0, 0
        0, -125, 0, 0
        0, 0, 125, 0
        0, 0, 0, 1];
    T = [1, 0, 0, 375
        0, 1, 0, 125
        0, 0, 1, 125
        0, 0, 0, 1];
    H = T*R*S;
end

