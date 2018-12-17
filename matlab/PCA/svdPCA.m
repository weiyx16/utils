function [Evalues, Evectors, x_mean]=svdPCA(x)
% PCA using Single Value Decomposition
% Obtaining mean vector, eigenvectors and eigenvalues
%
% [Evalues, Evectors, x_mean]=PCA(x);
%
% inputs,
%   X : M x N matrix with M the trainingvector length and N the number
%              of training data sets
%
% outputs,
%   Evalues : The eigen values of the data
%   Evector : The eigen vectors of the data
%   x_mean : The mean training vector
%

% s = N
s=size(x,2);
% Calculate the mean
% Get the M*1 array
x_mean=sum(x,2)/s;

% Substract the mean and notice use sqrt(s-1) for further multiply
x2=(x-repmat(x_mean,1,s))/ sqrt(s-1);

% Do the SVD 
%[U2,S2] = svds(x2,s); 
[U,S,~] = svd(x2,0);

Evalues=diag(S).^2; % eigen value is the square of Single Value
Evectors=bsxfun(@times,U,sign(U(1,:))); % convert negtive and positive