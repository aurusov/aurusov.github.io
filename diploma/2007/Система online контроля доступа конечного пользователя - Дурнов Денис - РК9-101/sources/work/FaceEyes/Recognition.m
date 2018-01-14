function Recognition(ImFace)
% ������� ������������� � ����������� ����������� ����.
% ImFace - ���������� ����� ���� �������� SelectGrad()
%                  ������ �.�. [31.05.2007]
%-------------------------------------------------------------------------%
% ���������� ���������� ���� ������
Alexei   = imread('C:\MATLAB701\work\FaceEyes\DBF\AlexeiFace.tif');
Artem    = imread('C:\MATLAB701\work\FaceEyes\DBF\ArtemFace.tif');
Katerina = imread('C:\MATLAB701\work\FaceEyes\DBF\KaterinaFace.tif');
Olia     = imread('C:\MATLAB701\work\FaceEyes\DBF\OliaFace.tif');
Valentin = imread('C:\MATLAB701\work\FaceEyes\DBF\ValentinFace.tif');

DBF = {Alexei, Artem, Katerina, Olia, Valentin};
[n, m] = size(DBF); % ������� �� (���������� �������)
%-------------------------------------------------------------------------%

ImConst = imcrop(ImFace, [8 50 90 68]); % ������� ����� ����
ImConst = ddk_GradDouble(ImConst); % ����������� �����������
%{ImConst}

k  = 0;
i0 = 0;

% ���� ����������� �������� ������ (�� ��� ������� ����� ����)
for i = 1 : m
    ImTemp = imcrop(DBF{i}, [8 50 90 68]); % ������� ����� �� ��
    ImTemp = ddk_GradDouble(ImTemp); % ��������� ���������
    
    % ���������� �������� ������� ���������� ����� ��������
    kj = ddk_CorrFaz(ImConst, ImTemp);
    %kj = ddk_CorrFaz(double(ImConst), double(ImTemp))
    
    if kj > k
        k   = kj;
        i0  = i;
    end
    
end    

k
% ���������� ��������� ������������� � �����������
figure,
subplot(1, 2, 1); imshow(ImFace); title('� �������������');
subplot(1, 2, 2); imshow(DBF{i0}); title('��������� �����������');