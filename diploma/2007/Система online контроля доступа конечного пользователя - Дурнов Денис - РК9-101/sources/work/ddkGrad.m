function ddkGrad(Im)
% Функция вычисления значения градиента. Принимает имя изображения образа
%                         Дурнов Д.К.[07.05.2007]
hy = fspecial('sobel');
hx = hy';

Iy = imfilter(double(Im), hy, 'replicate');
Ix = imfilter(double(Im), hx, 'replicate');
Ig = sqrt(Ix.^2+Iy.^2);

Ix = gscale(Ix);
Iy = gscale(Iy);
Ig = gscale(Ig);

% Визуализация
subplot(2, 2, 1); subimage(Im); title('Image');
subplot(2, 2, 2); subimage(Ig); title('Ix + Iy');
subplot(2, 2, 3); subimage(Ix); title('Ix');
subplot(2, 2, 4); subimage(Iy); title('Iy');