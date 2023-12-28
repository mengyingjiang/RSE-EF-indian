function [images, labels, indexs,tempimg,maxmun] = loadtest(img, gt,trainindexs)
% 生成实验1的测试样本
imgsize = size(img);
num = imgsize(1)*imgsize(2);     %20245
indexs = [];
gt(trainindexs)=0;             %gt145*145

for i = 1 : num                  %1:20245
    if gt(i) ~= 0
        indexs = [indexs; i];      %把类不是0的地址存进indexs
    end
end

labels = gt(indexs);
[nr,nc,ndim]=size(img);
nall=nr*nc;
tempimg = reshape(img, nall,ndim);
maxmun=max(tempimg(:));
images = tempimg(indexs,:);
images = double(images'./65517);
%  images1 = images./ repmat(sqrt(sum(images.*images,2)),[1 200]);
%  images2=images1';
end