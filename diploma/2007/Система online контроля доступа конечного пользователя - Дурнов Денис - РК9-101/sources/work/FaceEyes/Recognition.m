function Recognition(ImFace)
% Функция распознавания и верификация изображения лица.
% ImFace - выделенный образ лица функцией SelectGrad()
%                  Дурнов Д.К. [31.05.2007]
%-------------------------------------------------------------------------%
% составляем простейшую базу данных
Alexei   = imread('C:\MATLAB701\work\FaceEyes\DBF\AlexeiFace.tif');
Artem    = imread('C:\MATLAB701\work\FaceEyes\DBF\ArtemFace.tif');
Katerina = imread('C:\MATLAB701\work\FaceEyes\DBF\KaterinaFace.tif');
Olia     = imread('C:\MATLAB701\work\FaceEyes\DBF\OliaFace.tif');
Valentin = imread('C:\MATLAB701\work\FaceEyes\DBF\ValentinFace.tif');

DBF = {Alexei, Artem, Katerina, Olia, Valentin};
[n, m] = size(DBF); % размеры БД (количество образов)
%-------------------------------------------------------------------------%

ImConst = imcrop(ImFace, [8 50 90 68]); % средняя часть лица
ImConst = ddk_GradDouble(ImConst); % градиентное изображение
%{ImConst}

k  = 0;
i0 = 0;

% цикл верификация входного образа (по его средней части лица)
for i = 1 : m
    ImTemp = imcrop(DBF{i}, [8 50 90 68]); % текущий образ из БД
    ImTemp = ddk_GradDouble(ImTemp); % выделение градиента
    
    % определяем величину фазовой корреляции между образами
    kj = ddk_CorrFaz(ImConst, ImTemp);
    %kj = ddk_CorrFaz(double(ImConst), double(ImTemp))
    
    if kj > k
        k   = kj;
        i0  = i;
    end
    
end    

k
% Результаты процедуры распознавания и верификации
figure,
subplot(1, 2, 1); imshow(ImFace); title('К распознаванию');
subplot(1, 2, 2); imshow(DBF{i0}); title('Результат верификации');