function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%  NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. 
%
%   The parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.--> [Long] ???
%

%   Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
%   for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
num_examples = size(X, 1);

% Expand the 'y' output values into a matrix of single values
A = eye(num_labels);
y_matrix = A(y,:);
  
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%

% Implement the feedforward computation that computes  for every example i
% Add ones to the X data matrix
a1 = [ones(num_examples, 1) X];

% Determine the units in the second hidden layer
z2 = a1 * (Theta1)';

% The prediction from the second layer
a2 = sigmoid(z2);

% Add the extra bias unit which is always 1
a2 = [ones(num_examples, 1) a2];

% Determine the units in the output layer
z3 = a2 * (Theta2)';

% The output layer
a3 = sigmoid(z3);

% Determine the multiplication element wise between the y matrix and a3
first = (y_matrix) .* (log(a3));

second = (1 - y_matrix) .* (log(1 - a3));

% Unregularized cost matrix

costMatrix = (first + second)/(-num_examples);

J =  sum(costMatrix,'all');

% Regularized terms

squaredTheta1 = Theta1(:,2: end).^2;

squaredTheta2 = Theta2(:,2: end).^2;

totalTheta = (sum(squaredTheta1, 'all') + sum(squaredTheta2, 'all')) .* (lambda/(2*(num_examples)));

J = J + totalTheta;


% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%

%Compute d3 using a3 and y_matrix, d3 has dimension m x K

d3 = a3 - y_matrix;

Theta2_non_bias =Theta2(:,2: end);

size(Theta2_non_bias);

%d2 = (d3 * Theta2_non_bias);

d2 = (d3 * Theta2_non_bias) .* (a2(:,2:end)) .* (1- a2(:,2:end));

delta1 = (d2)' * (a1);

delta2 = (d3)' * (a2);

Theta1_grad = (delta1) .* (1/num_examples);


Theta2_grad = (delta2) .* (1/num_examples);



% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%

% Set the first column of Theta1 and Theta2 to all-zeros. 
modified_Theta1 = Theta1;
modified_Theta1(:, 1) = 0;
modified_Theta1 = modified_Theta1 .* (lambda / num_examples);
Theta1_grad= Theta1_grad + modified_Theta1;


modified_Theta2 = Theta2;
modified_Theta2(:, 1) = 0;
modified_Theta2 = modified_Theta2 .* (lambda / num_examples);
Theta2_grad = Theta2_grad + modified_Theta2;




% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end