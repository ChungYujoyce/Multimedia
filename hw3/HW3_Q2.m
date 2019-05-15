close all;
clear;
clc;

while(1)
    img_2 = imread('data/frame432.jpg');
    img_2 = im2double(img_2);
    img_7 = imread('data/frame437.jpg');
    img_7 = im2double(img_7);
    img_9 = imread('data/frame439.jpg');
    img_9 = im2double(img_9);
    PSNR = [0,0];
   choose = input('Choose your mode: \n 1: Full_search p=8 macroblock=8x8 (PSNR comparison)\n 2: Leave\n');

   if choose ==1
       X=1:1:4;
       [pre_1,PSNR(1),SAD(1)]=full_search(8,8,img_2,img_9);
        [pre_2,PSNR(2),SAD(2)]=full_search(8,8,img_7,img_9);
        close all;
        figure('Name',['PSNR comparison of frame432,439 & frame437,439'],'NumberTitle','off')
        subplot(2,1,1),imshow(pre_1);
        title(['432 & 439 PSNR=',num2str(PSNR(1))]);
        subplot(2,1,2),imshow(pre_2);
        title(['437 & 439 PSNR=',num2str(PSNR(2))]);
   else
       disp('thank you');
       break
   end
    
end
    
    
