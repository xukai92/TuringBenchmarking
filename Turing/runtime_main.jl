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

# Open result file
open(CONFIG["result_file"], "w") do f

  # Run the main loop
  for model in CONFIG["model_list"]
    println("[runtime_main] current model: $(model)")

    # Load model
    include("$(model).jl")

    # 10k
    times_10k = Float64[]
    for i in 1:CONFIG["batch_size"]
      println("[runtime_main] $(model) 10k $i-th run starts")
      push!(times_10k, @elapsed sample(eval(symbol(model)), eval(symbol(CONFIG["sampler"]))(CONFIG["kilo_num"])))
      println("[runtime_main] $(model) 10k $i-th run finished with $(times_10k[end])s")
    end

    write(f, "[$(model)_10k] times: ")
    write(f, "$(times_10k)\n")
    write(f, "[$(model)_10k] mean: $(mean(times_10k)), std: $(std(times_10k))\n")

    # 1M
    times_1M = Float64[]
    for i in 1:CONFIG["batch_size"]
      println("[runtime_main] $(model) 1M $i-th run starts")
      push!(times_1M, @elapsed sample(eval(symbol(model)), eval(symbol(CONFIG["sampler"]))(CONFIG["mili_num"])))
      println("[runtime_main] $(model) 1M $i-th run finished with $(times_1M[end])s")
    end
    write(f, "[$(model)_1M] times: ")
    write(f, "$(times_1M)\n")
    write(f, "[$(model)_1M] mean: $(mean(times_1M)), std: $(std(times_1M))\n")

  end

end
