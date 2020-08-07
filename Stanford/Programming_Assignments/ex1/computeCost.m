function J = computeCost(X, y, theta)
%COMPUTECOST Compute cost for linear regression
%   J = COMPUTECOST(X, y, theta) computes the cost of using theta as the
%   parameter for linear regression to fit the data points in X and y
%   X: a matrix containing the population feature
%   y: a matrix containing the corresponding profit
%   Ref: https://www.coursera.org/learn/machine-learning/supplement/SFKpu/programming-tips-from-mentors
%   about the efficiency of the vectorized techniques


% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost of a particular choice of theta
%               You should set J to the cost.

expectedProfit = X*theta;



square = (expectedProfit - y).*(expectedProfit - y);

J = sum(square)/(2*m);


% =========================================================================

end
