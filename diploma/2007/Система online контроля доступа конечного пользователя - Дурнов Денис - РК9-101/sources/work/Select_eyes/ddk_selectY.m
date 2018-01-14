function ddk_selectY(im, id, k0)
%   Функция выделения глаз из изображения лица, его деталей и параметров. 
% Функция принимает рабочее изображение лица, с которым будет идти работа,
% эталонный образ, по которому будет выделяться нужная цасть лица
% для дальнейшей работы с ней и минимальный коэффициетн корреляции.
% На выходе матрица выделенной части изображения.

im = imresize(im, 1.6, 'bicubic');
id = imresize(id, 1.6, 'bicubic');

[N, M] = size(im);
[n, m] = size(id);
%Im = ddk_edge(im);
%Id = ddk_edge(id);

x = 0; y = 0; p = 0; k = 0; %k0 = 0.5;
Temp = zeros(30, 3);

for i = 1 : (N - n + 1) % сдвиг на 2 пикселя при сканировнии по вертикали
    for j = 1 : (M - m + 1) % аналогично выше написанному 
        s = im(i : (i -1 + n), j : (j - 1 + m));
        Ss = histeq(s);
        temp = corr2(id, Ss);
        %temp = ddk_korfaz(id, s);
        if temp > k
            k = temp;
            x = i; y = j;
            if temp > k0 
                p = p + 1;
               %Temp(p, 1 : 3) = [x + round(n/2) + 5, y + round(m/2), temp];
                Temp(p, 1 : 3) = [x + round(n/2), y + round(m/2), temp];
            end
        end       
    end
end
k
clear s;

I = im(x : (x - 1 + n), y : (y - 1 + m));
imwrite(I, '_res_sel.tif'); % Сохранение полученной выделки.

% Наложение матрицы расположения max центров рамки на исходник.
Cent = ddk_cent(im, Temp, '_cent_selY.tif');
clear Temp;

% Визуализация результата в виде выделенной рамки на рабочем изображении.
Frame = ddk_frame(im, id, x, y);

figure;
subplot(1, 3, 1); imshow(im); title('Изображение');
subplot(1, 3, 2); imshow(Cent); title('Macка центров');
subplot(1, 3, 3); imshow(Frame); title('Result');
%subplot(2, 2, 4); imshow(I); title('Result');