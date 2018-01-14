function ddk_selectY(im, id, k0)
%   ������� ��������� ���� �� ����������� ����, ��� ������� � ����������. 
% ������� ��������� ������� ����������� ����, � ������� ����� ���� ������,
% ��������� �����, �� �������� ����� ���������� ������ ����� ����
% ��� ���������� ������ � ��� � ����������� ����������� ����������.
% �� ������ ������� ���������� ����� �����������.

im = imresize(im, 1.6, 'bicubic');
id = imresize(id, 1.6, 'bicubic');

[N, M] = size(im);
[n, m] = size(id);
%Im = ddk_edge(im);
%Id = ddk_edge(id);

x = 0; y = 0; p = 0; k = 0; %k0 = 0.5;
Temp = zeros(30, 3);

for i = 1 : (N - n + 1) % ����� �� 2 ������� ��� ����������� �� ���������
    for j = 1 : (M - m + 1) % ���������� ���� ����������� 
        s = im(i : (i -1 + n), j : (j - 1 + m));
        Ss = histeq(s);
        temp = corr2(id, Ss);
        %temp = ddk_korfaz(id, s);
        if temp > k
            k = temp;
            x = i; y = j;
            if temp > k0 
                p = p + 1;
               %Temp(p, 1 : 3) = [x + round(n/2) + 5, y + round(m/2), temp];
                Temp(p, 1 : 3) = [x + round(n/2), y + round(m/2), temp];
            end
        end       
    end
end
k
clear s;

I = im(x : (x - 1 + n), y : (y - 1 + m));
imwrite(I, '_res_sel.tif'); % ���������� ���������� �������.

% ��������� ������� ������������ max ������� ����� �� ��������.
Cent = ddk_cent(im, Temp, '_cent_selY.tif');
clear Temp;

% ������������ ���������� � ���� ���������� ����� �� ������� �����������.
Frame = ddk_frame(im, id, x, y);

figure;
subplot(1, 3, 1); imshow(im); title('�����������');
subplot(1, 3, 2); imshow(Cent); title('Mac�� �������');
subplot(1, 3, 3); imshow(Frame); title('Result');
%subplot(2, 2, 4); imshow(I); title('Result');