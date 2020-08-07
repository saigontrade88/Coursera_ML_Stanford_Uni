function idx = findClosestCentroids(X, centroids)
%  FINDCLOSESTCENTROIDS computes the centroid memberships for every example
%   idx = FINDCLOSESTCENTROIDS (X, centroids) returns the closest centroids
%   in idx for a dataset X where each row is a single example. idx = m x 1 
%   vector of centroid assignments (i.e. each entry in range [1..K])
%

% 'm' is the number of training examples
% 'n' is the number of features


m = size(X, 1);
n = size(X, 2);

% Set K, K is the number of centroids
K = size(centroids, 1);

fprintf("Dimension of centroids %d x %d", K, size(centroids, 2))

% You need to return the following variables correctly.
idx = zeros(size(X,1), 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Go over every example, find its closest centroid, and store
%               the index inside idx at the appropriate location.
%               Concretely, idx(i) should contain the index of the centroid
%               closest to example i. Hence, it should be a value in the 
%               range 1..K
%
% Note: You can use a for-loop over the examples to compute this.
%

%Initialize the distance matrix to all zeros, K is the number of centroids.
distMatrix = zeros(m, K);

%
% for i = 1:m
%     for j = 1: K
%         expVect = X(i, 1: n);
%         centroidVect = centroids(j, 1:n);
%         distance = expVect - centroidVect;
%         distance = distance * (distance)';
%         distMatrix(i, j) = distance;
%     end
% end
%

%Use a for-loop over the 1:K centroids.
for i = 1:K
% Create a column vector of the distance from each training example and store it as a column of the distance matrix
    D = bsxfun(@minus, X, centroids(i, 1:n));
    
    D = sum(D.^2,2);
% One method is to use the bsxfun() function and the sum() function to calculate the sum of the squares of the differences between each row in the X matrix and a centroid.
    
    distMatrix(:, i) = D;
    
    distMatrix;
    
end
 
distMatrix;

[minValues, minIndices] = min(distMatrix,[],2);


idx = minIndices;


% =============================================================

end

