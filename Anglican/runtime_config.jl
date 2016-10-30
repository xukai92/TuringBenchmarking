CONFIG = {
  "batch_size" => 1,
  "kilo_num" => 10000,
  "mili_num" => 1000000,
 # "model_list" => ["hmm", "gaussian", "marsaglia", "branching", "coin"],
  "model_list" => ["hmm", "marsaglia", "branching", "coin"],
  "sampler" => "smc",
  "result_file" => "runtime_result.txt"
}
