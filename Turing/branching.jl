function fib(n)
  a, b = 0, 1
  for _ in 1:n
    a, b = b, a + b
  end
  a
end

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
