function [I, O, k] = ddk_sel_frame(im, id, num)
% ������� ��������� ��������� ����� �� ����������� �����.
% im - �������������� �����; id - ������; eye_name - ��� �����.
% I - �������; O - ��������� ������ ������� (������� ����� ����).
% ������������ ������������ ���������� -> _frame.tif
num
[N, M] = size(im);
[n, m] = size(id);

x = 0; y = 0; k = 0;

if num == 1
    j0 = 1; jend = round(M/2) - m + 1;
elseif num == 2
    j0 = round(M/2); jend = M - m + 1;
else
    j0 = 1; jend = M - m + 1;
end

for i = 1 : N - n + 1 % ������������ ������������ �� ���������
    for j = j0 : jend % ������������ ������������ �� �����������
        
        s = im(i : (i -1 + n), j : (j - 1 + m));
        s = histeq(s);
        temp = corr2(id, s);
       
        if temp > k
            k = temp;
            y = i;
            x = j;
        end
        
    end
end
clear s;

I = im(y : (y - 1 + n), x : (x - 1 + m));
O = [x, y];

% ������������ ���������� � ���� ���������� ����� �� ������� �����������.
Frame = ddk_frame(im, id, x, y);