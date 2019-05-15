function Dithering_9(choose)
    img=imread('data/cat2_gray.png');
    
    dither1 = Random(img);
    dither2 = Average(img);
    dither3 = Error(img);

    subplot(2, 2, 1);  imshow(img); axis image
    title('Original')
    subplot(2, 2, 2);  imshow(dither1); axis image
    title('Random Dithering')
    subplot(2, 2, 3);  imshow(dither2); axis image
    title('Average Dithering')
    subplot(2, 2, 4);  imshow(dither3); axis image
    title('Error Diffusion')
    sgt = sgtitle('--Different Dithering model--','Color','red');
    sgt.FontSize = 20;
    
    imwrite(dither1,'Random_Dithering.jpg','jpg','Comment','Random_Dithering')
    imwrite(dither2,'Average_Dithering.jpg','jpg','Comment','Average_Dithering')
    imwrite(dither3,'Error_Diffusion.jpg','jpg','Comment','Error_Diffusion_Dithering')
    function [random] = Random(img)
        [m, n, ~]=size(img);
        r = randi([0,255],m,n);
        random = zeros(m,n);
        for i=1:m
            for j=1:n
                if img(i,j) > r(i,j)
                    random(i,j) = 255;
                else
                    random(i,j) = 0;
                end
            end
        end
        random = random/255;
    end

    function [average] = Average(img)
        [m, n, ~]=size(img);
        avg = sum(img(:))/(m*n);
        average = zeros(m,n);
        for i=1:m
            for j=1:n
                if img(i,j) > avg
                    average(i,j) = 255;
                else
                    average(i,j) = 0;
                end
            end
        end
        average = average/255;
    end

    function [error] = Error(img)
        [m, n, ~]=size(img);
        tmp = img;
        error = zeros(m,n);
        for i=1:m
            for j=1:n
                if tmp(i,j) < 128; e = tmp(i,j);
                else; e = tmp(i,j) - 255; end
                
                if i+1 <=m ; tmp(i+1,j) = tmp(i+1,j) +e*7/16; end
                if i-1 >= 1 && j+1 <= n ; tmp(i-1,j+1) = tmp(i-1,j+1)+e*3/16; end
                if j+1 <= n ; tmp(i,j+1) = tmp(i,j+1) +e*5/16; end 
                if i+1 <=m && j+1 <=n ; tmp(i+1,j+1) = tmp(i+1,j+1) + e*1/16; end
            end
        end
        
        for i=1:m
            for j=1:n
                if tmp(i,j) > 128 ; error(i,j) = 255;
                else; error(i,j) = 0; end
            end
        end
        error = error/255;
    end
end

