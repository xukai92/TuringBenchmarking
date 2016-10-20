# Load libraries
using Turing, Distributions

# Load utility functions
include("util.jl")

# Load configurations
include("runtime_config.jl")

# Log
println("----------------------------------")
println("Turing runtime benchmarking script")
println("----------------------------------")
println("Configurations:")
print_dict(CONFIG)
println("----------------------------------")

# Set observations numbers
obs_num = CONFIG["obs_num"]

# Run the main loop
for model in CONFIG["model_list"]

  # Load model
  include("$(model).jl")

  # 10k
  times_10k = Float64[]
  for _ in 1:CONFIG["batch_size"]
      push!(times_10k, @elapsed sample(eval(symbol(model)), SMC(CONFIG["kilo_num"])))
  end

  print("[$(model)_10k] times: ")
  println(times_10k)
  println("[$(model)_10k] mean: $(mean(times_10k)), std: $(std(times_10k))")

  # 1M
  times_1M = Float64[]
  for _ in 1:CONFIG["batch_size"]
      push!(times_1M, @elapsed sample(eval(symbol(model)), SMC(CONFIG["mili_num"])))
  end
  print("[$(model)_1M] times:")
  println(times_1M)
  println("[$(model)_1M] mean: $(mean(times_1M)), std: $(std(times_1M))")

end
