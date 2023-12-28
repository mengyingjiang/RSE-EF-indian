function [newdatas]=neighborhood(data,dAtaspec,wid,nr,gamma0)
w = wid; wc = (w-1)/2;  vv = -wc : wc;
idw0 = repmat(vv*nr,w,1) + repmat(vv',1,w);
idw0 = reshape(idw0,1,w*w);          %[1,25]
[lenth,dim]=size(data);
newdatas=zeros(lenth,dim);
for i=1:lenth
        idw = idw0 + i;
        idw(idw>lenth | idw<1) = [];     %idw中存放的是indexs[i]周围的元素的地址
        dtmp = repmat(dAtaspec(i,:),length(idw),1) - dAtaspec(idw,:);
        A = sum(dtmp.*dtmp, 2);
        wei = exp(-gamma0*A);
        newdatas(i,:) = 1/sum(wei) * sum(diag(wei)*data(idw,:),1);
        
end
end