%% load the image 
figure(1)
img = imread('lung_xray.jpeg');
subplot(2,2,1);
imshow(img);
title('original image');

%% binary image

I = rgb2gray(img);
BW = imbinarize(I);
subplot(2,2,2);
imshow(BW);
title('Binary image');

%% remove noise 
K = medfilt2(BW,[3,3]); % median filter to remove salt & peper noise

SE = strel('disk', 1); %creates a flat, disk-shaped structure,
I = imopen(K, SE); % remove disk smaller than 1px

J = imclearborder(I);

subplot(2,2,3);
imshow(J);
title('remove noise');



%% contour & segment

white = ones(size(J));
invert = white -J; % invert image manumally

mask = zeros(size(invert)); 
mask(50:end-50,50:end-50) = 1;

contour = activecontour(invert, mask, 800);

comb = invert + contour;
segment = medfilt2(mat2gray(comb),[5 5]);
BW2 = imbinarize(segment);

subplot(2,2,4);
imshow(BW2);
title('segment image');

%% detect tumor

[centers,radii] = imfindcircles(BW2,[1 9],'ObjectPolarity','dark','Sensitivity',0.88);

figure(2)

subplot(1,2,1);
imshow(BW2);
viscircles(centers,radii,'EdgeColor','g'); % Circles Display Green
title('detect tumor'); 

subplot(1,2,2);
black = zeros(size(J));
imshow(black);
viscircles(centers,radii,'EdgeColor','g'); 
title('tumor'); 


%% detect tumor
display(size(centers, 1), ' Numbers of tumor')


