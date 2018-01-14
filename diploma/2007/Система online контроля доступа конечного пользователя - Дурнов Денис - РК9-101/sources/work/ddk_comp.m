function ddk_comp(filename)

I = imread(filename);
Ih = adapthisteq(I);

subplot(2, 3, 1); imshow(I); title('�����������');
subplot(2, 3, 2); imhist(I); title('�����������');
subplot(2, 3, 3); ddk_histequal(I); title('������������ ��������������');
subplot(2, 3, 4); imshow(Ih); title('����� ���������');
subplot(2, 3, 5); imhist(Ih); title('�����������');
subplot(2, 3, 6); ddk_histequal(Ih); title('������������ ��������������');
imwrite(Ih, 'Done.tif');