function ddk_eyes(Im)
%function ddk_eyes(im, id1, id2, id2n)
% �������, ������� ������� ������ ���� �� ������� �����������.
% im - ������� �����������;
% id1 � id2 - ������ ������� ����� ���� � ������� ����� ��������������.
%                   [03.10.2006]

%id1 = imread('Middle.tif');
Id1 = imread('R.tif');
Id2 = imread('L.tif');
[N, M] = size(Id2); % �������������� ������� ������� �����.

im = imresize(Im, 1.6, 'bicubic'); % ������� ����� ����
id1 = imresize(Id1, 1.6, 'bicubic'); % ������ ������� �����
id2 = imresize(Id2, 1.6, 'bicubic'); % ������ ������ �����

%�������� ������� �����������.
%im = ddk_edge(im);
%id1 = ddk_edge(id1);
%id2 = ddk_edge(id2);

%O1 = 0;
O2 = 0; O3 = 0;

% ��������� ��������� ������� (�������) �����.
[O2, k2] = ddk_sel_frame(im, id1, 1);

frame = imread('_frame.tif');
subplot(1, 2, 1); imshow(frame); title('������ ���');
clear frame;

% ��������� ��������� ������� (������) �����
[O3, k3] = ddk_sel_frame(im, id2, 2);

frame = imread('_frame.tif');
subplot(1, 2, 2); imshow(frame); title('������ ���');

Temp(1, 1 : 3) = [O2 k2];
Temp(2, 1 : 3) = [O3 k3];
Pic = ddk_cent(im, Temp, 'Cent_eye.tif');
figure; imshow(Pic);
% ���������� ��������� ��������� �������.
O2 = round(O2/1.6); O3 = round(O3/1.6);
O2(1) = O2(1) + round(N/2) + 5;
O2(2) = O2(2) + round(M/2);
O3(1) = O3(1) + round(N/2) + 5;
O3(2) = O3(2) + round(M/2);
% ��������� ������ ��������� ��� ��������� �������.
Temp(1, 1 : 3) = [O2 k2];
Temp(2, 1 : 3) = [O3 k3];
Temp

% ��������� ��������� ������� ���� �� �������� ����������� ����.
Pic = ddk_cent(Im, Temp, 'Cent_eye.tif');
figure; imshow(Pic);