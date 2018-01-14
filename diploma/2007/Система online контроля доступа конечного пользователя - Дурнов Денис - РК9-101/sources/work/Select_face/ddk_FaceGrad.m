function [ImFace, x, y] = ddk_FaceGrad(Im, Id, k0)
% Функция первоначального обнаружения образа лица на изображении сцены
% путем перевода изображений в их градиенты и последущей работы с ними.
% ImFace - выделенный образ лица;
% <х> и <у> - координаты левого верхнего угла рамки образа лица;
% Im - матрица изображения сцены;
% Id - матрица эталона, по которому будет искаться признаки лица;
%           Дурнов Д.К. [18.05.2007]
im = ddk_grad(Im);
id = ddk_grad(Id);

[N, M]  = size(im);
[n, m]  = size(id);

x = 0; y = 0; p = 0; k = 0;
%Temp = zeros(10, 3);

% Обрабатываем градиент сцены изобаржения
for i = 1 : 3 : (N - n)
    for j = 1 : 3 : (M - m)
        I_tmp = imcrop(im, [j i (m - 1) (n - 1)]);
        temp = corr2(I_tmp, id);
        %temp = ddk_CorrFaz(I_tmp, id);
        
        if temp > k
            k = temp;
            x = j; y = i;
            
            if temp > k0 
                p = p + 1;
                Temp(p, 1 : 3) = [y + round(n/2), x + round(m/2), temp];
            end
            
        end
        
    end
end
       
k
p
% иллюстрация положения max центоров рамки
Cent    = ddk_cent(im, Temp, 'Plus.tif');
%Cent    = ddk_cent(Im, Temp, 'Plus.tif');
% иллюстрация положения выделенного образа, заключенного в рамку
Frame   = ddk_frame(Im, id, x, y);
%Frame   = ddk_frame(im, id, x, y);

% выделение найденного образа лица из изображения сцены
ImFace = imcrop(Im, [x y (m - 1) (n - 1)]);


figure;
subplot(2, 2, 1); imshow(im); title('Градиент сцены');
subplot(2, 2, 2); imshow(id); title('Эталон');
subplot(2, 2, 3); imshow(Cent); title('Cent');
subplot(2, 2, 4); imshow(Frame); title('Результат');            