%function Ig1 = ddk_grad(Im)
function Ig_unit8 = ddk_grad(Im)
%function Ig = ddk_grad(Im)
%function ddk_grad(Im)
% Функция вычисления значения градиента. Принимает имя изображения образа
%                         Дурнов Д.К.[07.05.2007]
hy = fspecial('sobel');
hx = hy';

Iy = imfilter(double(Im), hy, 'replicate');
Ix = imfilter(double(Im), hx, 'replicate');
Ig = sqrt(Ix.^2+Iy.^2);

Ig_unit8 = gscale(Ig);
%Ig1 = uint8(Ig);
%imwrite(Ig1, '_temp.tif');

%figure, imshow(Ig,[]), title('Значение градиента');
%figure, imshow(Ig_unit8,[]), title('Градиент uint8');
%figure, imshow(Ig1,[]), title('Градиент uint8');
%figure, surf(double(I1)), shading flat;
%figure, surf(I), shading flat;