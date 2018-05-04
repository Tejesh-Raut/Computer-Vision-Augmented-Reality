function [ v ] = applyHomography( v1, H )
% Function to apply homography to a set of vertices
numvertices = size(v1);
v = zeros(numvertices(1), 3);
for i=1:numvertices(1)
    temp = zeros(4, 1);
    temp(1,1) = v1(i, 1);
    temp(2,1) = v1(i, 2);
    temp(3,1) = v1(i, 3);
    temp(4,1) = 1;
    temp = H*temp;
%     disp(size(temp))
    v(i,1) = temp(1,1)/temp(4,1);
    v(i,2) = temp(2,1)/temp(4,1);
    v(i,3) = temp(3,1)/temp(4,1);
end;

end

