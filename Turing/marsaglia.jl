N = obs_num
mu = 3
sigma = 1

@model marsaglia begin
    rv = zeros(N)
    dist = Uniform(-1.0, 1.0)
    for i in 1:N
        @assume x ~ dist
        @assume y ~ dist
        s = x * x + y * y
        while s >= 1 || s == 0
            @assume x ~ dist
            @assume y ~ dist
            s = x * x + y * y
        end

        s = sqrt(-2.0 * log(s) / s);
        spare = y * s;
        rv[i] = mu + sigma * x * s;
    end
    @predict rv
end
