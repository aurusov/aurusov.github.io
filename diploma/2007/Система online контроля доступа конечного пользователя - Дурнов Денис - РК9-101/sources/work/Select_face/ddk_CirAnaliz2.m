%function [k_max, xmax, ymax] = ddk_CirAnaliz2(Im, factor, angle)
function ddk_CirAnaliz2(Im, factor, angle)
% Im  - базовое изображение сцены;
% factor = [1.8; 2; 2.2] - коэффициент построения окружности;
% angle - углы поворота базового изображения;
%           Дурнов Д.К. [14.05.2007]
%-------------------------------------------------------------------------%
if (factor ~= 2) & (factor ~= 1.8) & (factor ~= 2.2)
    error('Incorretc value of "factor": its must be 1.8, 2 or 2.2.')
end

% Требуемый поворот контурного изображения сцены
ImEdge1 = imrotate(Im, angle, 'bicubic', 'crop');
ImEdge2 = imrotate(Im, -angle, 'bicubic', 'crop');

% Перемасштабирование контурного изображения - придание "округлости" лицу
k    = 0.6; % коэффициент масштабирования
A    = size(Im);
A(1) = round(A(1) * k);

ImSc0 = imresize(Im, A, 'bicubic');
ImSc1 = imresize(ImEdge1, A, 'bicubic');
ImSc2 = imresize(ImEdge2, A, 'bicubic');

ImScale = {ImSc0, ImSc1, ImSc2}; 
%----------------Выделение контура изображения сцены-----------------------
Ig0 = ddk_grad(ImSc0);
Ig1 = ddk_grad(ImSc1);
Ig2 = ddk_grad(ImSc2);

% Бинаризация градиента яркости
ImEdge = {im2bw(Ig0, 0.9), im2bw(Ig1, 0.9), im2bw(Ig2, 0.9)};
clear Ig0 Ig1 Ig2

%ImEdge = {edge(ImSc0, 'canny'), edge(ImSc1, 'canny'), edge(ImSc2, 'canny')};
%--------------------------------------------------------------------------
[n, m]  = size(ImEdge{1});
Cent    = {zeros(n, m), zeros(n, m), zeros(n, m)}; % матрицы центров
% Создаем бинарное изображение окружности
nn      = round(m/factor);
I_cir   = ddk_cir(nn);
[N, M]  = size(I_cir);

% Обрабатываем контурные изображения полученной окружностью
for i = 1 : (n - N)
    for j = 1 : (m - M)
        for tmp = 1 : 3
            I_tmp = imcrop(ImEdge{tmp}, [j i (M - 1) (N - 1)]);
            %I_mul = im2bw(I_tmp + I_cir, 0.5);
            I_mul = immultiply(I_tmp, I_cir);
            temp = corr2(I_cir, I_mul);
            %[i j temp]
            Cent{tmp}(i + round(N/2) - 1, j + round(M/2) - 1) = temp;
        end
    end
end
    
clear I_tmp I_mul  

% Визуализация коэффициентов подобия матрицы центров по пикселям
figure;
subplot(2, 3, 1); imshow(ImEdge{1}); title('Image scaled');
subplot(2, 3, 2); imshow(ImEdge{2}); title('Image scaled');
subplot(2, 3, 3); imshow(ImEdge{3}); title('Image scaled');
subplot(2, 3, 4); imshow(Cent{1}); title('0 angle');
subplot(2, 3, 5); imshow(Cent{2}); title('+ angle');
subplot(2, 3, 6); imshow(Cent{3}); title('- angle');

% Обрабатываем полученные результаты - 3 матрицы центров
% Обработка матрицы коэффициентов локальной матрицей 3х3
[nc, mc] = size(Cent{1});
k_max   = 0;
numb    = 0; % номер матрицы с максимальным коэффициентом

for i = 1 : (nc - 2)
    for j = 1 : (mc - 2)
        for tmp = 1 : 3
            step    = Cent{tmp}(i : (i + 2), j : (j + 2));
            MeanTmp = mean2(step); % среднее значение элементов матрицы

            if MeanTmp > k_max
                xmax    = j + 1;
                ymax    = i + 1;
                k_max   = MeanTmp;
                numb    = tmp;
            end
        
        end
    end
end

%for tmp = 1 : 3
%    [maxx, y] = max(Cent{tmp}); 
%    [cent_max, x] = max(maxx'); % нашли cent_max
%    cent_max
%    
%    if cent_max > k_max
%        k_max   = cent_max;
%        numb    = tmp;
%        xmax    = x;
%        ymax    = y(xmax); % xmax и ymax координаты максимального элемента
%    end
%    
%end    

% Визуализация положения центра и положения выделенной окружности.
Temp    = [ymax, xmax];
ImCent  = ddk_cent(ImScale{numb}, Temp, '_temp.tif');

nn      = round(m/factor);
ImCir   = gscale(ddk_cir(nn));
[N, M]  = size(ImCir);

x       = xmax - round(M/2) + 1;
y       = ymax - round(N/2) + 1;
im_temp = imcrop(ImCent, [x y (M - 1) (N - 1)]);
im_temp = imsubtract(im_temp, ImCir);
ImCent(y : (y + N - 1), x : (x + M -1)) = im_temp;

figure
imshow(ImCent);
clear im_temp ImCir

% Производим пересчет координат
if numb ~= 1
    T = [cos(-angle) sin(-angle) 0; -sin(-angle) cos(-angle) 0; 0 0 1];
    tform   = maketform('affine', T);
    % выполняем обратное аффинное преобразование
    [xmax ymax] = tforminv([x y], tform);
    xmax = round(xmax); 
    ymax = round(ymax/k); % делаем поправку координат по масштабированию
end

numb
k_max
%xmax
%ymax