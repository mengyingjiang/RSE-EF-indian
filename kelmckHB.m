function [sigma1,C1,SchTime] = kelmckHB(XTrn,YTrn,C,sigma)                   %[583,200],[583,1],[9783,200],[1,13],[1,8]
[nTrn ,~] = size(XTrn);                             %[583,200],9783
classLabel = unique(YTrn);  nClass = length(classLabel);                   %1:16,16
temp_T = zeros(nClass, nTrn);                                              %0[16，583]
cgtmp=double(zeros(length(sigma),length(C)));
cg=double(zeros(length(sigma),length(C)));
for i = 1 : nTrn
    for j = 1 : nClass
        if classLabel(j) == YTrn(i)
            break;
        end
    end
    temp_T(j,i) = 1;
end
T = temp_T*2 - 1;                                                          %将原来的1*583的训练结果转化成16*583，且无关元素都为-1（拉开差距）
%--------------------------5重交叉验证，找出可以使光谱信息精度达到最高的sigma1和c------------------------------%
tstart = tic;
nfold = 5; nSamfold = floor(nTrn/nfold);                                   %nSamfold =116
nperm = randperm(nTrn);                                                    %一个打乱的1：583的数组

for i = 1 : nfold                                                          %1:5
    idtst = ((i-1)*nSamfold + 1) : i*nSamfold;                               %1:116;117:232;…465：580
    idtrn = 1 : nTrn; idtrn(idtst) = [];                                   %1：583 117：583 (删掉idtst剩下的就是idtrn)
    idtst = nperm(idtst);  idtrn = nperm(idtrn);                           %idtst[1,116]值从1到583随机排列；idtrn[117:583]装剩下的1到583的值
    for p = 1 : length(sigma) %1：8           
        s1 = sigma(p);      
            Kw  = calckernel('rbf', s1, XTrn(idtrn,:), XTrn(idtrn,:));      %输入('rbf',2^-6,取[583,200]的117到583行打乱，取[583,200]的117到583行打乱)
            Kwt = calckernel('rbf', s1, XTrn(idtrn,:),  XTrn(idtst,:));     %输入（'rbf',2^-6,取[583,200]的117到583行打乱，取[583,200]的1：116行打乱）  
            for h = 1 : length(C)                                          %1：13
                cc = C(h);                                                 %2^1                 
                OutputWeight = (eye(length(idtrn))/cc + Kw) \ T(:,idtrn)';  %(E/c+k)\T'              
                TY = (Kwt * OutputWeight)';                                 %【16，116】
                [~,B1] = max(TY,[],1);                                     %A1是TY中每列的最大值，B1是每列的第几行最大            
                Ypre_tst = classLabel(B1);                                 %将B1从行向量转置成为列向量
                cgtmp(p,h) = length(find(YTrn(idtst)==Ypre_tst)) / length(idtst); %将会转置后的列向量与原矩阵对比得到精度         
            end
      
    end   
    cg = cg + cgtmp;                                                       %将精度赋值给cg，累加5次，然后取平均
end
cg = cg/nfold;
[A,B]=find(cg==max(max(cg)));
sigma1=sigma(A(1));
C1=C(B(1));
SchTime = toc(tstart);
end


