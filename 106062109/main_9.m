% main control section
clc;
while(1)
   choose = input('Choose your mode: \n 1: DCT_image_Compression--different n\n 2: DCT_image_Compression--YIQ model\n 3: Dithering \n 4: Image_Convolution--with different hsize \n 5: Image_Convolution--with different sigma \n 6: Leave\n');
   if choose == 1
       DCT_Compression_9(1)
   elseif choose == 2
       DCT_Compression_9(2)
   elseif choose == 3
       Dithering_9(3)
   elseif choose == 4
       Image_Convolution_9(4)
   elseif choose == 5
       Image_Convolution_9(5)
   else 
       disp('thank you');
       break
   end
    
    
end