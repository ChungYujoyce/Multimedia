function DCT_Compression_9(choose)
    img = imread('data/cat1.png');
    
    if choose == 1
        img_RGB = img;
        R = img(:,:,1);
        G = img(:,:,2);
        B = img(:,:,3);

        R_do = DCT_prev_work_9(R,2);
        G_do = DCT_prev_work_9(G,2);
        B_do = DCT_prev_work_9(B,2);

        [M, N, ~]=size(img);
        do_image1 = zeros(M,N);
        do_image1(:,:,1) = R_do/255;
        do_image1(:,:,2) = G_do/255;
        do_image1(:,:,3) = B_do/255;

        R_do = DCT_prev_work_9(R,4);
        G_do = DCT_prev_work_9(G,4);
        B_do = DCT_prev_work_9(B,4);

        [M, N, ~]=size(img);
        do_image2 = zeros(M,N);
        do_image2(:,:,1) = R_do/255;
        do_image2(:,:,2) = G_do/255;
        do_image2(:,:,3) = B_do/255;

        R_do = DCT_prev_work_9(R,8);
        G_do = DCT_prev_work_9(G,8);
        B_do = DCT_prev_work_9(B,8);

        [M, N, ~]=size(img);
        do_image3 = zeros(M,N);
        do_image3(:,:,1) = R_do/255;
        do_image3(:,:,2) = G_do/255;
        do_image3(:,:,3) = B_do/255;
        
        subplot(2, 2, 1);  imshow(img_RGB); axis image
        title('Original') 
        subplot(2, 2, 2);  imshow(do_image1); axis image
        title(['n=2 PSNR:',num2str(PSNR_9(img,do_image1))])
        subplot(2, 2, 3);  imshow(do_image2); axis image
        title(['n=4 PSNR:',num2str(PSNR_9(img,do_image2))])
        subplot(2, 2, 4);  imshow(do_image3); axis image
        title(['n=8 PSNR:',num2str(PSNR_9(img,do_image3))])
        sgt = sgtitle('--Different N in RGB--','Color','red');
        sgt.FontSize = 20;
      
        imwrite(do_image1,'RGB_compress2.jpg','jpg','Comment','2*2 compress')
        imwrite(do_image2,'RGB_compress4.jpg','jpg','Comment','4*4 compress')
        imwrite(do_image3,'RGB_compress8.jpg','jpg','Comment','8*8 compress')
%---------------------------------------------------------------------
% YIQ model
    else
        YIQ = im2double(zeros(size(img)));

        for i=1:size(img,1)
            for j=1:size(img,2)
                YIQ(i,j,1)=0.2989*im2double(img(i,j,1))+0.5870*im2double(img(i,j,2))+0.1140*im2double(img(i,j,3));
                YIQ(i,j,2)=0.596*im2double(img(i,j,1))-0.274*im2double(img(i,j,2))-0.322*im2double(img(i,j,3));
                YIQ(i,j,3)=0.211*im2double(img(i,j,1))-0.523*im2double(img(i,j,2))+0.312*im2double(img(i,j,3));
            end
        end

        Y_R=YIQ(:, :, 1);
        Y_G=YIQ(:, :, 2);
        Y_B=YIQ(:, :, 3);

        R_do = DCT_prev_work_9(Y_R,2);
        G_do = DCT_prev_work_9(Y_G,2);
        B_do = DCT_prev_work_9(Y_B,2);

        [M, N, ~]=size(img);
        do_image4 = im2double(zeros(M,N));
        do_image4(:,:,1) = R_do;
        do_image4(:,:,2) = G_do;
        do_image4(:,:,3) = B_do;
        
        RGB_2 = im2double((zeros(size(img))));
        for i=1:size(do_image4,1)
            for j=1:size(do_image4,2)
                RGB_2(i,j,1)=1*im2double(do_image4(i,j,1))+0.956*im2double(do_image4(i,j,2))+0.619*im2double(do_image4(i,j,3));
                RGB_2(i,j,2)=1*im2double(do_image4(i,j,1))-0.272*im2double(do_image4(i,j,2))-0.647*im2double(do_image4(i,j,3));
                RGB_2(i,j,3)=1*im2double(do_image4(i,j,1))-1.106*im2double(do_image4(i,j,2))+1.703*im2double(do_image4(i,j,3));
            end
        end

        R_do = DCT_prev_work_9(Y_R,4);
        G_do = DCT_prev_work_9(Y_G,4);
        B_do = DCT_prev_work_9(Y_B,4);

        [M, N, ~]=size(img);
        do_image5 = im2double(zeros(M,N));
        do_image5(:,:,1) = R_do;
        do_image5(:,:,2) = G_do;
        do_image5(:,:,3) = B_do;
        
        RGB_4 = im2double((zeros(size(img))));
        for i=1:size(do_image5,1)
            for j=1:size(do_image5,2)
                RGB_4(i,j,1)=1*im2double(do_image5(i,j,1))+0.956*im2double(do_image5(i,j,2))+0.619*im2double(do_image5(i,j,3));
                RGB_4(i,j,2)=1*im2double(do_image5(i,j,1))-0.272*im2double(do_image5(i,j,2))-0.647*im2double(do_image5(i,j,3));
                RGB_4(i,j,3)=1*im2double(do_image5(i,j,1))-1.106*im2double(do_image5(i,j,2))+1.703*im2double(do_image5(i,j,3));
            end
        end

        R_do = DCT_prev_work_9(Y_R,8);
        G_do = DCT_prev_work_9(Y_G,8);
        B_do = DCT_prev_work_9(Y_B,8);

        [M, N, ~]=size(img);
        do_image6 = im2double(zeros(M,N));
        do_image6(:,:,1) = R_do;
        do_image6(:,:,2) = G_do;
        do_image6(:,:,3) = B_do;
        
        RGB_8 = im2double((zeros(size(img))));
        for i=1:size(do_image6,1)
            for j=1:size(do_image6,2)
                RGB_8(i,j,1)=1*im2double(do_image6(i,j,1))+0.956*im2double(do_image6(i,j,2))+0.619*im2double(do_image6(i,j,3));
                RGB_8(i,j,2)=1*im2double(do_image6(i,j,1))-0.272*im2double(do_image6(i,j,2))-0.647*im2double(do_image6(i,j,3));
                RGB_8(i,j,3)=1*im2double(do_image6(i,j,1))-1.106*im2double(do_image6(i,j,2))+1.703*im2double(do_image6(i,j,3));
            end
        end
        %imshowpair(img,RGB_8, "diff");
       
        subplot(2, 2, 1);  imshow(YIQ); axis image
        title('Original YIQ') 
        subplot(2, 2, 2);  imshow(RGB_2); axis image
        title(['n=2 PSNR:',num2str(PSNR_9(img,RGB_2))])
        subplot(2, 2, 3);  imshow(RGB_4); axis image
        title(['n=4 PSNR:',num2str(PSNR_9(img,RGB_4))])
        subplot(2, 2, 4);  imshow(RGB_8); axis image
        title(['n=8 PSNR:',num2str(PSNR_9(img,RGB_8))])
        sgt = sgtitle('--Different N processed by YIQ--','Color','red');
        sgt.FontSize = 20;

        imwrite(RGB_2,'YIQ_compress2.jpg','jpg','Comment','2*2 compress')
        imwrite(RGB_4,'YIQ_compress4.jpg','jpg','Comment','4*4 compress')
        imwrite(RGB_8,'YIQ_compress8.jpg','jpg','Comment','8*8 compress')
        
    end
end