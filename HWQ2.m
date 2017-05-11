
function HWQ2()
    % housekeeping
    clc; home;
    close all hidden
    % prepare Image
    Img = imread('input_exercise2.png');
    I = (uint8(mean(Img, 3)));
    K = mat2gray(I);
    % get/set props
    radius = 2;
    structSize = radius * 2 + 1;
    [out, ix, iy] = guassfilter(2, K);
    [imgYSize, imgXSize]= size(out);
    % create cornerness and roundness matrices
    W = [];
    Q = [];
    WQMc = [];
    % iterate through image
    for yCenter = 1 + radius:imgYSize - radius
       for xCenter = 1 + radius:imgXSize - radius
           % temp values
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
           wValue = trace(M) / 2 - sqrt(power(trace(M)/2, 2) - det(M));
           zeroCheck = power(trace(M), 2);
           qValue = 0;
           if (zeroCheck > 0) qValue = 4 * det(M) / zeroCheck; end
           McValue = 0;
           if (wValue > 0.0004) && (qValue > 0.5) McValue = 1; end
           W(yCenter, xCenter) = wValue;
           Q(yCenter, xCenter) = qValue;
           WQMc(yCenter, xCenter) = wValue * McValue + qValue * McValue;
       end
    end
    
    % output roundness and cornerness
    subplot(1,4,1); imshow(Q); title('roundness');
    subplot(1,4,2); imshow(W); title('cornerness');
    % Set Colors
    % colormap(jet);
    % regional Max
    regionalMax = imregionalmax(WQMc);
    subplot(1,4,3); imshow(regionalMax); title('regionalMax');
end
