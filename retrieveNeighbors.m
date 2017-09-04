function [ neighbors ] = retrieveNeighbors( data, coreIndex, eps1, eps2, clusterLabel)
x = data(coreIndex, 1);
y = data(coreIndex, 2);
t1 = data(coreIndex, 3);

neighbors = [];
for i=1:length(data)
    % TODO: ������о����������Լ��ӵģ�������û����ϸ˵������ϸ˼��
    % �����Χ�㻹û�б�ǹ������Ѿ����Ϊ��ǰ�أ���������Ч�ĵ�
    if data(i, 4) ==0 || data(i, 4) == clusterLabel
        dis1 = sqrt((data(i, 1) - x)^2 + (data(i, 2) - y)^2);
        dis2 = abs(data(i, 3) - t1);
        if dis1 <= eps1 && dis2 <= eps2
            neighbors = [neighbors, i];
        end
    else
        continue ;
    end
end

end

