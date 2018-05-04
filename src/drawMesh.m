function drawMesh( v, f, col, ftest)
%function to draw triangular mesh given vertices, faces and color at each
%vertex
testImg = imread(ftest);
figure(1);
imshow(testImg);
patch('Faces',f,'Vertices',v,'FaceVertexCData',col,'FaceColor','interp', 'EdgeColor', [0.9, 0.9, 0.9]);
saveas(gcf,'output/AugmentedTest.png');
end

