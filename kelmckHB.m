function [sigma1,C1,SchTime] = kelmckHB(XTrn,YTrn,C,sigma)                   %[583,200],[583,1],[9783,200],[1,13],[1,8]
[nTrn ,~] = size(XTrn);                             %[583,200],9783
classLabel = unique(YTrn);  nClass = length(classLabel);                   %1:16,16
temp_T = zeros(nClass, nTrn);                                              %0[16��583]
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
T = temp_T*2 - 1;                                                          %��ԭ����1*583��ѵ�����ת����16*583�����޹�Ԫ�ض�Ϊ-1��������ࣩ
%--------------------------5�ؽ�����֤���ҳ�����ʹ������Ϣ���ȴﵽ��ߵ�sigma1��c------------------------------%
tstart = tic;
nfold = 5; nSamfold = floor(nTrn/nfold);                                   %nSamfold =116
nperm = randperm(nTrn);                                                    %һ�����ҵ�1��583������

for i = 1 : nfold                                                          %1:5
    idtst = ((i-1)*nSamfold + 1) : i*nSamfold;                               %1:116;117:232;��465��580
    idtrn = 1 : nTrn; idtrn(idtst) = [];                                   %1��583 117��583 (ɾ��idtstʣ�µľ���idtrn)
    idtst = nperm(idtst);  idtrn = nperm(idtrn);                           %idtst[1,116]ֵ��1��583������У�idtrn[117:583]װʣ�µ�1��583��ֵ
    for p = 1 : length(sigma) %1��8           
        s1 = sigma(p);      
            Kw  = calckernel('rbf', s1, XTrn(idtrn,:), XTrn(idtrn,:));      %����('rbf',2^-6,ȡ[583,200]��117��583�д��ң�ȡ[583,200]��117��583�д���)
            Kwt = calckernel('rbf', s1, XTrn(idtrn,:),  XTrn(idtst,:));     %���루'rbf',2^-6,ȡ[583,200]��117��583�д��ң�ȡ[583,200]��1��116�д��ң�  
            for h = 1 : length(C)                                          %1��13
                cc = C(h);                                                 %2^1                 
                OutputWeight = (eye(length(idtrn))/cc + Kw) \ T(:,idtrn)';  %(E/c+k)\T'              
                TY = (Kwt * OutputWeight)';                                 %��16��116��
                [~,B1] = max(TY,[],1);                                     %A1��TY��ÿ�е����ֵ��B1��ÿ�еĵڼ������            
                Ypre_tst = classLabel(B1);                                 %��B1��������ת�ó�Ϊ������
                cgtmp(p,h) = length(find(YTrn(idtst)==Ypre_tst)) / length(idtst); %����ת�ú����������ԭ����Աȵõ�����         
            end
      
    end   
    cg = cg + cgtmp;                                                       %�����ȸ�ֵ��cg���ۼ�5�Σ�Ȼ��ȡƽ��
end
cg = cg/nfold;
[A,B]=find(cg==max(max(cg)));
sigma1=sigma(A(1));
C1=C(B(1));
SchTime = toc(tstart);
end


