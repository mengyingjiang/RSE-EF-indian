function [labels, indexs,labelsss,indebbb,indeaaa]=anns(label, index,gt,dAtaspec,stand,wid,p)
nclasses=max(gt(:)); 
[nr,nc]=size(gt);
dim=size(dAtaspec,2);
nall=nr*nc;
w = wid; wc = (w-1)/2;  vv = -wc : wc;
idw0 = repmat(vv*nr,w,1) + repmat(vv',1,w);
idw0 = reshape(idw0,1,w*w);          %[1,25]
indexs=[];labels=[];
labelsss=[];
indebbb=[];indeaaa=[];
for i=1:nclasses
    indes=[];
    neighborofi=[];
    neighborofib=[];
    neighborofia=[];
    inde=index(label==i);
    if length(inde)>stand
       n=length(inde);
       neighborof=inde;
       a=repmat(i,1,n);
       standar=0;
    else 
         standar=stand-length(inde);
        for j=1:length(inde)
            idw=inde(j)+idw0;idw(idw>nall| idw<1) = [];idw(idw==inde(j))=[];
            indes=[indes idw];
        end
        indes=unique(indes);
%         same=intersect(indes,index)
%         for k=1:length(same)
%             indes(indes==same(k))=[];
%         end
        neighborfeature=dAtaspec(indes,:);
        tranfeatures=dAtaspec(inde,:); 
        distmatrix1=zeros(length(inde),length(indes));
        distmatrix1(:,:)=pdist2(tranfeatures,neighborfeature);
%         distmatrix1=tranfeatures*neighborfeature';
        distmatrix1=mean(distmatrix1,1);
        
        [~,b]=sort(distmatrix1);
        indee=indes(b(1:min(length(indes),ceil(standar*1.6))));
        neighborfeature=dAtaspec(indee,:);
        
        tranfeatures1=tranfeatures;
%         distmatrix=zeros(size(tranfeatures1,1),length(indee));
        distmatrix1=pdist2(tranfeatures1,neighborfeature);
        distmatrix1=mean(distmatrix1,1); 
         distmatrix2=pdist2(neighborfeature,neighborfeature);
          distmatrix2=mean(distmatrix2,1); 
        distmatrix=distmatrix1+p*distmatrix2;
        distmatrix=mean(distmatrix,1);  
        [~,b]=sort(distmatrix,'descend');
        [~,bb]=sort(distmatrix);

        a=repmat(i,1,stand);
        neighborofib=indee(bb(1:standar)); 
        neighborofia=indee(1:standar);    
        neighborof=[neighborofib inde];
    end
   
    indebbb=[indebbb neighborofib];
    indeaaa=[indeaaa neighborofia];
    labelsss=[labelsss repmat(i,1,standar)];
    indexs=[indexs neighborof];
    labels=[labels a];
end

end

      