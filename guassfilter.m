
function [out, ix, iy] = guassfilter(radius, Image)
    structSize = radius * 2 + 1;
    hsize=[structSize structSize];
    sigma=.5;
    [imgYSize, imgXSize]= size(Image);

    g=fspecial('gaussian',hsize,sigma);
    [hStructure, vStructure]=gradient(g);

    out = [];
    ix = [];
    iy = [];
    for yCenter = 1+radius:imgYSize-radius
       for xCenter = 1+radius:imgXSize-radius
           h = 0;
           v = 0;
           % iterate structure
           for yStr = 1:structSize
               for xStr = 1:structSize
                   % convert struct coordinates to image coordinates
                   yProjected = yCenter + yStr - radius - 1;
                   xProjected = xCenter + xStr - radius - 1;
                   h = h + hStructure(yStr, xStr) * Image(yProjected, xProjected);
                   v = v + vStructure(yStr, xStr) * Image(yProjected, xProjected);
               end
           end
           out(yCenter, xCenter) = sqrt(power(h, 2)+power(v, 2));
           ix(yCenter, xCenter) = h;
           iy(yCenter, xCenter) = v;     
       end
    end
%     subplot(1,3,1), imshow(out);
%     subplot(1,3,2), imshow(ix);
%     subplot(1,3,3), imshow(iy);
    % plot(out)
end


