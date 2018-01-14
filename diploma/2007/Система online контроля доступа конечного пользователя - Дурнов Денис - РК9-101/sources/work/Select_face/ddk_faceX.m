function ddk_faceX(filename)
% ������� ��������� ���� ����������� � ������� �������� ��������, ��������
% �� ���������� �����.
I       = imread(filename);
I_e     = ddk_edge(I); % ������ ��������� �����������
X_cir   = ddk_X(circle); % ����������� ������ ��������� �����

% ������������������� ���������� ����������� - �������� "����������" ����
k       = 1.7; % ���������� ���������������
A       = size(I_e);
A(2)    = round(A(2)*k);
I_em    = imresize(I_e, A, 'bicubic');
[n, m]  = size(I_em);

circle  = imread('R37.bmp'); % ����������� � �������������� �������� ����
[N, M]  = size(circle);
Cent = zeros(n, m); % ������� "�������" ������� �������

for i = 1 : 3 : (n - N)
    for j = 1 : 3 : (m - M)
        A_temp = I_em(i : (i + N - 1), j : (j + M - 1));
        temp = 0;
        for q = 1 : size(X_cir)
            x = imag(X_cir(q));
            y = real(X_cir(q));
            
            if A_temp(y, x) == 0
                temp = temp + 1;
            end
            
        end
        Cent(i + round(N/2) - 1, j + round(M/2) - 1) = temp;      
    end
end
clear A_temp;

Cent_v = Cent(round(N/2) : (i + round(N/2) - 1), round(M/2)  : (j + round(M/2) - 1));
figure, surf(Cent_v), shading flat;

% ���������� ���������� ������� ������� � ���� ������������ �����������
% maxx - ������������ �������� � ��������, y[] - ������ �� ����������
[maxx, y]       = max(Cent); 
[Cent_max, x]   = max(maxx');
y = y(x); % x � y ���������� ������������� ��������
Cent = uint8(Cent/(Cent_max/255));

Temp    = [y, x]
I_c     = ddk_cent(I, Temp, '_temp.tif'); % ������������ ��������� ������

figure 
imshow(I_c); title('����� ������');
figure
subplot(1, 2, 1); imshow(I_em); title('Edge scale');
subplot(1, 2, 2); imshow(Cent); title('������� �������');