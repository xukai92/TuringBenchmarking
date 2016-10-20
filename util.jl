function print_dict(d :: Dict)
  println("{")
  for (k, v) in d
    println("  ", k, "\t=>\t", v)
  end
  println("}")
end
