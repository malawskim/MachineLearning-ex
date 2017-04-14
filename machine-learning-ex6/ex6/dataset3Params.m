function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

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
model= svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma));
predictions=svmPredict(model,Xval);
pred_error=mean(double(predictions~=yval));
C=0.001;

C_min=0;
sigma_min=0;
pred_min=999999999;
values = [0.01 0.03 0.1 0.3 1 3 10 30];
for i=1:8
%C
    for j=1:8
        %sigma
        model= svmTrain(X, y, values(i), @(x1, x2) gaussianKernel(x1, x2, values(j)));
        predictions=svmPredict(model,Xval);
        pred = mean(double(predictions~=yval));
        pred_error(i,j) = pred;
        if pred < pred_min
            pred_min=pred;
            C_min=values(i);
            sigma_min=values(j);
        end

    end
end
pred_error
pred_min
C_min
sigma_min
C=C_min
sigma=sigma_min
C
% =========================================================================

end
