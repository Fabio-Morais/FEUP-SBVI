clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
imtool close all;  % Close all imtool figures if you have the Image Processing Toolbox.
clear;  % Erase all existing variables. Or clearvars if you want.
workspace;  % Make sure the workspace panel is showing.
format long g;
format compact;
fontSize = 20;
% Read in a standard MATLAB gray scale demo image.
folder = 'C:\Users\Alberto Santos\Desktop\SBVI\licensePlates';
baseFileName = '3_plate_detail.png';
% Get the full filename, with path prepended.
fullFileName = fullfile(folder, baseFileName);
% Check if file exists.
if ~exist(fullFileName, 'file')
  % File doesn't exist -- didn't find it there.  Check the search path for it.
  fullFileName = baseFileName; % No path this time.
  if ~exist(fullFileName, 'file')
    % Still didn't find it.  Alert user.
    errorMessage = sprintf('Error: %s does not exist in the search path folders.', fullFileName);
    uiwait(warndlg(errorMessage));
    return;
  end
end
grayImage = imread(fullFileName);
% Get the dimensions of the image.  
% numberOfColorBands should be = 1.
[rows, columns, numberOfColorBands] = size(grayImage);
% Display the original gray scale image.
subplot(2, 2, 1);
imshow(grayImage, []);
title('Original Grayscale Image', 'FontSize', fontSize);
% Enlarge figure to full screen.
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
% Give a name to the title bar.
set(gcf,'name','Demo by ImageAnalyst','numbertitle','off') 
% Let's compute and display the histogram.
[pixelCount, grayLevels] = imhist(grayImage);
subplot(2, 2, 2); 
bar(pixelCount);
grid on;
title('Histogram of original image', 'FontSize', fontSize);
xlim([0 grayLevels(end)]); % Scale x axis manually.
binaryImage = grayImage < 128;
% Get rid of small blobs, smaller than two rows of pixels.
binaryImage = bwareaopen(binaryImage, 2*rows);
% Display the original gray scale image.
subplot(2, 2, 3);
imshow(binaryImage, []);
title('Binary Image', 'FontSize', fontSize);
% Label the image.
[labeledImage, numberOfBlobs] = bwlabel(binaryImage);
% Find the centroid
measurements = regionprops(labeledImage, 'Centroid');
% Put a cross at the centroid.
xCentroid = measurements.Centroid(1);
yCentroid = measurements.Centroid(2);
fprintf('X Centroid = %.3f, Y Centroid = %.3f', xCentroid, yCentroid);
hold on;
plot(xCentroid, yCentroid, 'r+', 'MarkerSize', 30);
% Find out how far the centroid is from points in each quadrant
% First get all the points.
[rows columns] = find(binaryImage);
xCorners = [0 0 0 0]; % X coordinate of corners in each quadrant.
yCorners = [0 0 0 0]; % X coordinate of corners in each quadrant.
maxDistance = [0 0 0 0]; % Distance of furthers X coordinate from centroid in each quadrant.
for k = 1 : length(columns)
  rowk = rows(k);
  colk = columns(k);
  distanceSquared = (colk - xCentroid)^2 + (rowk - yCentroid)^2;
  if rowk < yCentroid
    % It's in the top half
    if colk < xCentroid
      % It's in the upper left quadrant
      if distanceSquared > maxDistance(1)
        % Record the new furthest point in quadrant #1.
        maxDistance(1) = distanceSquared;
        xCorners(1) = colk;
        yCorners(1) = rowk;
      end
    else
      % It's in the upper right quadrant
      if distanceSquared > maxDistance(2)
        % Record the new furthest point in quadrant #2.
        maxDistance(2) = distanceSquared;
        xCorners(2) = colk;
        yCorners(2) = rowk;
      end
    end
  else
    % It's in the bottom half.
    if colk < xCentroid
      % It's in the lower left quadrant
      if distanceSquared > maxDistance(3)
        % Record the new furthest point in quadrant #3.
        maxDistance(3) = distanceSquared;
        xCorners(3) = colk;
        yCorners(3) = rowk;
      end
    else
      % It's in the lower right quadrant
      if distanceSquared > maxDistance(4)
        % Record the new furthest point in quadrant #4.
        maxDistance(4) = distanceSquared;
        xCorners(4) = colk;
        yCorners(4) = rowk;
      end
    end
  end
end
% Display in command window.
xCorners
yCorners
figure;
% Display the original gray scale image.
hImage = imshow(binaryImage, []);
title('Binary Image', 'FontSize', fontSize);
hold on;
% Enlarge figure to full screen.
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
% Place markers at the corners
plot(xCorners, yCorners,  'rs', 'MarkerSize', 10, 'LineWidth', 3);
impixelinfo(hImage);
% Plot centroid again
plot(xCentroid, yCentroid, 'r+', 'MarkerSize', 30, 'LineWidth', 3);