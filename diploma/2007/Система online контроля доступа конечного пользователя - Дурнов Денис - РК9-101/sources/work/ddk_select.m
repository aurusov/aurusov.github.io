function ddk_select(im, id, k0)
%   Функция выделения изображения лица, его деталей и параметров. 
% Функция принимает рабочее изображение лица, с которым будет идти работа,
% эталонный образ, по которому будет выделяться нужная цасть лица
% для дальнейшей работы с ней и минимальный коэффициетн корреляции.
% На выходе матрица выделенной части изображения.
[N, M] = size(im);
[n, m] = size(id);

Im = im; Id = id;
%Im = ddk_edge(im);
%Id = ddk_edge(id);

x = 0; y = 0; p = 0; k = 0;
Temp = zeros(10, 3);

for i = 1 : 3 : (N - n) % сдвиг на 3 пикселя при сканировнии по вертикали
    for j = 1 : 3 : (M - m) % аналогично выше написанному 
        S = Im(i : (i - 1 + n), j : (j - 1 + m));
        temp = corr2(Id, S);
        %temp = ddk_korfaz(Id, S);
        
        if temp > k
            k = temp;
            x = i; y = j;
            
            if temp > k0 
                p = p + 1;
                Temp(p, 1 : 3) = [x + n/2, y + m/2, temp];
            end
            
        end       
        
    end
end

clear S;
Ic = Im(x : (x - 1 + n), y : (y - 1 + m));
clear Im;
I = im(x : (x - 1 + n), y : (y - 1 + m));
k
Mask = zeros(N, M);

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
imwrite(Mask, 'Plus.tif');
Mask = imread('Plus.tif');
P = imadd(im, Mask);
clear Mask;
imwrite(P, 'Plus.tif');
imwrite(I, 'Result.tif');

figure;
subplot(2, 3, 1); imshow(im); title('Изображение');
subplot(2, 3, 2); imshow(id); title('Эталон');
subplot(2, 3, 3); imshow(I); title('Result');
subplot(2, 3, 4); imshow(P); title('Macка');
subplot(2, 3, 5); imshow(Id); title('Эталон-Canny');
subplot(2, 3, 6); imshow(Ic); title('Result-Canny');