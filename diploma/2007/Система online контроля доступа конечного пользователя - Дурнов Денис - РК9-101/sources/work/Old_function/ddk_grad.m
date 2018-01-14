function Ix = ddk_grad(Im)
% Функция вычисления поля градиентов входного изображения.
h = fspecial('sobel');
ix = filter2(h, Im);
Ix = mat2gray(ix);
clear ix;

ht = h';
iy = filter2(ht, Im);
Iy = mat2gray(iy);
clear iy;

I = Ix + Iy;

subplot(2, 2, 1); subimage(Im); title('Image');
subplot(2, 2, 2); subimage(I); title('Ix + Iy');
subplot(2, 2, 3); subimage(Ix); title('Ix');
subplot(2, 2, 4); subimage(Iy); title('Iy');