function ddk_eyes(im)
%function ddk_eyes(im, id1, id2, id2n)
% Функция, которая находит центры глаз на рабочем изображении.
% im - рабочее изображение;
% id1 и id2 - эталон средней части лица и правого глаза соответственно.
%                   [03.10.2006]

id1 = imread('Middle.tif');
id2 = imread('ERnn.tif');
id2n = imread('ELnn.tif');
[N, M] = size(id2); % Первоначальные размеры эталона глаза.

% Процедура выделения средней части лица.
O1 = 0; O2 = 0; O3 = 0;
[im1, O1, k1] = ddk_sel_frame(im, id1, 0);
frame = imread('_frame.tif');

figure;
subplot(2, 2, 1); imshow(im); title('Изображение');
subplot(2, 2, 2); imshow(frame); title('Первый шаг');
clear frame;

% Увеличение размера выделенной средней части лица и эталона глаза.
im1 = imresize(im1, 1.6, 'bicubic'); % средняя часть лица
id2 = imresize(id2, 1.6, 'bicubic'); % эталон правого глаза
id2n = imresize(id2n, 1.6, 'bicubic'); % эталон левого глаза

% Процедура выделения первого (правого) глаза.
[im2, O2, k2] = ddk_sel_frame(im1, id2, 1);

frame = imread('_frame.tif');
subplot(2, 2, 3); imshow(frame); title('Второй шаг');
clear frame;

% Вырезаем выделеннй глаз из изображения средней части лица для более
% корректного последующего выделения левого глаза.
%[nn, mm] = size(im1); [n, m] = size(im2);
%[x, y] = O2;
%Im21 = zeros(nn, mm);
%Im22 = ones(n, m);

%for i = 1 : n
%    for j = 1 : m
%        %Im2(x + i - 1, y + j - 1) = im2(i, j);
%        Im21(O2(1) + i - 1, O2(2) + j - 1) = Im22(i, j);
%    end
%end

%imwrite(Im21, '_frame.tif');
%Im21 = imread('_frame.tif');
%im1 = imadd(im1, Im21);
%clear Im21 Im22;

% Процедура выделения второго (левого) глаза
[im2, O3, k3] = ddk_sel_frame(im1, id2n, 2);

frame = imread('_frame.tif');
subplot(2, 2, 4); imshow(frame); title('Третий шаг');
clear frame im2;

% Приведение координат найденных центров.
O2 = round(O2/1.6); O3 = round(O3/1.6);
O2(1) = O1(1) + O2(1) + round(N/2) + 5;
O2(2) = O1(2) + O2(2) + round(M/2);
O3(1) = O1(1) + O3(1) + round(N/2) + 5;
O3(2) = O1(2) + O3(2) + round(M/2);
% Создается массив координат для отрисовки центров.
Temp(1, 1 : 3) = [O2 k2];
Temp(2, 1 : 3) = [O3 k3];
Temp

% Отрисовка найденных центров глаз на основном изображении лица.
Pic = ddk_cent(im, Temp, 'Cent_eye.tif');
figure; imshow(Pic);