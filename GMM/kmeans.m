load 'clusters.txt';
k = 3;
x = clusters(:,1);
y = clusters(:,2);

num = length(clusters(:,1));


% Initiate the centroids
eachMu=[-1 0.9;3.7 2;6 3];
centroid0=eachMu;
% centroid0 = zeros(k,2);
centroid = zeros(k,2);
r = randperm(num);
% for c =1:k
%     centroid0(c,:) = clusters(r(c),:);
% end

iter = 100;
temp = zeros(k,1);
class = zeros(num,1);
% PRECISION = 0.0001;
for i = 1:iter
    sum = zeros(k,2);
    count = zeros(k,1);


    for j = 1:num
        for z = 1:k
            temp(z,1)=sqrt((centroid0(z,1)-x(j)).^2+(centroid0(z,2)-y(j)).^2);
        end
        [minx, ind] = min(temp);
        count(ind) = count(ind) +1;
        sum(ind,1) = sum(ind,1) + x(j);
        sum(ind,2) = sum(ind,2) + y(j);
        class(j) = ind;
    end
    
    convergence =1;
    for h = 1:k
        centroid(h,1)= sum(h,1)/count(h);
        centroid(h,2)= sum(h,2)/count(h);
    end
    if(centroid == centroid0)
        iter = i;
        break;
    else
%         fprintf('%s,%s\n',centroid(1,1) - centroid0(1,1),centroid(1,2) - centroid0(1,2));
%         fprintf('\n');
        centroid0 = centroid;
    end
    if (i == iter)
         disp('Iterations have achieved 5000 times');
    end
end
scatter(centroid0(:,1), centroid0(:,2), 'red', 'filled'); %centroids
%fprintf('Iterate %s times. \n',iter);
%disp(iter);

for p = 1:num
    if(class(p) == 1)
        hold on;  scatter(x(p), y(p), 10, 'blue');
        title('K-means');
    elseif(class(p) ==2)
        hold on;  scatter(x(p), y(p), 10, 'green');
    else
        hold on;  scatter(x(p), y(p), 10, 'black');
    end
end

%fprintf('Centroids are: (%s,%s),(%s,%s),(%s,%s)',centroid0(1,1),centroid0(1,2),centroid0(2,1),centroid0(2,2),centroid0(3,1),centroid0(3,2));
name0='* K-means clustering';
disp(name0);

name1='- Mean';
disp(name1);
disp(centroid0);

