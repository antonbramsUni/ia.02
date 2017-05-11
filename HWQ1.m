
function HWQ1()
    clc; home;
    close all hidden

    Img = imread('input_exercise2.png');
    I = (uint8(mean(Img, 3)));
    K = mat2gray(I);

    radius = 1;
    guassfilter(radius, K)
end

