function [overall_accuracy,kappa_accuracy,average_accuracy,class_accuracy,errorMatrix] = calcError( trueLabelling, segLabelling, labels )  
% 计算OA，kppa，AA，CA
% calculates square array of numbers organized in rows and columns which express the
% percentage of pixels assigned to a particular category (in segLabelling) relative
% to the actual category as indicated by reference data (trueLabelling)
% errorMatrix(i,j) = nr of pixels that are of class i-1 and were
% classified as class j-1
% accuracy is essentially a measure of how many ground truth pixels were classified
% correctly (in percentage). 
% average accuracy is the average of the accuracies for each class
% overall accuracy is the accuracy of each class weighted by the proportion
% of test samples for that class in the total training set

% [nrX, nrY] = size(trueLabelling);
% totNrPixels = nrX*nrY;
nrPixelsPerClass = zeros(1,length(labels))';                               %0【16，1】
% nrClasses = length(labels);

errorMatrix = zeros(length(labels),length(labels));                        %0[16,16]
% errorMatrixPerc = zeros(length(labels),length(labels));

for l_true=1:length(labels)                                                %1:16
    tmp_true = find (trueLabelling == (l_true));
    nrPixelsPerClass(l_true) = length(tmp_true);                           %得到测试样本中每一类的数量，再依次赋值给nrPixelsPerClass(
    for l_seg=1:length(labels)                                             %1：16
        tmp_seg = find (segLabelling == (l_seg));                          %找出计算得到的Y中类为1-seg的索引
        nrPixels = length(intersect(tmp_true,tmp_seg));                    %比较理想索引与现实索引，得到相同的数量
        errorMatrix(l_true,l_seg) = nrPixels;  
    end
end

% classWeight = nrPixelsPerClass/totNrPixels;
diagVector = diag(errorMatrix);
class_accuracy = (diagVector./(nrPixelsPerClass));                         %每一个类的精度
average_accuracy = mean(class_accuracy);                                   %类的精度的平均
overall_accuracy = sum(segLabelling == trueLabelling)/length(trueLabelling);%总体相等的精度
kappa_accuracy = (sum(errorMatrix(:))*sum(diag(errorMatrix)) - sum(errorMatrix)*sum(errorMatrix,2))...
    /(sum(errorMatrix(:))^2 -  sum(errorMatrix)*sum(errorMatrix,2));