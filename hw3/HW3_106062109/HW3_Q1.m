close all;
clear;
clc;

while(1)
    img_7 = imread('data/frame437.jpg');
    img_7 = im2double(img_7);
    img_9 = imread('data/frame439.jpg');
    img_9 = im2double(img_9);
    PSNR = [0,0,0,0,0,0,0,0];
    SAD = [0,0,0,0,0,0,0,0];
   choose = input('Choose your mode: \n 1: Full_search p=8 macroblock=8x8\n 2: Full_search p=16 macroblock=8x8\n 3: Full_search p=8 macroblock=16x16 \n 4: Full_search p=16 macroblock=16x16 \n 5: 3_Step_Search p=8 macroblock=8x8\n 6: 3_Step_Search p=16 macroblock=8x8\n 7: 3_Step_Search p=8 macroblock=16x16 \n 8: 3_Step_Search p=16 macroblock=16x16 \n 9:show PSNR SAD relationship \n 10: Leave\n');
   if choose == 1
       [pre_1,PSNR(1),SAD(1)]=full_search(8,8,img_7,img_9)
   elseif choose == 2
       [pre_2,PSNR(2),SAD(2)]=full_search(16,8,img_7,img_9)
   elseif choose == 3
       [pre_3,PSNR_3,SAD_3]=full_search(8,16,img_7,img_9)
       PSNR(end+1)=PSNR_3; SAD(end+1)=SAD_3;
   elseif choose == 4
       [pre_4,PSNR_4,SAD_4]=full_search(16,16,img_7,img_9)
       PSNR(end+1)=PSNR_4; SAD(end+1)=SAD_4;
   elseif choose == 5
       [pre_5,PSNR_5,SAD_5]=three_step_search(8,8,img_7,img_9)
       PSNR(end+1)=PSNR_5; SAD(end+1)=SAD_5;
   elseif choose == 6
       [pre_6,PSNR_6,SAD_6]=three_step_search(16,8,img_7,img_9)
       PSNR(end+1)=PSNR_6; SAD(end+1)=SAD_6;
   elseif choose == 7
       [pre_7,PSNR_7,SAD_7]=three_step_search(8,16,img_7,img_9)
       PSNR(end+1)=PSNR_7; SAD(end+1)=SAD_7;
   elseif choose == 8
       [pre_8,PSNR_8,SAD_8]=three_step_search(16,16,img_7,img_9)
       
   elseif choose ==9
       x=1:1:4;
       [pre_1,PSNR(1),SAD(1)]=full_search(8,8,img_7,img_9);
       [pre_2,PSNR(2),SAD(2)]=full_search(16,8,img_7,img_9);
       [pre_3,PSNR(3),SAD(3)]=full_search(8,16,img_7,img_9);
       [pre_4,PSNR(4),SAD(4)]=full_search(16,16,img_7,img_9);
       [pre_5,PSNR(5),SAD(5)]=three_step_search(8,8,img_7,img_9);
       [pre_6,PSNR(6),SAD(6)]=three_step_search(16,8,img_7,img_9);
       [pre_7,PSNR(7),SAD(7)]=three_step_search(8,16,img_7,img_9);
       [pre_8,PSNR(8),SAD(8)]=three_step_search(16,16,img_7,img_9);
        close all;
        figure('Name',['PSNR & SAD comparison'],'NumberTitle','off')
        subplot(2,1,1),plot(x,PSNR(1:4),'b^-',x,PSNR(5:8),'k*-');
        %axis([1 4 0 50]);
        set(gca, 'xtick', [1 2 3 4])  
        set(gca, 'xticklabel', {'8, 8x8','16, 8x8','8, 16x16','16, 16x16'})  
        title('PSNR graph');
        legend('full','3step');
        SAD
        X=1:1:4;
        subplot(2,1,2),plot(X,SAD(1:4),'b^-',X,SAD(5:8),'k*-');
        set(gca, 'xtick', [1 2 3 4])  
        set(gca, 'xticklabel', {'8, 8x8','16, 8x8','8, 16x16','16, 16x16'}) 
        title('SAD graph');
        legend('full','3step');
   else
       disp('thank you');
       break
   end
    
    
end