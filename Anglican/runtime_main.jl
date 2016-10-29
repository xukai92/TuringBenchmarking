# Load utility functions
include("../util.jl")

# Load configurations
include("runtime_config.jl")

# Log
println("------------------------------------")
println("Anglican runtime benchmarking script")
println("------------------------------------")
println("Configurations:")
print_dict(CONFIG)
println("------------------------------------")

# Set run command
# Adapted from https://github.com/yebai/TuringPrivate.jl/blob/719914abe91b8c3bc80d654ae6a5c4a75d7d5ab1/private/experiments/Anglican.jl

# Open result file
open(CONFIG["result_file"], "w") do f
  current_path = pwd()
  cd("anglican-user")

  # Run the main loop
  for model in CONFIG["model_list"]
    function run_anglican(num)
      sampler = CONFIG["sampler"]
      options = string("\"", ":number-of-particles ", num, "\"")
      clojure_command = "(m! $model -a $sampler -n 1 -o $options)"
      timing_command = string("(+ 1 1) (time ", clojure_command, ")")
      # float(
        readall(pipeline(
                           `echo $timing_command`
                         , `lein repl`
                         , `grep 'Elapsed time'`
                        #  , `egrep -o '[0-9]*\.[0-9]*'`
                         ))
                        #  ) / 1000
    end

    println("[runtime_main] current model: $(model)")

    # 10k
    # times_10k = Float64[]
    times_10k = []
    for i in 1:CONFIG["batch_size"]
      println("[runtime_main] $(model) 10k $i-th run starts @$(time())")
      push!(times_10k, run_anglican(CONFIG["kilo_num"]))
      println("[runtime_main] $(model) 10k $i-th run finished @$(time()) with $(times_10k[end])s")
    end

    write(f, "[$(model)_10k] times: ")
    write(f, "$(times_10k)\n")
    if CONFIG["batch_size"] > 1
      write(f, "[$(model)_10k] mean: $(mean(times_10k)), std: $(std(times_10k))\n")
    end

    # 1M
    # times_1M = Float64[]
    times_1M = []
    for i in 1:CONFIG["batch_size"]
      println("[runtime_main] $(model) 1M $i-th run starts @$(time())")
      push!(times_1M, run_anglican(CONFIG["mili_num"]))
      println("[runtime_main] $(model) 1M $i-th run finished @$(time()) with $(times_1M[end])s")
    end
    write(f, "[$(model)_1M] times: ")
    write(f, "$(times_1M)\n")
    if CONFIG["batch_size"] > 1
      write(f, "[$(model)_1M] mean: $(mean(times_1M)), std: $(std(times_1M))\n")
    end
  end

end
