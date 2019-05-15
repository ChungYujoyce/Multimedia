function psnr = PSNR_9(A,B)
    A = im2double(A)*255; B = im2double(B)*255;
    mse = sum((A(:)-B(:)).^2) / prod(size(A));
    psnr = 10*log10(255*255/mse);
end
