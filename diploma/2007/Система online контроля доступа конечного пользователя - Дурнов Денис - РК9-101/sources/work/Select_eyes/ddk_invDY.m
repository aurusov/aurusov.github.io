function D = ddk_invDY(Iedge)

% X - ����������� ������-������� ��������� ������� �����������.
% ��� ���������� ������� X ���������������� �������� ������.
[N, M] = size(Iedge);
X = 0;

for n = 1 : N
    for m = 1 : M
        if Iedge(n, m) == 0
            K = X;
            X = [K; m + i*n];
        end
    end
    clear K;
end

X(1) = []; % ������� ������ ������� ���������� ������ ���� � ������

% ������������� � ������������ ������
H = mean(X); X = X - H;
Xx = real(X); Xy = imag(X);
clear H X;
maxx = max(Xx); maxy = max(Xy);
Xx = Xx/maxx; Xy = Xy/maxy;
Xnew = Xx + i * Xy;
clear Xx Xy;

% ���������� ������� ���������� (����������)
D = Xnew * ones(1, length(Xnew));
clear Xnew;
D = abs(D - D.');
size(D)
D = imresize(D, [50 50], 'bicubic');