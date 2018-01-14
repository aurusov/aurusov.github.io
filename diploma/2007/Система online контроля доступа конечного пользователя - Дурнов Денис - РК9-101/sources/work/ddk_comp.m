function ddk_comp(filename)

I = imread(filename);
Ih = adapthisteq(I);

subplot(2, 3, 1); imshow(I); title('Изображение');
subplot(2, 3, 2); imhist(I); title('Гистограмма');
subplot(2, 3, 3); ddk_histequal(I); title('Передаточная характеристика');
subplot(2, 3, 4); imshow(Ih); title('После обработки');
subplot(2, 3, 5); imhist(Ih); title('Гистограмма');
subplot(2, 3, 6); ddk_histequal(Ih); title('Передаточная характеристика');
imwrite(Ih, 'Done.tif');