clear; clc;

%% load the image 

apple = imread('apple.jpeg');
%imshow(apple);

%% Color Based Image Segmentation
r = apple(:,:,1);
g = apple(:,:,2);
b = apple(:,:,3);

figure(1);
subplot(2,2,1); imshow(apple);
subplot(2,2,2); imshow(r);
subplot(2,2,3); imshow(g);
subplot(2,2,4); imshow(b);

%% enhance the contrast 
K = imadjust(b,[0.4 0.7],[]);


%% banarize the image
figure(2);

BW = imbinarize(K,0.6);
BW2 = imcomplement(BW);

imshowpair(K,BW2,'montage');

%% compute object property
stats = regionprops('table',BW2,'Centroid', 'MajorAxisLength','MinorAxisLength')

centers = stats.Centroid(1,:);
diameters = mean([stats.MajorAxisLength(1) stats.MinorAxisLength(1)],2);
radii = diameters/2;

%% draw circle on object 

figure(4)
imshow(apple)
h = viscircles(centers,radii);
d = imdistline;



