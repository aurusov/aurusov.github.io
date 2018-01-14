function ddk_FselD(im, id, k0)
%   ������� ��������� ����������� ����, ��� ������� � ����������. 
% ������� ��������� ������� ����������� ����, � ������� ����� ���� ������,
% ��������� �����, �� �������� ����� ���������� ������ ����� ����
% ��� ���������� ������ � ��� � ����������� ����������� ����������.
% �� ������ ������� ���������� ����� �����������.
%               ������ �.�. 25.05.2006 12:58 
[N, M] = size(im);
[n, m] = size(id);

Im = ddk_edge(im); % ����������� � ��������� �������
Id = ddk_edge(id);

D = ddk_invD(Id);

x = 0; y = 0; p = 0; k = 0;
Temp = zeros(20, 3);

for i = 1 : 4 : (N - n) % ����� �� 4 ������� ��� ����������� �� ���������
    for j = 1 : 4 : (M - m) % ���������� ���� ����������� 
        S = Im(i : (i - 1 + n), j : (j - 1 + m));
        Dtemp = ddk_invD(S);
        temp = corr2(D, Dtemp);
        clear Dtemp;
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

clear S D;
Iedge = Im(x : (x - 1 + n), y : (y - 1 + m));
clear Im;
I = im(x : (x - 1 + n), y : (y - 1 + m));

Mask = zeros(N, M);
for i = 1 : p
    t1 = Temp(i, 1);
    t2 = Temp(i, 2);
    if (t1 > 0) & (t2 > 0)
     Mask((t1 - 3):(t1 + 3), t2) = [1 1 1 1 1 1 1];
     Mask(t1, (t2 - 3):(t2 + 3)) = [1; 1; 1; 1; 1; 1; 1];
     %Mask(t1, t2) = 1;
    end
end
clear Temp;

% ��������� ������� ������������ max ������� ����� � ����������
imwrite(Mask, 'Plus.tif');
Mask = imread('Plus.tif');
P = imadd(im, Mask);
clear Mask;
imwrite(P, 'Plus.tif');

figure;
subplot(2, 3, 1); imshow(im); title('�����������');
subplot(2, 3, 2); imshow(id); title('������');
subplot(2, 3, 3); imshow(I); title('Result');
subplot(2, 3, 4); imshow(P); title('Mac��');
subplot(2, 3, 5); imshow(Id); title('������-������');
subplot(2, 3, 6); imshow(Iedge); title('Result-������');