function M_eachSigma = MstepSigmaFunc(A,M_eachMu,one_ric)

deviation=[];
devSize=size(A,1);
i=1;
mom=0;
deviation=A-M_eachMu;
while i<devSize+1
    
     
     mom=mom+deviation(i,:)'*deviation(i,:)*one_ric(i);

     
     
    i=i+1;

end

son=sum(one_ric);
M_eachSigma=mom/son;