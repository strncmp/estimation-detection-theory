% mmse_implementation - Calculates the Mean Squared Error (MSE) of an Bayesian MMSE Estimator
% for a given parameter theta, sampled from a normal distribution 
% N(m_theta, sigma_theta^2), for the following signal model:
%   x[n] = h * theta + w[n]
%
% Other parameters:
%   N_max: Maximum number of samples to be used for estimation
%   Exp_per_N: Number of experiments to be performed for each N
%
% Output:
%   - estimator_mse: Array of MSE values for different sample sizes (N)
function estimator_mse = mmse_implementation(theta, m_theta, sigma_theta, h, m_w, sigma_w, N_max, Exp_per_N)
    estimator_mse = zeros(1, N_max);

    for i = 1:N_max
        theta_est = zeros(1, Exp_per_N);
        for j = 1:Exp_per_N
            N = i;
            % Generate random samples
            w = m_w + sigma_w * randn(N, 1);
            x = h * theta + w;

            k = sigma_theta^2 * h / (sigma_theta^2 * h^2 + sigma_w^2 / N);
            theta_est(j) = (1 - k*h) * m_theta + k * sum(x) / N;
        end
        estimator_mse(i) = mean((theta_est - theta).^2);
    end
end