clear all; close all; clc

img = im2double(imread('./bg.png'));
[h, w, ~] = size(img);
% imshow(img);

%points = importdata('./points.txt');
Point = [234.24658 119.17808 ;
    250.36094 128.50355 ;
    251.99459 133.91289 ;
    259.2777 148.3188 ;
    268.26586 166.0973 ; 
    267.05648 180.26424 ; 
    270.48568 200.24906 ;
    268.78552 217.1682; 
    257.47185 220.8241; 
    245.82815 216.68742; 
    241.68585 215.20034; 
    228.74373 205.00553 ;
    225.2802 207.72105 ;
    222.6937 211.19322 ;
    232.45694 222.41527 ;
    223.03861 223.7858 ;
    216.37325 224.49366 ;
    210.65395 217.80645 ;
    206.60025 212.20423 ;
    204.6422 192.94196 ;
    214.46627 204.13973 ;
    214.81943 203.98506 ;
    220.22691 200.73426 ;
    218.09832 174.14177 ;
    216.31382 171.85554 ;
    212.94262 167.84686 ;
    202.27071 170.58473 ;
    200.99626 165.50435 ;
    201.25153 155.16814 ;
    227.60729 152.86622 ;
    232.00498 148.6924 ;
    227.48113 141.36594 ;
    220.89208 135.40109 ;
    227.1482 124.40847 ;
    228.69919 121.79361 ;
    231.30809 119.23725 ;
    234.24658 119.17808;
];

%% Curve Computation
n = size(Point, 1); % number of input points

%==============================================================%
% Code here. Store the results as `result1`, `result2`


M =  [-1 3 -3 1;
       3 -6 3 0;
       -3 3 0 0;
       1 0 0 0;];

%low detail
index=1;
for i=0:3:35
   % disp(i);
    for t = 0:0.2:1
         T = [t.^3 t.^2 t 1];
        pt1 = Point(i+1,:);
        pt2 = Point(i+2,:);
        pt3 = Point(i+3,:);
        if (i==35)
            pt4 = Point(1,:);
        else  
            pt4 = Point((i+4),:);
        end
        G = [pt1; pt2; pt3; pt4;];
        LD(index,:)=T*M*G;
        t = t+0.2;
        index = index+1;
    end
end
% high detail
index=1;
for i=0:3:35
    for t = 0:0.01:1
         T = [t.^3 t.^2 t 1];
        pt1 = Point(i+1,:);
        pt2 = Point(i+2,:);
        pt3 = Point(i+3,:);
        if (i==35)
            pt4 = Point(1,:);
        else  
            pt4 = Point((i+4),:);
        end
        G = [pt1; pt2; pt3; pt4;];
        HD(index,:)=T*M*G;
        t = t+0.01;
        index = index+1;
    end
end

%==============================================================%

result1 = LD; % shaped [?, 2]
result2 = HD; % shaped [?, 2]

% Draw the polygon of the curve
f = figure;
subplot(1, 2, 1);
imshow(img);
hold on
plot(Point(:, 1), Point(:, 2), 'r.');
plot(result1(:, 1), result1(:, 2), 'g-');
title('Low Detail');
subplot(1, 2, 2);
imshow(img);
hold on
plot(Point(:, 1), Point(:, 2), 'r.');
plot(result2(:, 1), result2(:, 2), 'g-');
title('High Detail');
saveas(f, '1a.png');

%% Scaling
Point = Point .* 4;
%==============================================================%
%NHD = zeros([h*4, w*4, 3]);
img_4 = imresize(img, 4, 'nearest');
%imshow(result3);
% redraw high detail
index=1;
for i=0:3:35
    for t = 0:0.01:1
         T = [t.^3 t.^2 t 1];
        pt1 = Point(i+1,:);
        pt2 = Point(i+2,:);
        pt3 = Point(i+3,:);
        if (i==35)
            pt4 = Point(1,:);
        else  
            pt4 = Point((i+4),:);
        end
        G = [pt1; pt2; pt3; pt4;];
        NHD(index,:)=T*M*G;
        t = t+0.01;
        index = index+1;
    end
end
result3 = NHD;
ff =figure;
imshow(img_4)
hold on
plot(Point(:, 1), Point(:, 2), 'r.');
plot(result3(:, 1), result3(:, 2), 'g-');
saveas(ff, '1b.png');
%==============================================================%