function [X_norm, mu, sigma] = featureNormalize(X)
%   FEATURENORMALIZE Normalizes the features in X 
%   FEATURENORMALIZE(X) returns a normalized version of X where
%   the mean value of each feature is 0 and the standard deviation
%   is 1. This is often a good preprocessing step to do when
%   working with learning algorithms.

% You need to set these values correctly
X_norm = X;
mu = zeros(1, size(X, 2)); % matrix containing the mean values of each feature, size(X, 2): # columns of X
sigma = zeros(1, size(X, 2)); % matrix containing the standard deviation values of each feature

% ====================== YOUR CODE HERE ======================
% Instructions: First, for each feature dimension, compute the mean
%               of the feature and subtract it from the dataset,
%               storing the mean value in mu. Next, compute the 
%               standard deviation of each feature and divide
%               each feature by it's standard deviation, storing
%               the standard deviation in sigma. 
%
%               Note that X is a matrix where each column is a 
%               feature and each row is an example. You need 
%               to perform the normalization separately for 
%               each feature. 
%
% Hint: You might find the 'mean' and 'std' functions useful.
%       

mu = mean(X) % return the row vector 

sigma = std(X) % return the row vector

m = size(X, 1) ;          % returns the number of rows in X: 1 means the first dimension of X

mu_matrix = ones(m, 1)*mu;

sigma_matrix = ones(m, 1)*sigma;

X_norm = X_norm - mu;

X_norm = X_norm ./ sigma

% ============================================================

end
