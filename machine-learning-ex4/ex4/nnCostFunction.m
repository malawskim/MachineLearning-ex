function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
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

XX=[ones(m,1) X];
z2=XX*Theta1';
zz2 = [ones(size(z2,1),1) sigmoid(z2)];
hh=sigmoid(zz2*Theta2');

yy=eye(num_labels);

for i=1:m
    for k=1:num_labels
       J=J+(  -yy(y(i),k)*log(hh(i,k)) -(1 - yy(y(i),k))*log(1-hh(i,k)) );
    end
end
J=J/m;

%regularize
reg=0;
reg=sum(sum(Theta1(:,2:size(Theta1,2)).^2))+sum(sum((Theta2(:,2:size(Theta2,2)).^2)));

J=J+lambda*reg/(2*m);
%get max index as prediction
%[J,p]=max(hh,[],2);


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
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));
X=[ones(m,1) X];
yy2=zeros(num_labels, m);
for i=1:num_labels
    yy2(i,:)=(y==i);
end
for i=1:m
%1FF

    a1=X(i,:);%input
    z2=Theta1*a1';
    a2 = [sigmoid(z2)];
    a2 = [1; a2];
    z3 = Theta2*a2;
    a3=sigmoid(z3);%output
%%step 2 - network output error
    %yy(y(i),:)
    delta3=a3-yy2(:,i);
%step 3
    %disp ---
    %size(Theta2_grad)%10 26
    %size(delta3)%1 10
    %size(sigmoidGradient(z2))%1 25
    %size(sigmoidGradient(z2)'*delta3)
    %theta2_grad 10x26
    %sgz2=sigmoidGradient(z2);
    %size(sgz2)%1 25
    %size(delta3)%1 10
    %d3sg=delta3'*(sigmoidGradient(z2))
    %size(d3sg)
    %size(Theta2(:,:))%
    %size(delta3)%1 10
    z2=[1;z2];
    delta2=(Theta2'*delta3).*(sigmoidGradient(z2));
    
    %size(delta2)
    delta2=delta2(2:end); %rm bias el
    %size(delta2)%25x10

    
%step 4
%delta1=Theta1'.*(delta2*sigmoidGradient(z1)')
%delta1=delta1(2:end)
    %disp ---delta3_and_a2
    %size(delta3) %1 10
    %size(a2) % 1 26
    %disp ---
    %size(delta3 * a2')
    %size(Theta2_grad)
    Theta2_grad=Theta2_grad+delta3*a2';
    %size(delta2)%10 25 should be 1 25??
    %size(a1)%1 401
    Theta1_grad=Theta1_grad+delta2*a1;%?
   


end

%Theta1_grad=Theta1_grad./m;
%Theta2_grad=Theta2_grad./m;
%5%

% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%




Theta1_grad(:,1)=Theta1_grad(:,1)./m;
Theta2_grad(:,1)=Theta2_grad(:,1)./m;

Theta1_grad(:,2:end)=Theta1_grad(:,2:end)./m+lambda*Theta1(:,2:end)./m;
Theta2_grad(:,2:end)=Theta2_grad(:,2:end)./m+lambda*Theta2(:,2:end)./m;
% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
