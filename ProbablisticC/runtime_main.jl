# Load utility functions
include("../util.jl")

# Load configurations
include("runtime_config.jl")

# Log
println("------------------------------------------")
println("Probablistic C runtime benchmarking script")
println("------------------------------------------")
println("Configurations:")
print_dict(CONFIG)
println("------------------------------------------")

# Open result file
open(CONFIG["result_file"], "w") do f

  current_path = pwd()
  cd("probc")
  print(pwd())
  run(pipeline(`make ENGINE=$(CONFIG["sampler"])`, stdout=DevNull, stderr=DevNull))

  # Run the main loop
  for model in CONFIG["model_list"]
    println("[runtime_main] current model: $(model)")
    run_probc() = float(readall(pipeline(`time -p bin/$model -p $(CONFIG["num"])`, stdout=DevNull, stderr=pipeline(`grep real`, `awk '{print $2}'`))))

    # 10k
    times_10k = Float64[]
    for i in 1:CONFIG["batch_size"]
      println("[runtime_main] $(model) 10k $i-th run starts")
      push!(times_10k, run_probc())
      println("[runtime_main] $(model) 10k $i-th run finished with $(times_10k[end])s")
    end

  end

  cd(current_path)

end
