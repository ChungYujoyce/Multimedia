function p = PSNR(A,B)  
    [row_len,col_len,color] = size(A);
    mse = 1/(row_len*col_len*color)*sum(sum(sum((A-B).^2)));
    p=20*log10(1)-10*log10(mse);
end