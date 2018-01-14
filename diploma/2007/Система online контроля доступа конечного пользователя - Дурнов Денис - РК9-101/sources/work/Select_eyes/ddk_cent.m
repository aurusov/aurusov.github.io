function Pic = ddk_cent(im, Temp, filename)
% Функция отрисовки центров в виде крестиков, координаты которых хранятся в
% массиве Temp. Функция также сохраняет изображение с наложенной маской
% центрови выдает массив этого изображения для последующей визуализации
% результа работы основной программы.
%                   [02.10.2006]

[N, M] = size(im);
[n, m] = size(Temp);

Mask = zeros(N, M);
%A = [0 0 0];
% Temp(p, 1 : 3) = [x + n/2, y + m/2 + 10, temp];

for i = 1 : n
    t1 = Temp(i, 1);
    t2 = Temp(i, 2);
    if (t1 > 0) & (t2 > 0)
       %A= [A; Temp(i, 1 : 3)];
       Mask((t1 - 3):(t1 + 3), t2) = [1 1 1 1 1 1 1];
       Mask(t1, (t2 - 3):(t2 + 3)) = [1; 1; 1; 1; 1; 1; 1];
    end
end

imwrite(Mask, filename);
Mask = imread(filename);
Pic = imadd(im, Mask);
clear Mask;
imwrite(Pic, filename);