function I1 = ddk_grad(Im)
% Функция вычисления значения градиента. [06.10.2006]

%A   = size(im);
%A(1) = round(A(1)*0.9);
%A(2) = round(A(2)*1.7);
%Im  = imresize(im, A, 'bicubic');

hy  = fspecial('sobel');
hx  = hy';

Iy  = imfilter(double(Im), hy, 'replicate');
Ix  = imfilter(double(Im), hx, 'replicate');
I   = sqrt(Ix.^2+Iy.^2);
[n, m] = size(I);

if (n < 50) & (m < 50)
    I1  = mat2gray(I);
else
    I1  = uint8(I);
end

imwrite(I1, '_temp.tif');
%figure, imshow(I,[]), title('Значение градиента');
%figure, imshow(I1,[]), title('Градиент');
%figure, surf(double(I1)), shading flat;
%figure, surf(I), shading flat;