fib(n) = (n < 2) ? n : fib(n-1) + fib(n-2);

N = obs_num

obs = rand(1:10,N)

@model branching begin
    count_prior = Poisson(4)
    @assume r ~ Poisson(4)
    l = (4 < r) ? 6 : fib(3 * r) + rand(Poisson(4))
    for i in 1:N
        @observe obs[i] ~ Poisson(l)
    end
    @predict l
end
