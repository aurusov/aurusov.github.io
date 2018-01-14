function Ig = ddk_GradDouble(Im)
% ������� ���������� �������� ���������. ��������� ��� ����������� ������
%                         ������ �.�.[31.05.2007]
hy = fspecial('sobel');
hx = hy';

Iy = imfilter(double(Im), hy, 'replicate');
Ix = imfilter(double(Im), hx, 'replicate');
Ig = sqrt(Ix.^2+Iy.^2);