function [bestEpsilon bestF1] = selectThreshold(yval, pval)
%SELECTTHRESHOLD Find the best threshold (epsilon) to use for selecting
%outliers
%   [bestEpsilon bestF1] = SELECTTHRESHOLD(yval, pval) finds the best
%   threshold to use for selecting outliers based on the results from a
%   validation set (pval) (probability) and the ground truth (yval) (label).
%

bestEpsilon = 0;
bestF1 = 0;

F1 = 0;


% Useful variables
[mCV, nCV] = size(yval);

%cvPredictions = zero(mCV, 1);

% Confusion matrix elements
cvTp = 0;

cvFp = 0;

cvFn = 0;

stepsize = (max(pval) - min(pval)) / 1000;
for epsilon = min(pval):stepsize:max(pval)
    
    % ====================== YOUR CODE HERE ======================
    % Instructions: Compute the F1 score of choosing epsilon as the
    %               threshold and place the value in F1. The code at the
    %               end of the loop will compare the F1 score for this
    %               choice of epsilon and set it to be the best epsilon if
    %               it is better than the current choice of epsilon.
    %               
    % Note: You can use predictions = (pval < epsilon) to get a binary vector
    %       of 0's and 1's of the outlier predictions

    % Determine the positive(outlier) examples
    
    cvPredictions = (pval < epsilon);
    
    % Compute the confusion matrix
    
    cvFp = sum((cvPredictions == 1) & (yval == 0));
    
    cvTp = sum((cvPredictions == 1) & (yval == 1));
    
    cvFn = sum((cvPredictions == 0) & (yval == 1));
    
    cvRecall = cvTp/(cvTp + cvFn);
    
    cvPrecision = cvTp/(cvTp + cvFp);
    
    % Compute the F1 score
    
    cvF1 = (2*cvPrecision*cvRecall)/(cvPrecision + cvRecall);
    
    F1 = cvF1;
    % =============================================================

    if F1 > bestF1
       bestF1 = F1;
       bestEpsilon = epsilon;
    end
end

end
