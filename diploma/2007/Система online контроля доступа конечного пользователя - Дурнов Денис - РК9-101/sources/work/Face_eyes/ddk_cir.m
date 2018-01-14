function Im_cir = ddk_cir(n)
% Функция вырисовывает круг, вписанный в рамку изображения размера "n".

Cir = zeros(n, n);

for i = 1 : n % сканирование нулевой матрицы по горизонтали
    j1 = round(sqrt(i*n - i^2) + n/2);
    j2 = round(-sqrt(i*n - i^2) + n/2);
    
    if (j1 == 0) j1 = 1; end
    if (j2 == 0) j2 = 1; end
    
    Cir(j1, i) = 1;
    Cir(j2, i) = 1;
end

for j = 1 : n % сканирование нулевой матрицы по вертикали.
    i1 = round(sqrt(j*n - j^2) + n/2);
    i2 = round(-sqrt(j*n - j^2) + n/2);
    
    if (i1 == 0) i1 = 1; end
    if (i2 == 0) i2 = 1; end
    
    Cir(j, i1) = 1;
    Cir(j, i2) = 1;
end

Im_cir = logical(Cir);
%imwrite(Cir, '_temp.tif');
%Im_cir = imread('_temp.tif');
%Im_cir = uint8(Cir);
%imshow(Im_cir);
    