function Ia = ddk_comp1(filename)
% Функция сравнения методов улучшения изображений, предоставленных средсвтвами MATLAB 7.
% Изображение должно быть представленно в формате *.tif. Функция получает
% начальным параметром имя изображения (оно должно находиться в главном
% корневом каталоге). 
%         Дурнов Денис 13.05.2006 14:00
I = imread(filename);
B = edge(I, 'canny');
Ih = histeq(I);
Bh = edge(Ih, 'canny');
Ii = imadjust(I, stretchlim(I), []);
Bi = edge(Ii, 'canny');
Ia = adapthisteq(I);
Ba = edge(Ia, 'canny');
figure;
subplot(4, 4, 1); imshow(I); title('original');
subplot(4, 4, 2); imhist(I); title('histogram');
subplot(4, 4, 3); ddk_histequal(I); title('Equalization');
subplot(4, 4, 4); imshow(B); title('edge by Canny');
subplot(4, 4, 5); imshow(Ih); title('histeq');
subplot(4, 4, 6); imhist(Ih); title('histogram');
subplot(4, 4, 7); ddk_histequal(Ih); title('Equalization');
subplot(4, 4, 8); imshow(Bh); title('edge by Canny');
subplot(4, 4, 9); imshow(Ii); title('imadjust');
subplot(4, 4, 10); imhist(Ii); title('histogram');
subplot(4, 4, 11); ddk_histequal(Ii); title('Equalization');
subplot(4, 4, 12); imshow(Bi); title('edge by Canny');
subplot(4, 4, 13); imshow(Ia); title('adapthisteq');
subplot(4, 4, 14); imhist(Ia); title('histogram');
subplot(4, 4, 15); ddk_histequal(Ia); title('Equalization');
subplot(4, 4, 16); imshow(Ba); title('edge by Canny');
