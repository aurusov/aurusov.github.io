function Frame = ddk_frame(im, id, x, y)
% Фукция отрисовки рамки с черными гранями выделенной части изображения.
%                          [02.10.2006]

[N, M] = size(im);
[n, m] = size(id);

mask = zeros(N, M);

for i = 0 : (n - 1)
    mask(y + i, x) = [1];
    mask(y + i, x + m -1) = [1];
end

for i = 1 : (m - 2)
    mask(y, x + i) = [1];
    mask(y + n - 1, x + i) = [1];
end

imwrite(mask, '_frame.tif');
mask = imread('_frame.tif');
Frame = imsubtract(im, mask);
clear Mask;
imwrite(Frame, '_frame.tif');