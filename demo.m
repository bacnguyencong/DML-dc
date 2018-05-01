install;

load('data/balance.mat');
rng('default');

lambda = 0.1;
s = -1;

% learn a Mahalanobis matrix
M = solverDML(lambda, s, xTr, yTr);

% testing
pred1 = knnClassifier(xTr, yTr, 1, xTe, eye(size(xTr,1)));
pred2 = knnClassifier(xTr, yTr, 1, xTe, M);

% report results
fprintf('Test accuracy of 1-NN classification using\n')
fprintf('Euclidean = %.2f\n', mean(pred1 == yTe));
fprintf('DML-dc    = %.2f\n', mean(pred2 == yTe));
fprintf('LOO error of 1-NN classification using\n')
fprintf('Euclidean = %.2f\n', LOO(xTr, yTr, eye(size(xTr,1))));
fprintf('DML-dc    = %.2f\n', LOO(xTr, yTr, M));
