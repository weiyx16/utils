function [Evalues, Evectors, x_mean] = defPCA(align_samples)
% PCA using definition
% Obtaining mean vector, eigenvectors and eigenvalues
%
% [Evalues, Evectors, x_mean]=defPCA(x);
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

    % calcu the cov matrix first
    N=size(align_samples,2);
    % Calculate the mean
    % Get the M*1 array
    x_mean=sum(align_samples,2)/N;

    % Substract the mean
    align_samples=align_samples-repmat(x_mean,1,N);
    cov_mat = cov(align_samples');
%     cov_mat_my = align_samples * align_samples' ./ (N-1);
    [Evectors,Evalues] = eig(cov_mat);
    Evalues = sum(Evalues,2);
    Evectors=bsxfun(@times,Evectors,sign(Evectors(1,:))); % convert negtive and positive
end

