function I = ddk_contur(Im, filename)
% ������� ��������� ������� ��������� ����������� �� ������ 'Canny' �
% ���������� ���������� � ���� � ��������� ������ 'filename' � ������. 

Iedge = edge(Im, 'canny');
[N, M] = size(Iedge);

for n = 1 : N
    for m = 1 : M
        if Iedge(n, m) == 0
            Iedge(n, m) = 1;
        else
            Iedge(n, m) = 0;
        end
    end
end

imwrite(Iedge, filename);