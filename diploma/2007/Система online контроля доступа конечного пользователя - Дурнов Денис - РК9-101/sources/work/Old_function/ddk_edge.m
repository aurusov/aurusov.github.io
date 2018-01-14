function Iedge = ddk_edge(Im)
% Функция выделения контура исходного изображения по методу 'Canny'. 

Iedge = edge(Im, 'canny');
[N, M] = size(Iedge);

for n = 1 : N
    for m = 1 : M
        if Iedge(n, m) == 0
            Iedge(n, m) = 1;
        else
            Iedge(n, m) = 0;
        end
    end
end
