load 'clusters.txt';
k = 3;

opts = statset('Display','final');
[Idx,Ctrs] = kmeans(clusters,3,'Start','sample');

% [Idx,Ctrs] = kmeans(clusters,3,'Start','cluster','Options',opts);
% [Idx,Ctrs] = kmeans(clusters,3,'Distance','correlation','Options',opts);

figure;
plot(clusters(Idx==1,1),clusters(Idx==1,2),'r.','MarkerSize',10)
hold on
plot(clusters(Idx==2,1),clusters(Idx==2,2),'b.','MarkerSize',10)
hold on
plot(clusters(Idx==3,1),clusters(Idx==3,2),'g.','MarkerSize',10)

plot(Ctrs(:,1),Ctrs(:,2),'black.','MarkerSize',20,'LineWidth',20)
% title('correlation')
legend('Cluster 1','Cluster 2','Cluster 3','Centroids','Location','NW')

Ctrs
