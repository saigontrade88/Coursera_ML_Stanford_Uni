function [C, sigma] = dataset3Params(X, y, Xval, yval)
% DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
% where you select the optimal (C, sigma) learning parameters to use for SVM
% with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C_list = [0.01; 0.03; 0.1; 0.3; 1; 3; 10; 30];
sigma_list = [0.01; 0.03; 0.1; 0.3; 1; 3; 10; 30];

C = 0.01;
sigma = 0.01;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

results = [];

for c_test = 1:length(C_list)
    for s_test = 1:length(sigma_list)
        
        %Train the model using svmTrain with X, y, a value for C, and the gaussian kernel using a value for sigma. 
        % See ex6.m at line 108 for an example of the correct syntax to use in calling svmTrain() and the gaussian kernel. 
        % Note: Use temporary variables for C and sigma when you call svmTrain(). 
        % Only use 'C' and 'sigma' for the final values you are going to return from the function.
        
        err_value = 0;
        
        model= svmTrain(X, y, C_list(c_test), @(x1, x2) gaussianKernel(x1, x2, sigma_list(s_test))); 
              
        %predictions is a vector containing all the predictions from the SVM
        predictions = svmPredict(model, Xval);
        
        %Compute the error between your predictions and yval.
        err_value = mean(double(predictions ~= yval));
        
        %fprintf("The error of this model, C = %f, sigma = %f is %f\n", c, s, mean(double(predictions ~= yval)));
        
        results = [results; C_list(c_test) sigma_list(s_test) err_value];
              
    end
end

results

% use min() to find the row with the minimum error
[v row_index] = min(results(:,3));

v;

row_index;


C = results(row_index,1)

sigma = results(row_index,2)


% =========================================================================

end
