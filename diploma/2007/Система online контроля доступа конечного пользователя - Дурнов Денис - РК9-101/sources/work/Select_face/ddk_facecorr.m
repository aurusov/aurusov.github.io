function frame = ddk_facecorr(filename)
% ������� ��������� ���� ����������� ������� ��������������� �������������
% ����������� ����� � �������� ������ ����.
% filename - ����, ���������� �������������� ����������� �����;
% ������ �.�. 10 ������� [07.05.2007]

id  = imread('Fmid.tif');
im  = imread(filename);
[N, M] = size(im);
[n, m] = size(id);

% ��������� ����������� � �� ����������
idgr = ddk_grad(id);
imgr = ddk_grad(im);

% ���������� ��������� ���������� � ��������� �������
imcorr = ddk_corr(imgr, idgr);
%imcorr = ddk_corr(im, id);
[y, x] = find(imcorr == max(imcorr(:))) % ��������� ������� ������ ����
% ������������ ���������� ����������
frame = ddk_frame(im, id, (x - m), (y - n));
