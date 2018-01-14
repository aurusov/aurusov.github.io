%function I1 = ddk_grad(Im)
function I1 = ddk_grad(filename)
% Функция вычисления значения градиента. Принимает имя изображения образа
%                           [06.10.2006]
Im = imread(filename);
%A = size(im);
%A(1) = round(A(1)*0.6);

%A(2) = round(A(2)*1.7);

%Im = imresize(im, A, 'bicubic');

hy = fspecial('sobel');
hx = hy';

Iy = imfilter(double(Im), hy, 'replicate');
Ix = imfilter(double(Im), hx, 'replicate');
I = sqrt(Ix.^2+Iy.^2);
I1 = uint8(I);
imwrite(I1, '_temp.tif');

%figure, imshow(I,[]), title('Значение градиента');
figure, imshow(I1,[]), title('Градиент uint8');
%figure, surf(double(I1)), shading flat;
%figure, surf(I), shading flat;