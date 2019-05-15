function [do_img] = DCT_prev_work_9(img,pros_n)
    % set process data
    block = 8;
    [M,N,~] = size(img);
    image_cut = zeros(block,block);
    DCT_img = zeros(block,block);
    DCT_img_tmp = zeros(block,block);
    do_img_tmp = zeros(block,block);
    do_blocks = zeros(block,block);
    do_img = zeros(M,N);
    
    % image devide in blocks
    n = 1;
    for i=1:M/block
        for j=1:N/block
            image_cut(:,:,n) = img(block*(i-1)+1:block*i,block*(j-1)+1:block*j);
            n = n + 1;
        end
    end
    
    % DCT process
    m = 1;
    for i=1:n-1
        for r=0:block-1
            for s=0:block-1
                %only keep the lower-frequency
                if r<pros_n && s<pros_n
                    DCT_img_tmp(r+1,s+1) = DCT(r,s,image_cut(:,:,i));
                end
            end
        end
        DCT_img(:,:,m) = DCT_img_tmp;
        m = m + 1;
    end
    
    % reconstruct image block
    n = 1;
    for i=1:m-1
        for r=0:block-1
            for s=0:block-1
                do_img_tmp(r+1,s+1) = iDCT(r,s,DCT_img(:,:,i));
            end
        end
        do_blocks(:,:,n) = do_img_tmp;
        n = n + 1;
    end
    
    % form back whole pic
    n = 1;
    for i=1:M/block
        for j=1:N/block
            do_img(block*(i-1)+1:block*i,block*(j-1)+1:block*j) = do_blocks(:,:,n);
            n = n + 1;
        end
    end
end

%C reference slide page 111
function C_val = C(pixel)
    if pixel == 0
        C_val = 2^0.5/2;
    else
        C_val = 1;
    end
end

% DCT or iDCT determine by img input
function DCT_do = DCT(u,v,img)
    block = 8;
    DCT_do = 0;
    for i=0: block-1
        for j=0: block-1
            % F(u,v) = f(r,s) ...with process...
            DCT_do = DCT_do + img(i+1,j+1)*2*C(u)*C(v)/sqrt(block*block)*cos((2*i+1)*u*pi/(2*block))*cos((2*j+1)*v*pi/(2*block));
        end
    end 
end

% inverse DCT
function iDCT_do = iDCT(u,v,img)
  block = 8;
    iDCT_do = 0;
    for i=0:block-1
        for j=0:block-1
           iDCT_do = iDCT_do + img(i+1,j+1)*2*C(i)*C(j)/sqrt(block*block)*cos((2*u+1)*i*pi/(2*block))*cos((2*v+1)*j*pi/(2*block)); 
        end
    end
end