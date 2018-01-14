function selection(filename)
% ������� ��������� ���� �� ����������� ����� � �������������� ���������� �
% ����, ��������� ��� ��������� ��������� ����.
%                   [06.12.2006]
Im  = imread(filename);
Rid = 48; % ��������� ���������� ����� �������
% ������� ����� ���� � ���������� ���������� ������ ���� �������.
[If, xi, yi] = ddk_faceE(filename, 2, 0.35);
% �������� ���������� ������������ ������� ����.
[xi1, yi1, xi2, yi2] = ddk_eyes(If);
% ���������� ������� ���� � ������� ��������� �������� �����.
x1 = xi1 + xi - 1;
y1 = yi1 + yi - 1;
x2 = xi2 + xi - 1;
y2 = yi2 + yi - 1;
% ��������� ���� ������� (� ��������) ����� ���� ������������ �����������.
if  y1 < y2
    phi = atan((y2 -y1)/(x2 - x1)) * 180/3.14
else
    phi = atan((y2 -y1)/(x2 - x1)) * 180/3.14
end

% ������� �����������, ����� �������� ����� ��������� � ������� ����.
[N, M] = size(Im);
% ���������� ������ ��������� �����������
xO = round(M/2); 
yO = round(N/2);
% ���������� ������ ����� ���� �� ��������: xc1 � yc1
xc1 = round((x2 - x1)/2 + x1 - 1);

if y1 > y2
    yc1 = round((y1 - y2)/2 + y2 - 1);
else
    yc1 = round((y2 - y1)/2 + y1 - 1);
end

% ���������� ����� ������� ���� � ������� ����� �����������
rx = xO - xc1;
ry = yO - yc1;
PicTemp = zeros(N + 2 * abs(ry) - 1, M + 2 * abs(rx) - 1);
nn = 2 * abs(ry);
mm = 2 * abs(rx);

% ����������, ��������� ������ �����������
if (rx >= 0) & (ry >= 0)
    PicTemp(nn : (nn + N - 1), mm : (mm + M -1)) = Im;
elseif (rx > 0) & (ry < 0)
    PicTemp(1 : N, mm : (mm + M -1)) = Im;
elseif (rx < 0) & (ry > 0)
    PicTemp(nn : (nn + N - 1), 1 : M) = Im;
elseif (rx <= 0) & (ry <= 0)
    PicTemp(1 : N, 1 : M) = Im;
end

PicTemp = uint8(PicTemp);
%imwrite(PicTemp, '_temp.tif');
%PicTemp = imread('_temp.tif');
%imshow(PicTemp);

% ������������ �������� ����� ����������� ������������ ����������� �����
Im_rot = imrotate(PicTemp, phi, 'bicubic', 'crop');
%imshow(Im_rot);

% ���������� ���������� ����� ���������� �������� ����
R = round(sqrt((x2 - x1)^2 + (y2 - y1)^2));
% ������������ ���������� ����������� �����
Im_res = imresize(Im_rot, Rid/R, 'bicubic');

% �������� ��������������� ����� ����.
id  = imread('Fnew.tif'); % "�����" ������ ����
% ���������� ������ ���� �� ����� �����������.
[n, m] = size(Im_res);
yc2 = round(n/2);
xc2 = round(m/2);
face = ddk_frame(Im_res, id, (xc2 - 54), (yc2 - 70));
%figure; imshow(face);
imwrite(face, 'face.tif');

subplot(1, 3, 1); imshow(PicTemp); title('�������������');
subplot(1, 3, 2); imshow(Im_rot); title('�������');
subplot(1, 3, 3); imshow(face); title('���������� �����');