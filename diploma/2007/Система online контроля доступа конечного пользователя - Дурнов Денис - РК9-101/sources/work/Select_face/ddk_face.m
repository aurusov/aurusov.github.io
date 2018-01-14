function ddk_face(filename)
% Функция выделения лица из изображения сцены с помощью бинаризации её
% градиента и последующим поиском центра лица.
I = imread(filename);
k = 1.7; % коэффициент масштабирования

% Выделение градиента изображения сцены.
hy = fspecial('sobel');
hx = hy';
Iy = imfilter(double(I), hy, 'replicate');
Ix = imfilter(double(I), hx, 'replicate');
Ig = sqrt(Ix.^2+Iy.^2); % Суммарный градиент
Ig = uint8(Ig);
%imwrite(I1, '_temp.tif');

% Бинаризация градиента яркости и его перемасштабирование.
bw      = im2bw(Ig, 0.9);
M       = size(bw);
M(2)    = round(M(2)*k);
bw_m    = imresize(bw, M, 'bicubic');
%imwrite(bw_m, '_temp.bmp');
%figure, surfc(double(bw_m)), shading flat;

[n, m] = size(bw_m);

circle = imread('R37.bmp'); % изображение с предполагаемым радиусом лица
[N, M] = size(circle);

A = zeros(N + n, M + m); % создаем "нулевую" матрицу центров

for i = 1 : n
    for j = 1 : m
        if (bw_m(i, j) == 1)
            %a = A((N/2 + i) : (N/2 + i + N - 1), (M/2 + j) : (M/2 + j + M - 1)) + circle;
            %A((N/2 + i) : (N/2 + i + N - 1), (M/2 + j) : (M/2 + j + M - 1)) = a;
            A_temp = A(i : (N + i -1), j : (M + j -1)) + circle;
            A(i : (N + i -1), j : (M + j -1)) = A_temp;
            clear A_temp
        end
    end
end

A_nm = A((N/2 + 1) : (N/2 + n), (M/2 + 1) : (M/2 + m));
%figure, surf(A_nm), shading flat;
%figure; meshc(A_nm);

% Представим полученную матрицу центров в виде полутонового изображения
A_max   = max(max(A_nm)'); % максимальный элемент матрицы центров
A_nm    = uint8(A_nm/(A_max/255));

figure
subplot(2, 3, 1); imshow(I); title('Оригинал');
subplot(2, 3, 2); imshow(Ig); title('Суммарный градиент');
subplot(2, 3, 3); imshow(bw); title('Бинаризация');
subplot(2, 3, 4); imshow(bw_m); title('Scale_binaring');
subplot(2, 3, 5); imshow(A_nm); title('Матрица центров');
subplot(2, 3, 6); meshc(A_nm);
%subplot(2, 3, 6); imshow(A_nm); title('Матрица центров');
%figure, imshow(Ig,[]), title('Градиент uint8');
%figure, surf(double(I1)), shading flat;
%figure, surf(I), shading flat;