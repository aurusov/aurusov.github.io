function ddk_selectY(im, id)
%   Функция выделения глаз из изображения лица, его деталей и параметров. 
% Функция принимает рабочее изображение лица, с которым будет идти работа,
% эталонный образ, по которому будет выделяться нужная цасть лица
% для дальнейшей работы с ней и минимальный коэффициетн корреляции.
% На выходе матрица выделенной части изображения.
[N, M] = size(im);
[n, m] = size(id);
Im = ddk_edge(im);
Id = ddk_edge(id);

D = ddk_invD(Id);

x = 0; y = 0; p = 0; k = 0; k0 = 0.5;
Temp = zeros(50, 3);

for i = 1 : 2 : (N - n) % сдвиг на 4 пикселя при сканировнии по вертикали
    for j = 1 : 2 : (M - m) % аналогично выше написанному 
        s = Im(i : (i - 1 + n), j : (j - 1 + m));
        Dtemp = ddk_invD(s);
        temp = corr2(D, Dtemp);
        %s = histeq(s);
        %temp = corr2(Id, s);
        %temp = ddk_korfaz(id, s);
        if temp > k
            k = temp;
            x = i; y = j;
            if temp > k0 
                temp
                p = p + 1;
                Temp(p, 1 : 3) = [x + n/2, y + m/2 + 11, temp];
            end
        end       
    end
end
k
clear s;
I = im(x : (x - 1 + n), y : (y - 1 + m));

Mask = zeros(N, M);
%x = x + n/2 - 0.5;
%y = y + m/2;
%Mask((x - 3):(x + 3), y) = [1 1 1 1 1 1 1];
%Mask(x, (y - 3):(y + 3)) = [1; 1; 1; 1; 1; 1; 1];
for i = 1 : p
    t1 = Temp(i, 1);
    t2 = Temp(i, 2);
    if (t1 > 0) & (t2 > 0)
       Mask((t1 - 3):(t1 + 3), t2) = [1 1 1 1 1 1 1];
       Mask(t1, (t2 - 3):(t2 + 3)) = [1; 1; 1; 1; 1; 1; 1];
    end
end
clear Temp;

% Наложение матрицы расположения max центров рамки с исходником
imwrite(Mask, 'Plus_eye.tif');
Mask = imread('Plus_eye.tif');
P = imadd(im, Mask);
clear Mask;
imwrite(P, 'Plus_eye.tif');

figure;
subplot(2, 2, 1); imshow(im); title('Изображение');
subplot(2, 2, 2); imshow(id); title('Эталон');
subplot(2, 2, 3); imshow(P); title('Macка');
subplot(2, 2, 4); imshow(I); title('Result');