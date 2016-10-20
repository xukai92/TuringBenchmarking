N = obs_num
obs = ones(N) # trickiest coin for ever!

@model tricky_coin begin
    @assume is_tricky ~ Bernoulli(0.1)
    theta = is_tricky == 1 ? rand(Beta(1, 1)) : 0.5

    for i in 1:N
        @observe obs[i] ~ Bernoulli(theta)
    end

    @predict is_tricky theta
end
