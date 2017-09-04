%% ����ģ�����ݣ��粻��Ҫ����ģ��������ע�ͱ���
clc;clear;
POINT_NUM = 100;     % ģ�������ܵ���
NOISE_POINT_NUM = 5; % ģ����������
pt1 = genRandPointInCircle(0, 0, 1, POINT_NUM/4, 1);
pt2 = genRandPointInCircle(0, 2, 2, POINT_NUM/2, 4);
pt3 = genRandPointInCircle(-4, 0, 1, POINT_NUM/4 - NOISE_POINT_NUM, 3);
pt4 = genRandPointInCircle(0, 0, 6, NOISE_POINT_NUM, 2);
D = [pt1; pt2; pt3; pt4];

%% ������� eps1 eps2 minpts ����
EPS1 = 0.8;
EPS2 = 1.2;
MINPTS = 5;
DELTA_E = 1.1;

%% ST-DBSCAN��ʼ
clf;                % �������figure
clusterLabel = 0;   % ��ʼ���ر��
for i=1:length(D(:, 1))                                             	%(i)
    if D(i, 4) == 0                                                     %(ii)
        X = retrieveNeighbors(D, i, EPS1, EPS2, 0);                 	%(iii)
        if length(X) < MINPTS
            D(i, 4) = -1;                                               %(iv)
            showCluster(D, EPS1);
        else                                        % construct a new cluster(v)
            clusterLabel = clusterLabel + 1;
            clusterItem = [];       % ����������
            for j=1:length(X)
                D(X(j), 4) = clusterLabel;
                D(X(j), 5) = 1;    % ������������Ϊcore object  
                clusterItem = [clusterItem, D(X(j), 3)];    %Ϊ�˼�������ص�����ƽ��ֵ��������Ҫ��������е��������ݶ������������ST-DBSCAN����3.3
                showCluster(D, EPS1);
            end
            
            queue = X;                                                 %(vi)
            
            while isempty(queue) == 0
                ptCurrent = queue(1);  % ���в��� pop
                queue(1) = [];        
                Y = retrieveNeighbors(D, ptCurrent, EPS1, EPS2, clusterLabel);
                
                if length(Y) >= MINPTS
                    for j=1:length(Y)                                       %(vii)
                        
                        % is not marked as noise
                        if D(Y(j), 4) == -1
                            isNotNoise = 0;
                        else
                            isNotNoise = 1;
                        end
                        
                        % is in not in a cluster
                        if D(Y(j), 4) == 0
                            isNotInCluster = 1;
                        else
                            isNotInCluster = 0;
                        end
                        
                        % TODO�����������ƺ���Щ���£��о�isNotNoist��isNotInCluster�е�����
                        % |Cluter_Ave() - o.value| < e
                        if (isNotNoise && isNotInCluster) && abs(mean(clusterItem) - D(Y(j), 3)) < DELTA_E
                            D(Y(j), 4) = clusterLabel;          % mark o with current cluster label
                            D(Y(j), 5) = 1;                     % ������������Ϊ core object 
                            clusterItem = [clusterItem, D(Y(j), 3)];
                            queue = [queue, Y(j)] ;             % ���в��� push
                            showCluster(D, EPS1);
                        end

                    end
                else % ���¼��к�������������ͬ���Ѳ���core object�ĵ���Ϊ�߽�һ��������У������ټ�����չ
                    D(ptCurrent, 4) = clusterLabel;
                    D(ptCurrent, 5) = 2;    %������������Ϊ border 
                    clusterItem = [clusterItem, D(ptCurrent, 3)];
                    showCluster(D, EPS1);
                end
                
            end
            
        end
        
    end
end

showCluster(D, EPS1);


