
function HWQ2()
    clc; home;
    close all hidden

    Img = imread('input_exercise2.png');
    I = (uint8(mean(Img, 3)));
    K = mat2gray(I);
    
    radius = 2;
    structSize = radius * 2 + 1;
    [out, ix, iy] = guassfilter(2, K);
    [imgYSize, imgXSize]= size(out);
    
    W = [];
    Q = [];
    for yCenter = 1 + radius:imgYSize - radius
       for xCenter = 1 + radius:imgXSize - radius
           I2x  = 0;
           I2y  = 0;
           IxIy = 0;
           % iterate structure
           for yStr = 1:structSize
               for xStr = 1:structSize
                   % convert struct coordinates to image coordinates
                   yProjected = yCenter + yStr - radius - 1;
                   xProjected = xCenter + xStr - radius - 1;
                   % x and y images
                   y = iy(yProjected, xProjected);
                   x = ix(yProjected, xProjected);
                   % sum of extracted values
                   I2x  = I2x + power(x, 2);
                   I2y  = I2y + power(y, 2);
                   IxIy = IxIy + x * y;
               end
           end
           % building the M matrix
           M = [I2x, IxIy; IxIy, I2y];
           % finding the cornerness and roundness
           W(yCenter, xCenter) = trace(M) / 2 - sqrt(power(trace(M)/2, 2) - det(M));
           Q(yCenter, xCenter) = 4 * det(M) / power(trace(M), 2);
       end
    end
    imshow(Q);
end
