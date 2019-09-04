function EMalgorithm(A)

%Randomly initial parameters seting (M-step)
%%% 3 phi setting
eachPhi=[50/150,50/150,50/150];
%%% 3 Mu setting
eachMu=[-1 0.9;3.7 2;6 3];
%eachMu=[0 0;-3 -2;6 9];
%%% 3 sigma setting
n=2;
eachSigma=[];
eachSigma=eye(2);
check=0;
while n<4 
    eachSigma(:,:,n)=eye(2)*2;
    n=n+1;
end

%%%Until parameters converge 
while 1
    %Assignment step
    index=1;
    clusterKind=1;
    
    %ric
    ric=[];
    
%E-step
    while index<151
        decision=[];

        while clusterKind<4
            %A(index,:)
            y = mvnpdf(A(index,:),eachMu(clusterKind,:),eachSigma(:,:,clusterKind))*eachPhi(clusterKind);
            decision=[decision,y];
            clusterKind=clusterKind+1;

        end
        
        sumDecision=sum(decision);
        decision=decision/sumDecision;
       
        ric=[ric; decision];

        B(index,1)=find(decision == max(decision(:)));
        B(index,2)=max(decision(:));
        
        clusterKind=1;
        index=index+1;
    end
%E-step end
    index=1;
    clusterKind=1;
    
    
   
    indexR=1;
    C1=[];
    C2=[];
    C3=[];
    while indexR<151
        if B(indexR,1)==1
            C1=[C1;A(indexR,:), B(indexR,2)];
        end
        if B(indexR,1)==2
            C2=[C2;A(indexR,:), B(indexR,2)];
        end
        if B(indexR,1)==3
            C3=[C3;A(indexR,:), B(indexR,2)];
        end


        indexR=indexR+1;
    end

% M-step
    
    eachMu = MstepMuFunc(A,ric);
 
    eachSigma(:,:,1)=MstepSigmaFunc(A,eachMu(1,:),ric(:,1));
    eachSigma(:,:,2)=MstepSigmaFunc(A,eachMu(2,:),ric(:,2));
    eachSigma(:,:,3)=MstepSigmaFunc(A,eachMu(3,:),ric(:,3));
    
    eachPhi=[sum(ric(:,1))/150, sum(ric(:,2))/150, sum(ric(:,3))/150];
    
    
    if check==1
        if beforeEachMu==eachMu
            name0='* EM algorithm';
            disp(name0);
            
            name1='- Mean';
            disp(name1);
            disp(eachMu);
            
            name2='- Covariance';
            disp(name2);
            disp(eachSigma);
            
            name3='- Amplitude';
            disp(name3);
            disp(eachPhi);
            
            

            
            figure 
            plot(C1(:,1),C1(:,2),'.r','MarkerSize',10);
            title('EM algorithm')
            hold on
            plot(eachMu(1,1),eachMu(1,2),'-mo','MarkerFaceColor','m','MarkerSize',5);
            hold on
            plot(C2(:,1),C2(:,2),'.g','MarkerSize',10);
            hold on
            plot(eachMu(2,1),eachMu(2,2),'-mo','MarkerFaceColor','m','MarkerSize',5);
            hold on
            plot(C3(:,1),C3(:,2),'.b','MarkerSize',10);
            hold on
            plot(eachMu(3,1),eachMu(3,2),'-mo','MarkerFaceColor','m','MarkerSize',5);
            hold on
            
            
            
%             x=A(:,1);
%             y=A(:,2);
%             [X,Y]=meshgrid(x,y);
% 
%             z=exp(-(X.^2+Y.^2)/2);
%             surf(x,y,z);shading interp
            
%%%%%%%%%%%%%%%%%%%%%%%%%%%
            mu = eachMu(1,:);
            sigma = eachSigma(:,:,1);
            rng default  % For reproducibility
            r = mvnrnd(mu,sigma,1000);
            
            
     
            
            

            mu = eachMu(1,:);
            Sigma = eachSigma(:,:,1);
            x1 = -5:.1:10; x2 = -4:.1:10;
            [X1,X2] = meshgrid(x1,x2);
            F = mvnpdf([X1(:) X2(:)],mu,Sigma);
            F = reshape(F,length(x2),length(x1));
            surf(x1,x2,F,'FaceAlpha',.15);
            caxis([min(F(:))-.5*range(F(:)),max(F(:))]);
            axis([-5 10 -4 10 0 .2])
            xlabel('x'); ylabel('y'); zlabel('Probability Density');
            hold on


            mu = eachMu(2,:);
            Sigma = eachSigma(:,:,2);
            x1 = -5:.1:10; x2 = -4:.1:10;
            [X1,X2] = meshgrid(x1,x2);
            F = mvnpdf([X1(:) X2(:)],mu,Sigma);
            F = reshape(F,length(x2),length(x1));
            surf(x1,x2,F,'FaceAlpha',.15);
            caxis([min(F(:))-.5*range(F(:)),max(F(:))]);
            axis([-5 10 -4 10 0 .2])
            xlabel('x'); ylabel('y'); zlabel('Probability Density');
            hold on
            
            
            
            mu = eachMu(3,:);
            Sigma = eachSigma(:,:,3);
            x1 = -5:.1:10; x2 = -4:.1:10;
            [X1,X2] = meshgrid(x1,x2);
            F = mvnpdf([X1(:) X2(:)],mu,Sigma);
            F = reshape(F,length(x2),length(x1));
            surf(x1,x2,F,'FaceAlpha',.15);
            caxis([min(F(:))-.5*range(F(:)),max(F(:))]);
            axis([-5 10 -4 10 0 .2])
            xlabel('x'); ylabel('y'); zlabel('Probability Density');
            
            
            
            set(gca,'zticklabel',{[]}) 
            
            
%             figure
%             plot(r(:,1),r(:,2),'+')
%             hold on
%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %%%%%%%%%%%%%%%%%%%%%%%%%%%
%             mu = eachMu(2,:);
%             sigma = eachSigma(:,:,2);
%             rng default  % For reproducibility
%             r = mvnrnd(mu,sigma,1000);
%             
%             y = mvnpdf(r,mu,sigma)
%             
%             plot(r(:,1),r(:,2),'+')
%             hold on
%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             mu = eachMu(3,:);
%             sigma = eachSigma(:,:,3);
%             rng default  % For reproducibility
%             r = mvnrnd(mu,sigma,1000);
%             
%             y = mvnpdf(r,mu,sigma)
%             
%             plot(r(:,1),r(:,2),'+')
%             hold on
%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            
            
  
            
            
            
            
            
            break;
            
        end
        
    end
    check=1;
    beforeEachMu=eachMu;
    
    

    
%     Cluster 내에서 구한것들    
%     eachMu=[weightedMu(C1);weightedMu(C2);weightedMu(C3)];
%    
%     eachSigma(:,:,1)=weightedSigma(C1, eachMu(1,:));
%     eachSigma(:,:,2)=weightedSigma(C2, eachMu(2,:));
%     eachSigma(:,:,3)=weightedSigma(C3, eachMu(3,:));
%     
%     
%     eachPhi=[sum(C1(:,3))/150, sum(C2(:,3))/150, sum(C3(:,3))/150];
%     Cluster 내에서 구한것들   end
   
    
    
    
end








