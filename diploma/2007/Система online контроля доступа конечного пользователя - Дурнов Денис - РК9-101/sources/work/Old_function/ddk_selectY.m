function I = ddk_selectY(im, id, k0)
%   Функция выделения глаз из изображения лица, его деталей и параметров. 
% Функция принимает рабочее изображение лица, с которым будет идти работа,
% эталонный образ, по которому будет выделяться нужная цасть лица
% для дальнейшей работы с ней и минимальный коэффициетн корреляции.
% На выходе матрица выделенной части изображения.
[N, M] = size(im);
[n, m] = size(id);

x = 0; y = 0; p = 0; k = 0;
Temp = zeros(20, 3);

for i = 1 : 2 : (N - n) % сдвиг на 3 пикселя при сканировнии по вертикали
    for j = 1 : 2 : (M - m) % аналогично выше написанному 
        s = im(i : (i - 1 + n), j : (j - 1 + m));
        S = adapthisteq(s);
        temp = ddk_korfaz(id, S);
        if temp > k
            k = temp;
            x = i; y = j;
            if temp > k0 
                p = p + 1;
                Temp(p, 1 : 3) = [x + n/2 - 0.5, y + m/2, temp];
            end
        end       
    end
end
k
clear S s;
I = im(x : (x - 1 + n), y : (y - 1 + m));

Mask = zeros(N, M);
for i = 1 : p
    t1 = Temp(i, 1);
    t2 = Temp(i, 2);
    if (t1 > 0) & (t2 > 0)
     Mask((t1 - 3):(t1 + 3), t2) = [1 1 1 1 1 1 1];
     Mask(t1, (t2 - 3):(t2 + 3)) = [1; 1; 1; 1; 1; 1; 1];
     %Mask(t1, t2) = 1;
    end
end
clear Temp;

% Наложение матрицы расположения max центров рамки с исходником
imwrite(Mask, 'Plus.tif');
Mask = imread('Plus.tif');
P = imadd(im, Mask);
clear Mask;
imwrite(P, 'Plus.tif');

figure;
subplot(2, 2, 1); imshow(im); title('Изображение');
subplot(2, 2, 2); imshow(id); title('Эталон');
subplot(2, 2, 3); imshow(P); title('Macка');
subplot(2, 2, 4); imshow(I); title('Result');