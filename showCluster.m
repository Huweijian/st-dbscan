function [ ] = showCluster( data , radius)
% ��ʾ�������� 
% data ȫ������
% radius ��Բ�İ뾶

clf;
figure(1);
% ��û�о���ĵ㻭СԲ��.
cl = data((data(:, 4) == 0), :);
plot(cl(:, 1), cl(:, 2), '.')
hold on 

% �ر��1�ĵ㻭��ɫ*
cl = data((data(:, 4) == 1), :);
plot(cl(:, 1), cl(:, 2), '*r')
hold on;

% �ر��2�ĵ㻭��ɫ*
cl = data((data(:, 4) == 2), :);
plot(cl(:, 1), cl(:, 2), '*g')
hold on;

% �ر��3�ĵ㻭���ɫ*
cl = data((data(:, 4) == 3), :);
plot(cl(:, 1), cl(:, 2), '*c')
hold on;

cl = data((data(:, 4) == 4), :);
plot(cl(:, 1), cl(:, 2), '*b')
hold on;

% ������ĵ㻭��ɫ�㣬���ú�ɫԲȦ���eps��Χ
cl = data((data(:, 4) == -1), :);
plot(cl(:, 1), cl(:, 2), 'dk')
for i=1:length(cl(:, 1))
    drawCircle(cl(i, 1), cl(i, 2), radius, 'k');
end
hold on;

% �߽���ú�ɫԲȦ���eps��Χ
cl = data((data(:, 5) == 2), :);
for i=1:length(cl(:, 1))
    drawCircle(cl(i, 1), cl(i, 2), radius, 'r');
end

axis([-6, 6, -6, 6])
grid on;    % ��������
pause(0.001);
end

