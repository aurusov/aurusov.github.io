function ddk_comp1(filename)
% Функция сравнения методов улучшения изображений, предоставляемых
% средствами MATLAB v.7
% Изображение должно быть представленно в формате *.tif. Функция получает
% начальным параметром имя изображения (оно должно находиться в главном
% корневом каталоге). 
I = imread(filename);
B = edge(I, 'canny');
Ih = histeq(I);
Bh = edge(Ih, 'canny');
Ii = imadjust(I, stretchlim(I), []);
Bi = edge(Ii, 'canny');
Ia = adapthisteq(I);
Ba = edge(Ia, 'canny');

% Визуализация
subplot(4, 3, 1); imshow(I); title('original');
subplot(4, 3, 2); ddk_histequal(I); title('Equalization');
subplot(4, 3, 3); imshow(B); title('edge by Canny');
subplot(4, 3, 4); imshow(Ih); title('histeq');
subplot(4, 3, 5); ddk_histequal(Ih); title('Equalization');
subplot(4, 3, 6); imshow(Bh); title('edge by Canny');
subplot(4, 3, 7); imshow(Ii); title('imadjust');
subplot(4, 3, 8); ddk_histequal(Ii); title('Equalization');
subplot(4, 3, 9); imshow(Bi); title('edge by Canny');
subplot(4, 3, 10); imshow(Ia); title('adapthisteq');
subplot(4, 3, 11); ddk_histequal(Ia); title('Equalization');
subplot(4, 3, 12); imshow(Ba); title('edge by Canny');
