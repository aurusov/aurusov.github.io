function Frame = ddk_frame(im, id, x, y)
% Фукция отрисовки рамки с черными гранями выделенной части изображения.
%                          [02.10.2006]

[N, M] = size(im);
[n, m] = size(id);

mask = zeros(N, M);

for i = 0 : (n - 1)
    mask(x + i, y) = [1];
    mask(x + i, y + m -1) = [1];
end

for i = 1 : (m - 2)
    mask(x, y + i) = [1];
    mask(x + n - 1, y + i) = [1];
end

imwrite(mask, '_frame.tif');
mask = imread('_frame.tif');
Frame = imsubtract(im, mask);
clear Mask;
imwrite(Frame, '_frame.tif');