function Pic = ddk_cent(im, Temp, filename)
% ������� ��������� ������� � ���� ���������, ���������� ������� �������� �
% ������� Temp. ������� ����� ��������� ����������� � ���������� ������
% �������� ������ ������ ����� ����������� ��� ����������� ������������
% �������� ������ �������� ���������.
%                   [02.10.2006]

[N, M] = size(im);
[n, m] = size(Temp);

Mask = zeros(N, M);
% Temp(p, 1 : 3) = [y + n/2, x + m/2 + 10, temp];

for i = 1 : n
    t1 = Temp(i, 1);
    t2 = Temp(i, 2);
    
    if (t1 > 0) & (t2 > 0)
       Mask((t1 - 3):(t1 + 3), t2) = [1 1 1 1 1 1 1];
       Mask(t1, (t2 - 3):(t2 + 3)) = [1; 1; 1; 1; 1; 1; 1];
    end
    
end


%imwrite(Mask, filename);
%Mask = imread(filename);
%Mask = uint8(mat2gray(Mask));
%Mask = uint8(Mask);
Mask = gscale(Mask);
Pic  = imadd(im, Mask);
clear Mask;
imwrite(Pic, filename);