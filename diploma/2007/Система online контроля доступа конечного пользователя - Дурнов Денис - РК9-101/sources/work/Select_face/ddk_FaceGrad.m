function [ImFace, x, y] = ddk_FaceGrad(Im, Id, k0)
% ������� ��������������� ����������� ������ ���� �� ����������� �����
% ����� �������� ����������� � �� ��������� � ���������� ������ � ����.
% ImFace - ���������� ����� ����;
% <�> � <�> - ���������� ������ �������� ���� ����� ������ ����;
% Im - ������� ����������� �����;
% Id - ������� �������, �� �������� ����� �������� �������� ����;
%           ������ �.�. [18.05.2007]
im = ddk_grad(Im);
id = ddk_grad(Id);

[N, M]  = size(im);
[n, m]  = size(id);

x = 0; y = 0; p = 0; k = 0;
%Temp = zeros(10, 3);

% ������������ �������� ����� �����������
for i = 1 : 3 : (N - n)
    for j = 1 : 3 : (M - m)
        I_tmp = imcrop(im, [j i (m - 1) (n - 1)]);
        temp = corr2(I_tmp, id);
        %temp = ddk_CorrFaz(I_tmp, id);
        
        if temp > k
            k = temp;
            x = j; y = i;
            
            if temp > k0 
                p = p + 1;
                Temp(p, 1 : 3) = [y + round(n/2), x + round(m/2), temp];
            end
            
        end
        
    end
end
       
k
p
% ����������� ��������� max �������� �����
Cent    = ddk_cent(im, Temp, 'Plus.tif');
%Cent    = ddk_cent(Im, Temp, 'Plus.tif');
% ����������� ��������� ����������� ������, ������������ � �����
Frame   = ddk_frame(Im, id, x, y);
%Frame   = ddk_frame(im, id, x, y);

% ��������� ���������� ������ ���� �� ����������� �����
ImFace = imcrop(Im, [x y (m - 1) (n - 1)]);


figure;
subplot(2, 2, 1); imshow(im); title('�������� �����');
subplot(2, 2, 2); imshow(id); title('������');
subplot(2, 2, 3); imshow(Cent); title('Cent');
subplot(2, 2, 4); imshow(Frame); title('���������');            