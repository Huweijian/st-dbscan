function [ ] = showCluster( data , radius, colorTable)
% ��ʾ��������
% data ȫ������
% radius ��Բ�İ뾶
% colorTable ��ɫ��

clf;
figure(1);
% ��û�о���ĵ㻭СԲ��.
cl = data((data(:, 4) == 0), :);
plot(cl(:, 1), cl(:, 2), '.')
hold on

% �ر��1�ĵ㻭��ɫ*
for i=1:length(colorTable)
    cl = data((data(:, 4) == i), :);
    plot(cl(:, 1), cl(:, 2), ['*', colorTable(i)])
    hold on;
end

% ������ĵ㻭��ɫ�㣬���ú�ɫԲȦ���eps��Χ
cl = data((data(:, 4) == -1), :);
plot(cl(:, 1), cl(:, 2), 'dk')
for i=1:length(cl(:, 1))
    drawCircle(cl(i, 1), cl(i, 2), radius, 'k');
end
hold on;

% �߽���ú�ɫԲȦ���eps��Χ
cl = data((data(:, 5) == 2 ), :);
for i=1:length(cl(:, 1))
    % TODO�� bug
    drawCircle(cl(i, 1), cl(i, 2), radius, char(colorTable(cl(i, 4))));
end

axis([-6, 6, -6, 6])
grid on;    % ��������
pause(0.001);
end

