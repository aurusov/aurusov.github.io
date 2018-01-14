function Cent = ddk_CirAnaliz(Im, angle)
%function [k_max, xmax, ymax] = ddk_CirAnaliz(Im, angle)
% ������� ������� ���������� ����������� ����� ������� ������������ �����
% ������������ ���� ��������� ��������
% Im    - ������������� ����������� �����
% angle - ���� �������� �������������� ����������� (0, 13 ��� -13)
% k_max - �������� ������������ ���������� ���������� ����������
% xmax, ymax - ���������� ���������� ���������� 
%               ������ �.�. [11.05.2007]
%-------------------------------------------------------------------------%
%id      = imread('Fnew.tif');
k       = 0.6; % ���������� ���������������
factor  = [2; 2.2; 1.8]; % ����������� ���������� ����������

% ��������� ������� ���������� ����������� �����
ImEdge = imrotate(Im, angle, 'bicubic', 'crop');

% ������������������� ���������� ����������� - �������� "����������" ����
A       = size(ImEdge);
A(1)    = round(A(1)*k);
ImScale = imresize(ImEdge, A, 'bicubic');

%----------------��������� ������� ����������� �����-----------------------
hy = fspecial('sobel');
hx = hy';
Iy = imfilter(double(ImScale), hy, 'replicate');
Ix = imfilter(double(ImScale), hx, 'replicate');
Ig = sqrt(Ix.^2+Iy.^2); % ��������� ��������
Ig = uint8(Ig);

% ����������� ��������� �������
ImEdge = im2bw(Ig, 0.95);
clear Iy Ix Ig
%ImEdge  = edge(ImScale, 'canny'); % ��������� ������� �����������
%--------------------------------------------------------------------------

[n, m]  = size(ImEdge);

Cent = {zeros(n, m), zeros(n, m), zeros(n, m)}; % ������� �������

for tmp = 1 : 3
    %tmp
    % ������� �������� ����������� ����������
    nn      = round(m/factor(tmp));
    I_cir   = ddk_cir(nn);
    [N, M]  = size(I_cir);
    % ������������ ����� ������� �����������
    for i = 1 : (n - N)
        for j = 1 : (m - M)
            I_tmp = imcrop(ImEdge, [j i (N - 1) (M - 1)]);
            I_mul = immultiply(I_tmp, I_cir);
            temp = corr2(I_cir, I_mul);
            %[i j temp]
            Cent{tmp}(i + round(N/2) - 1, j + round(M/2) - 1) = temp;
        end
    end
    
    clear I_tmp I_mul  
    % ������������ ������������� ������� ������� ������� �� ��������
    %nn = round(nn/2);
    %CentCrop = mat2gray(Cent{tmp}(nn : (i + nn - 1), nn  : (j + nn - 1)));
    %Cent{tmp} = mat2gray(Cent{tmp});
    %Cent{tmp}(nn : (i + nn - 1), nn  : (j + nn - 1)) = CentCrop;
end

% ���������� ���� ������������
figure;
subplot(2, 3, 1); imshow(ImEdge); title('Image scaled');
subplot(2, 3, 2); imshow(ImEdge); title('Image scaled');
subplot(2, 3, 3); imshow(ImEdge); title('Image scaled');
subplot(2, 3, 4); imshow(Cent{1}); title('CirFactor = 2');
subplot(2, 3, 5); imshow(Cent{2}); title('CirFactor = 2.2');
subplot(2, 3, 6); imshow(Cent{3}); title('CirFactor = 1.8');

% ������������ ���������� ���������� - 3 ������� �������
% ��������� ������� ������������� ��������� �������� 3�3
[nc, mc] = size(Cent{1});
k_max   = 0;
numb    = 0; % ����� ������� � ������������ �������������

for tmp = 1 : 3
    tmp
    for i = 1 : (nc - 2)
        for j = 1 : (mc - 2)
            step    = Cent{tmp}(i : (i + 2), j : (j + 2));
            MeanTmp = mean2(step); % ������� �������� ��������� �������
                       
            if MeanTmp > k_max
                xmax    = j + 1;
                ymax    = i + 1;
                k_max   = MeanTmp;
                numb    = tmp;
            end
            
        end
    end
end

% ������������ ��������� ������ � ��������� ���������� ����������.
Temp    = [ymax, xmax];
ImCent  = ddk_cent(ImScale, Temp, '_temp.tif');

nn      = round(m/factor(numb));
ImCir   = gscale(ddk_cir(nn));
[N, M]  = size(ImCir);

x       = xmax - round(M/2) + 1;
y       = ymax - round(N/2) + 1;
im_temp = imcrop(ImCent, [x y (M - 1) (N - 1)]);
im_temp = imsubtract(im_temp, ImCir);
ImCent(y : (y + N - 1), x : (x + M -1)) = im_temp;

figure
imshow(ImCent);
clear im_temp ImCir

% ���������� �������� ���������
T       = [cos(-angle) sin(-angle) 0; -sin(-angle) cos(-angle) 0; 0 0 1];
tform   = maketform('affine', T);
% ��������� �������� �������� ��������������
[xmax ymax] = tforminv([x y], tform);
xmax = round(xmax); 
ymax = round(ymax/k); % ������ �������� ��������� �� ���������������

numb
k_max
%xmax
%ymax