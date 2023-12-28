function [new_fea]=creat_enh_fea(image,dim_fea,dim_sub,dim_MNF,N_sub,window,sigmapca,dim_Gauss)
[nr,nc,dim]=size(image);
nall=nr*nc;
data=reshape(image,nall,dim);
U1=normrnd(0,5, dim_MNF, dim_Gauss);
[X_spatial]=neighborhood(data,data,window,nr,sigmapca);
X_spatial=reshape(X_spatial,nr,nc,dim_fea);
new_fea=zeros(nall,dim_Gauss,N_sub);
for i=1:N_sub
    a=randperm(dim);
    b=a(1:dim_sub);
    [fea_MNF]  = fun_MyMNF(X_spatial(:,:,b),dim_MNF);
    fea_MNF=reshape(fea_MNF,nall,dim_MNF);
    new_fea(:,:,i)=fea_MNF*U1;
end
save new_fea