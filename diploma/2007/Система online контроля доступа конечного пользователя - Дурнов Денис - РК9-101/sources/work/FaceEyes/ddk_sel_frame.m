function [I, O, k] = ddk_sel_frame(Im, Id, eye)
% ������� ��������� ������ ����� �� ����������� ����� ������� ����������.
% Im - �������������� ����� (������� ����� ����);
% Id - ������ �����;
% eye - ���������� ���� (������ ��� �����);
% I - �������; O - ��������� ������ ������� (������� ����� ����).
% ������������ ������������ ���������� -> _frame.tif
%           (����������) ������ �.�. [24.05.2007]
[N, M] = size(Im);
[n, m] = size(Id);

im = ddk_grad(Im);
id = ddk_grad(Id);
%im = Im; id = Id;

x = 0; y = 0; k = 0;

if eye == 1
    j0 = 1; jend = round(M/2) - m + 1;
elseif eye == 2
    j0 = round(M/2); jend = M - m + 1;
else
    error('Eye should be "1 = right" or "2 = left".');
end

for i = 1 : (N - n + 1) % ������������ ������������ �� ���������
    for j = j0 : jend % ������������ ������������ �� �����������
    %for j = 1 : (M - m - 1) % ������������ ������������ �� �����������    
        s = imcrop(im, [j i (m - 1) (n - 1)]);
        %s = imcrop(Im, [j i (m - 1) (n - 1)]);
        %s = histeq(s);
        s = ddk_grad(s);
        
        temp = corr2(id, s);
       
        if temp > k
            k = temp;
            x = j;
            y = i;
        end
        
    end
end

clear s;

I = imcrop(Im, [x y (m - 1) (n - 1)]);
O = [x, y];

% ������������ ���������� � ���� ���������� ����� �� ������� �����������.
Frame = ddk_frame(Im, Id, x, y);