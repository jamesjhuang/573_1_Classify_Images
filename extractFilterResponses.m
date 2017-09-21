function [filterResponses] = extractFilterResponses(img, filterBank)
% Extract filter responses for the given image.
% Inputs: 
%   img:                a 3-channel RGB image with width W and height H
%   filterBank:         a cell array of N filters
% Outputs:
%   filterResponses:    a W x H x N*3 matrix of filter responses


% TODO Implement your code here

% Check if img is floating point, convert otherwise
if ~isfloat(img)
    img = double(img);
end

% Checking if grayscale, if so, replicate matrix 3 times
if size(img, 3) == 1
    img = repmat(img, [ 1 1 3]);
end

% Converting to L*a*b space
% R = img(:, :, 1);
% G = img(:, :, 2);
% B = img(:, :, 3);
[L, a, b] = RGB2Lab(img(:, :, 1), img(:, :, 2), img(:, :, 3));
Lab = RGB2Lab(img);

imgSize = size(img);
filterResponses = zeros( imgSize(1), imgSize(2), 3 * length(filterBank));
j = 1;
for i = 1: length(filterBank)
    filterResponses(:, :, j) = imfilter(L, filterBank{i}, 'conv');
    filterResponses(:, :, j + 1) = imfilter(a, filterBank{i}, 'conv');
    filterResponses(:, :, j + 2) = imfilter(b, filterBank{i}, 'conv');
    j = j + 3;
end

end
