function [I_face, x_real, y_real] = ddk_faceE(filename, factor, limit)
% Функция выделения лица изображения методом сканирования и наложения
% окружности, размер которой зависит от размера изображения.
% filename - файл, содержащий обрабатываемое изображение сцены;
% factor - коэффициент построения окружности;
% factor = [2, 2.2, 1.8]
% limit - пороговый коэффициет, характеризующий удачное выделение.
id      = imread('Fnew.tif');
I       = imread(filename);
k       = 0.6; % коэффициен масштабирования
% Перемасштабирование контурного изображения - придание "округлости" лицу
A       = size(I);
A(1)    = round(A(1)*k);
I_m     = imresize(I, A, 'bicubic');
I_em    = edge(I_m, 'canny'); % контур исходного изображения
[n, m]  = size(I_em);
%clear I_m

% Создаем бинарное изображение окружности
nn      = round(m/factor);
I_cir   = ddk_cir(nn);
[N, M]  = size(I_cir);
% Создаем "нулевую" матрицу центров
Cent    = zeros(n, m);

for i = 1 : (n - N)
    for j = 1 : (m - M)
        I_temp = imcrop(I_em, [j i (N - 1) (M - 1)]);
        I_mul = immultiply(I_temp, I_cir);
        temp = corr2(I_cir, I_mul);
        [i j temp]
        Cent(i + round(N/2) - 1, j + round(M/2) - 1) = temp;
    end
end
clear I_temp I_add
%CentCrop = imcrop(Cent, [nn nn (i + nn - 1) (j + nn - 1)]);

% Визуализация коэффициентов подобия матрицы центров по пикселям
nn = round(nn/2);
CentCrop = Cent(nn : (i + nn - 1), nn  : (j + nn - 1));

%figure, surf(CentCrop), shading flat;

CentCrop = mat2gray(CentCrop);
%figure, surf(CentCrop), shading flat;
Cent = mat2gray(Cent);
Cent(nn : (i + nn - 1), nn  : (j + nn - 1)) = CentCrop;
imwrite(Cent, 'cent.tif');
figure
subplot(2, 1, 1); imshow(I_em); title('Scale-Edge Image');
subplot(2, 1, 2); imshow(Cent); title('Corr2 Center');

% Обработка матрицы коэффициентов локальной матрицей 7х7
%[nc, mc] = size(Cent);
%summa = 0;
%for i = 1 : (nc - 6)
%    for j = 1 : (mc - 6)
%        step    = Cent(i : (i + 6), j : (j + 6));
%        SumStep = sum(step);
%        SumStep = sum(SumStep'); % сумма элементов локальной матрицы
%        if SumStep > summa
%            xmax = j + 3;
%            ymax = i + 3;
%            summa = SumStep;
%        end
%    end
%end

% Находим max и min элемент полученно матрицы центров Cent
[maxx, y] = max(Cent); 
[cent_max, xmax] = max(maxx'); % нашли cent_max
ymax = y(xmax); % xmax и ymax координаты максимального элемента

% Визуализация положения центра и положения выделенной окружности.
Temp    = [ymax, xmax];
I_c     = ddk_cent(I_m, Temp, '_temp.tif');
x       = xmax - round(M/2) + 1;
y       = ymax - round(N/2) + 1;

I_temp  = imcrop(I_em, [x y (N - 1) (M - 1)]);
I_mul   = immultiply(I_temp, I_cir);
corr    = corr2(I_cir, I_mul);

[y, x, corr]

if (corr < limit) & (factor == 2)
    I_fase = ddk_faceE(filename, 1.8, limit);
elseif (corr < limit) & (factor == 1.8)
    I_fase = ddk_faceE(filename, 2.2, limit);
else
    im_temp = imcrop(I_m, [x y (M - 1) (N - 1)]);
    I_cir = mat2gray(I_cir);
    imwrite(I_cir, '_temp.tif');
    I_cir   = imread('_temp.tif');
    im_temp = imsubtract(im_temp, I_cir);
    I_c(y : (y + N - 1), x : (x + M -1)) = im_temp;
    clear im_temp
% Получение результирующего изображения образа лица.
    %x_real = x + 10;
    %y_real = round(y / k) + 50;
    x_real = x;
    y_real = round(y / k) + 30;
    [N, M] = size(I);
    while (x_real + 110 > M) x_real = x_real - 1; end
    while (y_real + 160 > N) y_real = y_real - 1; end
% Отрисовка рамки выделенного образа лица
    I_fr = ddk_frame(I, id, x_real, y_real);
    I_face = imcrop(I, [x_real y_real (110 - 1) (160 - 1)]);
    imwrite(I_face, 'face.tif');

    figure 
    subplot(2, 2, 1); imshow(I);        title('Изображение');
    subplot(2, 2, 2); imshow(I_c);      title('Result circule');
    subplot(2, 2, 3); imshow(I_fr);     title('Рамка выделки');
    subplot(2, 2, 4); imshow(I_face);   title('Выделенный образ');
end    