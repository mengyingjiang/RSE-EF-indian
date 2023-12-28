%function [Ktrn,Ktst,B] =elmHBCK(XTrn,XTst,XTrnm,XTstm,YTrn,L,mu,C,sigma1,sigma2)    
function [pred,p] =elmHBCK(XTrn,XTst,YTrn,C1,sigma1)  
[nTrn,~] = size(XTrn); 
classLabel = unique(YTrn);  nClass = length(classLabel);
temp_T = zeros(nClass, nTrn);
for i = 1 : nTrn
    for j = 1 : nClass
        if classLabel(j) == YTrn(i)
            break;
        end
    end
    temp_T(j,i) = 1;
end
T = temp_T*2 - 1;
clear i j                        
newktrn=calckernel('rbf', sigma1, XTrn, XTrn);                                  %[nTrn,nTrn]kw
% newktst=zeros(nTst,nTrn);
% newktrn=zeros(nTrn,nTrn);
% for i=1:nTrn
%     neibors=neibindex(indexs(i),:); neibors(neibors==0)=[];
%     weight=neibweight(indexs(i),:); weight(weight==0)=[];
%     newktrn(i,:)=(1-U)*kw(indexs(i),:)+U*((weight/sum(weight))*kw(neibors,:));
% end
% newktrn=kw(indexs,:);
% for i=1:nTst
%     neibors=neibindex(testindexs(i),:); neibors(neibors==0)=[];
%     weight=neibweight(testindexs(i),:); weight(weight==0)=[];
%     newktst(i,:)=(1-U)*kw(testindexs(i),:)+U*((weight/sum(weight))*kw(neibors,:));
% end
newktst=calckernel('rbf', sigma1, XTrn, XTst);
B=(eye(nTrn)./C1 + newktrn)\T';
% TrnTime = toc(tstart);
% kx=kw(testindexs,:);
p=B'*newktst';
[~,pred]=max(p);
% TstTime = toc(tstart);



end

                                                         %找出结果中每列的最大值的行号赋值给pred
