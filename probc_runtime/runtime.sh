echo "Probablistic C runtime" > results.txt
for model in marsaglia tricky-coin simple-branching; do
#for model in big-hmm linear-gaussian marsaglia tricky-coin simple-branching; do
  printf "$model exps starts\n" >> results.txt
  for i in `seq 1 10`; do
    echo "model: $model, i: $i"
    { time ./probc/bin/$model -p 10000 >/dev/null; } |& grep real >> results.txt
#    ./probc/bin/$model -p 10 >> results.tx
#    printf ", " >> results.txt
  done
  printf "$model exps ends\n" >> results.txt
done
