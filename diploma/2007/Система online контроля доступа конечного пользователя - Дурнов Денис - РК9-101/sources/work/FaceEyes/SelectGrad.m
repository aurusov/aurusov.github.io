function SelectGrad(filename)
% Функция выделения лица из изображения сцены с представлением результата в
% виде, пригодном для выделения признаков лица.
%                  Дурнов Д.К. [24.05.2007]
Im      = imread(filename);
Im      = adapthisteq(Im); % улучшаем первоначальное изобаржение сцены
IIdFace = imread('Fnew.tif'); % эталон образа лица
IdFace  = imresize(IIdFace, 1.06, 'bicubic');
IdMid   = imread('Fmid.tif'); % эталон средней части лица
IdMid   = imresize(IdMid, 1.06, 'bicubic');
Rid = 48; % эталонное расстояние между глазами
%-------------------------------------------------------------------------%
% Выделям образ лица и запоминаем координаты левого края выделки.
[If, xi, yi] = ddk_FaceGrad(Im, IdFace, 0.08);
%If = imadjust(If, stretchlim(If), []);
If = adapthisteq(If);
% Выделям среднюю часть лица из полученного образа и --||--
[Imid, xi0, yi0] = ddk_FaceGrad(If, IdMid, 0.08);

% Получаем координаты расположения центров глаз.
%[xi1, yi1, xi2, yi2] = ddk_eyes(If, Imid, xi0, yi0);
[OR, OL] = ddk_eyes(If, Imid, xi0, yi0);
clear Imid If
% Координаты центров глаз в системе координат исходной сцены.
x1 = OR(1) + xi - 1;
y1 = OR(2) + yi - 1;
x2 = OL(1) + xi - 1;
y2 = OL(2) + yi - 1;

% Вычисляем угол наклона (в градусах) линии глаз относительно горизонтали.
phi = atan((y2 -y1)/(x2 - x1)) * 180/pi
% Определяем расстояние между найденными центрами глаз
R = round(sqrt((x2 - x1)^2 + (y2 - y1)^2))

% Координаты центра линии глаз до поворота: xc и yc
xc = round((x2 - x1)/2 + x1 - 1);

if y1 > y2
    yc = round((y1 - y2)/2 + y2 - 1);
else
    yc = round((y2 - y1)/2 + y1 - 1);
end

% Производим поворот начального изображения сцены на угол "phi"
%ImRot = imrotate(Im, phi, 'bicubic', 'crop');
% Масштабируем повернутое изображение сцены
%ImRes = imresize(ImRot, Rid/R, 'bicubic');

%-------------------------------------------------------------------------%
% Определям новые координаты центра линии глаз
[n, m] = size(Im); % размер исходной сцены изображения
% координаты центра линии глаз относительно центра изображения сцены
%xc0 = xc - round(m/2);
%yc0 = yc - round(n/2);
dx = round(m/2) - xc;
dy = round(n/2) - yc;
Phi = phi * pi/180;
s   = Rid/R; % коэффициент масштабирования

% аффинные преобразования: перенос, поворот, масштабирование
T = [s*cos(-Phi) s*sin(-Phi) 0; -s*sin(-Phi) s*cos(-Phi) 0; dx dy 1];
tform = maketform('affine', T);
ImAf  = imtransform(Im, tform, 'bicubic');
% Отслеживаем координаты центра линии глаз
ImCent = zeros(n, m);
ImCent(yc, xc) = 1;
ImCent = imtransform(ImCent, tform, 'bicubic');

[yc, xc] = find(ImCent == max(ImCent(:))); %новые координаты центра линии
clear ImCent;
%-------------------------------------------------------------------------%

% Выделяем нормализованный образ лица.
frame   = ddk_frame(ImAf, IIdFace, (xc - 55), (yc - 70));
[n, m]  = size(IIdFace);
face    = imcrop(ImAf, [(xc - 55) (yc - 70) (m - 1) (n - 1)]);
%face    = imadjust(face, stretchlim(face), []); % улучшение
imwrite(face, 'face.tif');

% Визуализация полученных результатов процедуры выделения образа лица
figure;
subplot(2, 2, 1); imshow(Im); title('Исходная сцена');
%subplot(1, 3, 2); imshow(ImAf); title('Affine');
subplot(2, 2, 2); imshow(frame); title('Выделенный образ');
subplot(2, 2, 3); imshow(IIdFace); title('Эталон лица');
subplot(2, 2, 4); imshow(face); title('Face');