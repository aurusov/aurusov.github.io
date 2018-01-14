function frame = ddk_facecorr(filename)
% Функция выделения лица изображения методом корреляционного сопоставления
% изображения сцены с эталоном образа лица.
% filename - файл, содержащий обрабатываемое изображение сцены;
% Дурнов Д.К. 10 семестр [07.05.2007]

id  = imread('Fmid.tif');
im  = imread(filename);
[N, M] = size(im);
[n, m] = size(id);

% Переводим изображения к их градиентам
idgr = ddk_grad(id);
imgr = ddk_grad(im);

% Реализация алгоритма корреляции в частотной области
imcorr = ddk_corr(imgr, idgr);
%imcorr = ddk_corr(im, id);
[y, x] = find(imcorr == max(imcorr(:))) % положение нижнего левого угла
% Визуализация результата корреляции
frame = ddk_frame(im, id, (x - m), (y - n));
