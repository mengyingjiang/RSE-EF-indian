function [images, labels, indexs] = loadtrain1(img, gt,nsec)
% ����ʵ��1��ѵ������
indexs = [];
% labels = [];
a=zeros(16,1);
for j=1:16
    a(j)=length(find(gt==j));
end
for i = 1 : 16
%      nuse = min(nsec, round(a(i)/2) ); 
      nuse = ceil(a(i)*nsec);
    switch i
%         case 1
%             tempindex = find(gt == 1);
%             tempindex=tempindex';                          %tempindex��������
%             rp=randperm(length(tempindex));                %���ظ����������1-length��tempindex��
%             indexs=[indexs tempindex(rp(1: 548))];           %���ѡ6������1�ĵ�ַ��ֵ��indexs
%         case 2
%             tempindex = find(gt == 2);
%             tempindex=tempindex';
%             rp=randperm(length(tempindex));
%             indexs=[indexs tempindex(rp(1:540))];
%         case 3
%             tempindex = find(gt == 3);
%             tempindex=tempindex';
%             rp=randperm(length(tempindex));
%             indexs=[indexs tempindex(rp(1: 392))];
%         case 4
%             tempindex = find(gt == 4);
%             tempindex=tempindex';
%             rp=randperm(length(tempindex));
%             indexs=[indexs tempindex(rp(1: 542))];
%         case 5
%             tempindex = find(gt == 5);
%             tempindex=tempindex';
%             rp=randperm(length(tempindex));
%             indexs=[indexs tempindex(rp(1: 265))];
%         case 6
%             tempindex = find(gt == 6);
%             tempindex=tempindex';
%             rp=randperm(length(tempindex));
%             indexs=[indexs tempindex(rp(1: 532))];
%         case 7
%             tempindex = find(gt == 7);
%             tempindex=tempindex';
%             rp=randperm(length(tempindex));
%             indexs=[indexs tempindex(rp(1: 375))];
%         case 8
%             tempindex = find(gt == 8);
%             tempindex=tempindex';
%             rp=randperm(length(tempindex));
%             indexs=[indexs tempindex(rp(1: 514))];
%         case 9
%             tempindex = find(gt == 9);
%             tempindex=tempindex';
%             rp=randperm(length(tempindex));
%              indexs=[indexs tempindex(rp(1: 231))];

        case 1
            tempindex = find(gt == 1);
            tempindex=tempindex';
            rp=randperm(length(tempindex));
             indexs=[indexs tempindex(rp(1: nuse))];
        case 2
            tempindex = find(gt == 2);
            tempindex=tempindex';
            rp=randperm(length(tempindex));
             indexs=[indexs tempindex(rp(1: nuse))];
        case 3
            tempindex = find(gt == 3);
            tempindex=tempindex';
            rp=randperm(length(tempindex));
             indexs=[indexs tempindex(rp(1: nuse))];
         case 4
            tempindex = find(gt == 4);
            tempindex=tempindex';
            rp=randperm(length(tempindex));
             indexs=[indexs tempindex(rp(1: nuse))];
        case 5
            tempindex = find(gt == 5);
            tempindex=tempindex';
            rp=randperm(length(tempindex));
             indexs=[indexs tempindex(rp(1: nuse))];
        case 6
            tempindex = find(gt == 6);
            tempindex=tempindex';
            rp=randperm(length(tempindex));
             indexs=[indexs tempindex(rp(1: nuse))];
        case 7
            tempindex = find(gt == 7);
            tempindex=tempindex';
            rp=randperm(length(tempindex));
             indexs=[indexs tempindex(rp(1: nuse))];
         case 8
            tempindex = find(gt == 8);
            tempindex=tempindex';
            rp=randperm(length(tempindex));
             indexs=[indexs tempindex(rp(1: nuse))];
         case 9
            tempindex = find(gt == 9);
            tempindex=tempindex';
            rp=randperm(length(tempindex));
             indexs=[indexs tempindex(rp(1: nuse+1))];
        case 10
            tempindex = find(gt == 10);
            tempindex=tempindex';
            rp=randperm(length(tempindex));
             indexs=[indexs tempindex(rp(1: nuse))];
        case 11
            tempindex = find(gt == 11);
            tempindex=tempindex';
            rp=randperm(length(tempindex));
             indexs=[indexs tempindex(rp(1: nuse))];
        case 12
            tempindex = find(gt == 12);
            tempindex=tempindex';
            rp=randperm(length(tempindex));
             indexs=[indexs tempindex(rp(1: nuse))];
         case 13
            tempindex = find(gt == 13);
            tempindex=tempindex';
            rp=randperm(length(tempindex));
             indexs=[indexs tempindex(rp(1: nuse))];
          case 14
            tempindex = find(gt == 14);
            tempindex=tempindex';
            rp=randperm(length(tempindex));
             indexs=[indexs tempindex(rp(1: nuse))];
          case 15
            tempindex = find(gt == 15);
            tempindex=tempindex';
            rp=randperm(length(tempindex));
             indexs=[indexs tempindex(rp(1: nuse))];
          case 16
            tempindex = find(gt == 16);
            tempindex=tempindex';
            rp=randperm(length(tempindex));
             indexs=[indexs tempindex(rp(1: nuse))];    
%         case 1
%             tempindex = find(gt == 1);
%             tempindex=tempindex';                          %tempindex��������
%             rp=randperm(length(tempindex));                %���ظ����������1-length��tempindex��
%              indexs=[indexs tempindex(rp(1:6))];           %���ѡ6������1�ĵ�ַ��ֵ��indexs
%         case 2
%             tempindex = find(gt == 2);
%             tempindex=tempindex';
%             rp=randperm(length(tempindex));
%             indexs=[indexs tempindex(rp(1:144))];
%         case 3
%             tempindex = find(gt == 3);
%             tempindex=tempindex';
%             rp=randperm(length(tempindex));
%             indexs=[indexs tempindex(rp(1:84))];
%         case 4
%             tempindex = find(gt == 4);
%             tempindex=tempindex';
%             rp=randperm(length(tempindex));
%             indexs=[indexs tempindex(rp(1:24))];
%         case 5
%             tempindex = find(gt == 5);
%             tempindex=tempindex';
%             rp=randperm(length(tempindex));
%             indexs=[indexs tempindex(rp(1:50))];
%         case 6
%             tempindex = find(gt == 6);
%             tempindex=tempindex';
%             rp=randperm(length(tempindex));
%             indexs=[indexs tempindex(rp(1:75))];
%         case 7
%             tempindex = find(gt == 7);
%             tempindex=tempindex';
%             rp=randperm(length(tempindex));
%             indexs=[indexs tempindex(rp(1:3))];
%         case 8
%             tempindex = find(gt == 8);
%             tempindex=tempindex';
%             rp=randperm(length(tempindex));
%             indexs=[indexs tempindex(rp(1:49))];
%         case 9
%             tempindex = find(gt == 9);
%             tempindex=tempindex';
%             rp=randperm(length(tempindex));
%              indexs=[indexs tempindex(rp(1:2))];
%         case 10
%             tempindex = find(gt == 10);
%             tempindex=tempindex';
%             rp=randperm(length(tempindex));
%              indexs=[indexs tempindex(rp(1:97))];
%         case 11
%             tempindex = find(gt == 11);
%             tempindex=tempindex';
%             rp=randperm(length(tempindex));
%              indexs=[indexs tempindex(rp(1:247))];
%         case 12
%             tempindex = find(gt == 12);
%             tempindex=tempindex';
%             rp=randperm(length(tempindex));
%              indexs=[indexs tempindex(rp(1:62))];
%          case 13
%             tempindex = find(gt == 13);
%             tempindex=tempindex';
%             rp=randperm(length(tempindex));
%              indexs=[indexs tempindex(rp(1:22))];
%           case 14
%             tempindex = find(gt == 14);
%             tempindex=tempindex';
%             rp=randperm(length(tempindex));
%              indexs=[indexs tempindex(rp(1:130))];
%           case 15
%             tempindex = find(gt == 15);
%             tempindex=tempindex';
%             rp=randperm(length(tempindex));
%              indexs=[indexs tempindex(rp(1:38))];
%           case 16
%             tempindex = find(gt == 16);
%             tempindex=tempindex';
%             rp=randperm(length(tempindex));
%              indexs=[indexs tempindex(rp(1:10))];    
    end
end



labels = gt(indexs);
labels = double(labels);

[nr,nc,ndim]=size(img);
nall=nr*nc;
tempimg=reshape(img,nall,ndim);        
% bandmaxvalue=max(tempimg(:));                           %������21025*200�������ֵ
images = (tempimg(indexs, :))';                         %ɸѡ�����õ�һ��1043*200��ѵ������       

             %��ѵ������ת���ٳ������ֵ���õ���0-1����200*1043ѵ������
%         images1= images./ repmat(sqrt(sum(images.*images,2)),[1 200]); 
%         images2=images1';


end