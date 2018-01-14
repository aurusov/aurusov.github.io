function D = ddk_invDY(Iedge)

% X - комплексный вектор-столбец исходного контура изображения.
% Для уменьшения размера X перемасштабируем исходный контур.
[N, M] = size(Iedge);
X = 0;

for n = 1 : N
    for m = 1 : M
        if Iedge(n, m) == 0
            K = X;
            X = [K; m + i*n];
        end
    end
    clear K;
end

X(1) = []; % удаляем первый элемент положенный равным нулю в начале

% Центрирование и нормирование данных
H = mean(X); X = X - H;
Xx = real(X); Xy = imag(X);
clear H X;
maxx = max(Xx); maxy = max(Xy);

if maxx == 0 
    Xx = 0;
else
    Xx = Xx/maxx;
end
if maxy == 0 
    Xy = 0;
else
    Xy = Xy/maxy;
end

Xnew = Xx + i * Xy;
clear Xx Xy;

% Вычисление матрицы расстояний (инварианта)
D = Xnew * ones(1, length(Xnew));
clear Xnew;
D = abs(D - D.');
%size(D)
D = imresize(D, [100 100], 'bicubic');