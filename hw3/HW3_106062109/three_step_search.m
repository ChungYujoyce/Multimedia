function [predict_img,psnr,total_SAD] = three_step_search(search_range,macroblock,refimg,targetimg) 

    figure('Name',['Search range: ',num2str(search_range),' Macroblock size: ',num2str(macroblock),' Search method: Three_step_search'],'NumberTitle','off')
    subplot(2, 2, 4); imshow(targetimg);
    title('target image');

    %split into blocks 8*8, 16*16
    Image_Blocks_Ta = Split(targetimg,macroblock);

    %find block in refimg nearest to block in target image (full search, three step search)
    %put block found in refimg in targetimg creating prediction image
    [M, N, C, X, Y]=size(Image_Blocks_Ta);
    Image_Blocks_Pre = Image_Blocks_Ta;
    Vectormap = zeros(X,Y,2);
    p = search_range;
    total_SAD = 0;
    for i=1:X
        for j=1:Y
            [Image_Blocks_Pre(:,:,:,i,j), vector,SAD] = Threestep(refimg, Image_Blocks_Ta(:,:,:,i,j), p, i, j);
            total_SAD = total_SAD + SAD;
            Vectormap(i,j,1) = vector(1);
            Vectormap(i,j,2) = vector(2);
        end
    end
    %construct and show predicted images
    predict_img = Construct(Image_Blocks_Pre,macroblock);
    subplot(2, 2, 1); imshow(predict_img);
    title('predicted image');
    %Show the motion vectors images 
    x = [];
    y = [];
    u = [];
    v = [];
    for i=1:X
        for j=1:Y
            x = [x, j];
            y = [y, i];
            u = [u, Vectormap(i,j,1)];
            v = [v, Vectormap(i,j,2)];
        end
    end

    im_plot = subplot(2, 2, 2); quiver(x,y,u,v); axis image
    hax = gca; %get the axis handle
    im = image(hax.XLim,hax.YLim,refimg); %plot the image within the axis limits
    im.AlphaData = 0.5;
    hold on; %enable plotting overwrite
    quiver(x,y,u,v) %plot the quiver on top of the image (same axis limits)
    hold off;
    title('motion vectors image');

    %Show the residual images 
    residual_img_R = im2double(abs(refimg(:,:,1)-predict_img(:,:,1)));
    residual_img_G = im2double(abs(refimg(:,:,2)-predict_img(:,:,2)));
    residual_img_B = im2double(abs(refimg(:,:,3)-predict_img(:,:,3)));
    residual_img = im2double(residual_img_R + residual_img_B + residual_img_G);
    subplot(2, 2, 3); imshow(residual_img);
    title('residual image');
    psnr = PSNR(targetimg,predict_img);
end

%functions
function [Pre_block, vector,SAD] = Threestep(refimg,Tar_block, p, x_origin, y_origin) 
    [X ,Y, C] = size(refimg);
    [R ,R, C] = size(Tar_block);
    tempBlock = Tar_block;
    %calculate block position
    real_origin_x = (x_origin-1)*R+1;
    real_origin_y = (y_origin-1)*R+1;
    start_x = real_origin_x-p;
    start_y = real_origin_y-p;
    %find min abs block
    for t=1:3
        SAD = 10000;
        for i=1:3
            for j=1:3
                if ((start_x+p*(i-1))>=1) && ((start_y+p*(j-1))>=1) && ((start_x+p*(i-1)+R-1)<=X) && ((start_y+p*(j-1)+R-1)<=Y)
                    ref_block = refimg(start_x+p*(i-1):start_x+p*(i-1)+R-1,start_y+p*(j-1):start_y+p*(j-1)+R-1,:);
                    dif = sum(abs(ref_block-Tar_block),'all');
                    if SAD >= dif
                        SAD = dif;
                        tempBlock = ref_block;
                        temp_vector = [(start_x+p*(i-1)), (start_y+p*(j-1))];
                    end
                end
                
            end
        end
        p=p/2;
        start_x = temp_vector(1);
        start_y = temp_vector(2);
    end
    vector = [temp_vector(1)-real_origin_x, temp_vector(2)-real_origin_y];
    Pre_block = tempBlock;
end
function [Image_Blocks] = Split(img,macro) %split image into blocks
    [M, N, C, ~]=size(img);
    Image_Blocks = zeros(macro,macro,C);
    for c=1:C
        for i=1:M/macro
            for j=1:N/macro
                Image_Blocks(:,:,c,i,j) = img(macro*(i-1)+1:macro*i,macro*(j-1)+1:macro*j,c);
            end
        end
    end
end
function [Constructed] = Construct(img_blocks,macro) %reconstruct whole image
    [M, N, C, X, Y]=size(img_blocks);
    Constructed = zeros(M,N,C);
    for c=1:C
        for i=1:X
            for j=1:Y
                Constructed(macro*(i-1)+1:macro*i,macro*(j-1)+1:macro*j,c) = img_blocks(:,:,c,i,j);
            end
        end
    end
end
function psnr = PSNR(A,B)
    A = im2double(A)*255; B = im2double(B)*255;
    mse = sum((A(:)-B(:)).^2) / prod(size(A));
    psnr = 10*log10(255*255/mse);
end
