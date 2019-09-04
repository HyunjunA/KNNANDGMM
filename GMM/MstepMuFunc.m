function M_eachMu = MstepMuFunc(A,ric)

clusterKind=size(ric,2);
i=1;
M_eachMu=[];
while i<clusterKind+1
    
     X=dot(A(:,1),ric(:,i));
     Y=dot(A(:,2),ric(:,i));
     mom=sum(ric(:,i));
     temp=[X/mom Y/mom];
     M_eachMu=[M_eachMu; temp ];
     
    i=i+1;

end



end
