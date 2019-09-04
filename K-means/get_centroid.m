%function: get the initial clustering centroids
%input:  k(the number of clusters), x-coordinates of data points,
%input:  y-coordinates of data points
%output: the initial clustering centroids

function [centroid0] = get_centroid(k,x,y)

%get the number of data points
num = length(x); 

%initiate the sum of distances of all points and the matrix of distances.
sum_dist = 0;
dist = zeros(num,num);

%initiate the vector of the sequence number of centroids in data points.
max_num = zeros(k,1);
%initiate the symmertic matrix of relationship between data points.
dist_flag = zeros(num,num);
%initiate the centroids.
centroid0 = zeros(k,2);

%get the average distance between data points.
for i = 1:num
    for j = 1:num
        dist(i,j) = abs(x(i)-x(j))+abs(y(i)-y(j));
        sum_dist = sum_dist + dist(i,j);
    end
end
avg_dist = sum_dist/(num*num-num);
%set the threshold's value.
threshold = avg_dist/2;

%get the symmertic matrix of relationship between data points.
for i = 1:num
    for j = 1:num
        if dist(i,j) <= threshold
            dist_flag(i,j) = 1;
        else
            dist_flag(i,j) = 0;
        end
    end
end

%get centroids.
for w = 1:k
    %calculate the sum of every row vector
    judge_value = zeros(num,1);
    for i = 1:num
        for j = 1:num
        judge_value(i) = judge_value(i) + dist_flag(i,j);
        end
    end
    %get the sequence number of centroids.
    [max_value,max_num(w)]=max(judge_value);
    
    centroid0(w,1) = x(max_num(w));
    centroid0(w,2) = y(max_num(w));
  %eliminate the influence of clusters we have found
  for i = 1:num
     if dist_flag(max_num(w),i) == 1
         dist_flag(i,:) = 0;
         dist_flag(:,i) = 0;
     end
 end

end
