function SelectGrad(filename)
% ������� ��������� ���� �� ����������� ����� � �������������� ���������� �
% ����, ��������� ��� ��������� ��������� ����.
%                  ������ �.�. [24.05.2007]
Im      = imread(filename);
Im      = adapthisteq(Im); % �������� �������������� ����������� �����
IIdFace = imread('Fnew.tif'); % ������ ������ ����
IdFace  = imresize(IIdFace, 1.06, 'bicubic');
IdMid   = imread('Fmid.tif'); % ������ ������� ����� ����
IdMid   = imresize(IdMid, 1.06, 'bicubic');
Rid = 48; % ��������� ���������� ����� �������
%-------------------------------------------------------------------------%
% ������� ����� ���� � ���������� ���������� ������ ���� �������.
[If, xi, yi] = ddk_FaceGrad(Im, IdFace, 0.08);
%If = imadjust(If, stretchlim(If), []);
If = adapthisteq(If);
% ������� ������� ����� ���� �� ����������� ������ � --||--
[Imid, xi0, yi0] = ddk_FaceGrad(If, IdMid, 0.08);

% �������� ���������� ������������ ������� ����.
%[xi1, yi1, xi2, yi2] = ddk_eyes(If, Imid, xi0, yi0);
[OR, OL] = ddk_eyes(If, Imid, xi0, yi0);
clear Imid If
% ���������� ������� ���� � ������� ��������� �������� �����.
x1 = OR(1) + xi - 1;
y1 = OR(2) + yi - 1;
x2 = OL(1) + xi - 1;
y2 = OL(2) + yi - 1;

% ��������� ���� ������� (� ��������) ����� ���� ������������ �����������.
phi = atan((y2 -y1)/(x2 - x1)) * 180/pi
% ���������� ���������� ����� ���������� �������� ����
R = round(sqrt((x2 - x1)^2 + (y2 - y1)^2))

% ���������� ������ ����� ���� �� ��������: xc � yc
xc = round((x2 - x1)/2 + x1 - 1);

if y1 > y2
    yc = round((y1 - y2)/2 + y2 - 1);
else
    yc = round((y2 - y1)/2 + y1 - 1);
end

% ���������� ������� ���������� ����������� ����� �� ���� "phi"
%ImRot = imrotate(Im, phi, 'bicubic', 'crop');
% ������������ ���������� ����������� �����
%ImRes = imresize(ImRot, Rid/R, 'bicubic');

%-------------------------------------------------------------------------%
% ��������� ����� ���������� ������ ����� ����
[n, m] = size(Im); % ������ �������� ����� �����������
% ���������� ������ ����� ���� ������������ ������ ����������� �����
%xc0 = xc - round(m/2);
%yc0 = yc - round(n/2);
dx = round(m/2) - xc;
dy = round(n/2) - yc;
Phi = phi * pi/180;
s   = Rid/R; % ����������� ���������������

% �������� ��������������: �������, �������, ���������������
T = [s*cos(-Phi) s*sin(-Phi) 0; -s*sin(-Phi) s*cos(-Phi) 0; dx dy 1];
tform = maketform('affine', T);
ImAf  = imtransform(Im, tform, 'bicubic');
% ����������� ���������� ������ ����� ����
ImCent = zeros(n, m);
ImCent(yc, xc) = 1;
ImCent = imtransform(ImCent, tform, 'bicubic');

[yc, xc] = find(ImCent == max(ImCent(:))); %����� ���������� ������ �����
clear ImCent;
%-------------------------------------------------------------------------%

% �������� ��������������� ����� ����.
frame   = ddk_frame(ImAf, IIdFace, (xc - 55), (yc - 70));
[n, m]  = size(IIdFace);
face    = imcrop(ImAf, [(xc - 55) (yc - 70) (m - 1) (n - 1)]);
%face    = imadjust(face, stretchlim(face), []); % ���������
imwrite(face, 'face.tif');

% ������������ ���������� ����������� ��������� ��������� ������ ����
figure;
subplot(2, 2, 1); imshow(Im); title('�������� �����');
%subplot(1, 3, 2); imshow(ImAf); title('Affine');
subplot(2, 2, 2); imshow(frame); title('���������� �����');
subplot(2, 2, 3); imshow(IIdFace); title('������ ����');
subplot(2, 2, 4); imshow(face); title('Face');