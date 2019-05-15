function Image_Convolution_9(choose)
    img=imread('data/cat3_LR.png');
    
    if choose == 4
        cov_img1 = Con(img,3,1);
        cov_img2 = Con(img,5,1);
        cov_img3 = Con(img,7,1);
        
        subplot(2, 2, 1);  imshow(img); axis image
        title(['Original'])
        subplot(2, 2, 2);  imshow(cov_img1); axis image
        title(['hsize: 3x3 PSNR:',num2str(PSNR_9(img,cov_img1))])
        subplot(2, 2, 3);  imshow(cov_img2); axis image
        title(['hsize: 5x5 PSNR:',num2str(PSNR_9(img,cov_img2))])
        subplot(2, 2, 4);  imshow(cov_img3); axis image
        title(['hsize: 7x7 PSNR:',num2str(PSNR_9(img,cov_img3))])
        sgt = sgtitle('--with same sigma--','Color','red');
        sgt.FontSize = 20;

        imwrite(cov_img1,'convolution_3x3.jpg','jpg','Comment','hsize 3*3')
        imwrite(cov_img2,'convolution_5x5.jpg','jpg','Comment','hsize 5*5')
        imwrite(cov_img3,'convolution_7x7.jpg','jpg','Comment','hsize 7*7')
    else
        cov_img4 = Con(img,5,1);
        cov_img5 = Con(img,5,5);
        cov_img6 = Con(img,5,10);

        subplot(2, 2, 1);  imshow(img); axis image
        title(['Original'])
        subplot(2, 2, 2);  imshow(cov_img4); axis image
        title(['Sigma:1 PSNR:',num2str(PSNR_9(img,cov_img4))])
        subplot(2, 2, 3);  imshow(cov_img5); axis image
        title(['Sigma:5 PSNR:',num2str(PSNR_9(img,cov_img5))])
        subplot(2, 2, 4);  imshow(cov_img6); axis image
        title(['Sigma:10 PSNR:',num2str(PSNR_9(img,cov_img6))])
        sgt = sgtitle('--with same hsize(5)--','Color','red');
        sgt.FontSize = 20;
        
        imwrite(cov_img4,'convolution_sig1.jpg','jpg','Comment','sigma 1')
        imwrite(cov_img5,'convolution_sig5.jpg','jpg','Comment','sigma 5')
        imwrite(cov_img6,'convolution_sig10.jpg','jpg','Comment','sigma 10')
    end
    function [con] = Con(img,hsize,sigma)
        [m,n,c]=size(img);
        padding = round(hsize/2-1);
        pad_img = padarray(img,[padding padding],0,'both');
        G = fspecial( 'gaussian', [hsize hsize], sigma);
        con = zeros(m,n);
        for t=1:c
            for i=1+padding:m+padding
                for j=1+padding:n+padding
                    tmp = 0;
                    for x=0:(hsize-1)
                        for y=0:(hsize-1)
                            tmp = tmp + G(x+1,y+1)*pad_img(i-padding+x,j-padding+y,t);
                        end
                    end
                    if i-1 <= m && j-1 <= n ; con(i-1,j-1,t) = tmp; end
                end
            end
        end
        con = con/255;                    
    end
end