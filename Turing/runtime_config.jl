CONFIG = {
  "batch_size" => 5,
  "kilo_num" => 10000,
  "mili_num" => 1000000,
  "obs_num" => 500,
#  "model_list" => ["big_hmm", "linear_gaussian_1d", "marsaglia", "branching", "tricky_coin"],
  "model_list" => ["marsaglia"],
  "sampler" => "SMC",
  "result_file" => "runtime_result.txt"
}
