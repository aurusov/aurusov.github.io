function imcorr = ddk_corr(im, id)
% ���������� ��������� ���������� �� ��������� ������� ���
% ����������������� ������� - ������ �.�. [07.05.2007]
% im - ����������� �����
% id - ������-�����
[N, M]  = size(im);
im1     = fft2(im);
id1     = conj(fft2(id, N, M));
imcorr  = real(ifft2(id1.*im1));

clear im1 id1

% ���������������� � ������������ �����������
imcorrg  = gscale(imcorr);

% ������������ ����������
figure
subplot(2, 1, 1); imshow(im);
subplot(2, 1, 2); imshow(imcorrg > 254);
%subplot(2, 1, 2); imshow(imcorrg);