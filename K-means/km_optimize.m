%% Group Information
% NAME                     WORKLOAD
% Wanjin Li                K-means realization/Part2
% Taoran Ju                K-means optimization/Part 3
% Hyun Jun Choi            Gaussian Mixture Model implementation and Comparison/Part3

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load 'clusters.txt';
k = 3;
x = clusters(:,1);
y = clusters(:,2);

num = length(clusters(:,1));

% Initiate the centroids
centroid = zeros(k,2);
r = randperm(num);

%% get the initial clustering centroids

%Traditional method
centroid0 = zeros(k,2);
for c =1:k
    centroid0(c,:) = clusters(r(c),:);
end

%Optimization method
% centroid0 = get_centroid(k,x,y);

%% %%

iter = 100;
temp = zeros(k,1);
class = zeros(num,1);


for i = 1:iter
    sum = zeros(k,2);
    count = zeros(k,1);

%caculate every point's cluster
    for j = 1:num
        for z = 1:k
            temp(z,1)=sqrt((centroid0(z,1)-x(j)).^2+(centroid0(z,2)-y(j)).^2);
        end
        [minx, ind] = min(temp);
        count(ind) = count(ind) +1; %the number of points in every cluster
        sum(ind,1) = sum(ind,1) + x(j);%the sum of points'x in every cluster
        sum(ind,2) = sum(ind,2) + y(j);%the sum of points'y in every cluster
        class(j) = ind; %the cluster of the data point belongs to -- genggai
    end
    
%recaculate every cluster's centroid
    convergence =1;
    for h = 1:k
        centroid(h,1)= sum(h,1)/count(h);
        centroid(h,2)= sum(h,2)/count(h);
    end
    if(centroid == centroid0)
        iter = i;
        break;
    else
        centroid0 = centroid;
    end
    if (i == iter)
         disp('Iterations have achieved 100 times') 
    end
end

%draw the centroids.
figure,scatter(centroid0(:,1), centroid0(:,2), 'black', 'filled'); 
fprintf('Iterate %d times. \n',iter);

for p = 1:num
    if(class(p) == 1)
        hold on;  scatter(x(p), y(p), 10, 'blue');
    elseif(class(p) ==2)
        hold on;  scatter(x(p), y(p), 10, 'green');
    else
        hold on;  scatter(x(p), y(p), 10, 'red');
    end
end

fprintf('Centroids are: (%d,%d),(%d,%d),(%d,%d)',centroid0(1,1),centroid0(1,2),centroid0(2,1),centroid0(2,2),centroid0(3,1),centroid0(3,2));


