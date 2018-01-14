function ddk_comp2(filename)

I = imread(filename);
B = edge(I, 'canny');

%Ih = histeq(I);
%Bh = edge(Ih, 'canny');
Ii = imadjust(I, stretchlim(I), []);
Bi = edge(Ii, 'canny');
Ia = adapthisteq(I);
Ba = edge(Ia, 'canny');

figure;
%subplot(2, 3, 1); subimage(I); title('Original');
%subplot(2, 3, 2); ddk_histequal(I); title('Equalization');
%subplot(2, 3, 3); subimage(B); title('Edge by Canny');
%subplot(2, 3, 4); subimage(Ih); title('Histeq');
%subplot(2, 3, 5); ddk_histequal(Ih); title('Equalization');
%subplot(2, 3, 6); subimage(Bh); title('Edge by Canny');

subplot(2, 3, 1); subimage(Ii); title('Imadjust');
subplot(2, 3, 2); ddk_histequal(Ii); title('Equalization');
subplot(2, 3, 3); subimage(Bi); title('Edge by Canny');
subplot(2, 3, 4); subimage(Ia); title('Adapthisteq');
subplot(2, 3, 5); ddk_histequal(Ia); title('Equalization');
subplot(2, 3, 6); subimage(Ba); title('Edge by Canny');