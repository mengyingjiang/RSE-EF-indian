clear all
load Indian
load Indian_gt 
[nr,nc,dim]=size(image);
nall=nr*nc;
n_class = max(GT(:));
%% 归一化 
data=reshape(image,nall,dim)./max(image(:));
image=image./max(image(:));
%%  超参数设置
C=[10^0 10^1 10^2 10^3 10^4 10^5];
sigma=[2^(-4),2^(-3),2^(-2),2^(-1),2^(0),2^(1),2^(2),2^(3),2^(4)];
nadd=20;
wid=5;
n_times = 10;
%% 给分类结果预留空间
OA1=zeros(n_times,1);
kappa1=zeros(n_times ,1);
AA1=zeros(n_times ,1);
CA1=zeros(n_class,10);
%%
dim_sub=90;% 子空间维数
dim_MNF=20;
N_sub=6; %子空间个数
window=9; %9 for indian ,7 for Houston 
sigmapca=0.5; % 0.0625 for dataspec; 0.5 for data
dim_Gauss=50;
new_fea=creat_enh_fea(image,dim,dim_sub,dim_MNF,N_sub,window,sigmapca,dim_Gauss);
[~,~,N] = size(new_fea);

for j=1:n_times 
    [images, YTrn, indexs] = loadtrain1(image,GT,0.05);                            %得到训练样本
    [testImages, testLabels, testIndexs,tempimg,maxmum] = loadtest(image,GT,indexs);          %得到测试样本
    [ YTrn, indexs,labelsss,indebbb,indeaaa]=anns(YTrn',indexs,GT,data,nadd,wid,0.3);
    p1 = zeros(n_class,length(testLabels),N);
    for k=1:N       
        XTrn1=new_fea(indexs,:,k);
        XTst1=new_fea(testIndexs,:,k);
        [sigma1,C1] = kelmckHB(XTrn1,YTrn',C,sigma);
        [~,p1(:,:,k)] =elmHBCK(XTrn1,XTst1,YTrn,C1,sigma1);
    end
    P1=sum(p1,3);
    [~,pred11]=max(P1);
    pred1=zeros(nr,nc);
    pred1(testIndexs)=pred11;
    pred1(indexs)=YTrn;
   
    [OA1(j),kappa1(j),AA1(j),CA1(:,j)]=calcError(testLabels,pred1(testIndexs),1:n_class)
end

oa1=mean(OA1)
stdoa1=std(OA1)
aa1=mean(AA1)
stdaa1=std(AA1)
KAPPA1=mean( kappa1)
stdKAPPA1=std( kappa1)
stdca1=std(CA1')
ca1=mean(CA1')

% figure
% imagesc(pred2)
% axis off
