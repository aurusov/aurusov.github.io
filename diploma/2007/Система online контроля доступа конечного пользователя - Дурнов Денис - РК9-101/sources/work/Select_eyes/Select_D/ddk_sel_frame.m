function [O, k] = ddk_sel_frame(Im, Id, num)
% ������� ��������� ����. "������" - num = 1, "�����" - num = 2.
% Im - �������������� �����; Id - ������; 
% O - ��������� ������ ������� (������� ����� ����).
% ������������ ������������ ���������� -> _frame.tif
im = ddk_edge(Im); [N, M] = size(im);
id = ddk_edge(Id); [n, m] = size(id);
x = 0; y = 0; k = 0;

D_id = ddk_invDY(id);

if num == 1
    j0 = 1; jend = round(M/2) - m + 1;
elseif num == 2
    j0 = round(M/2); jend = M - m + 1;
else
    j0 = 1; jend = M - m + 1;
end

for i = 1 : 2 : N - n + 1 % ������������ ������������ �� ���������
    for j = j0 : 2 : jend % ������������ ������������ �� �����������
        s = im(i : (i -1 + n), j : (j - 1 + m));
        S = ddk_invDY(s);
        temp = corr2(D_id, S);
        
        if temp > k
            k = temp;
            x = i; y = j;
        end
        
    end
end
clear s;
%I = Im(x : (x - 1 + n), y : (y - 1 + m));
O = [x, y];
% ������������ ���������� � ���� ���������� ����� �� ������� �����������.
Frame = ddk_frame(Im, Id, x, y);