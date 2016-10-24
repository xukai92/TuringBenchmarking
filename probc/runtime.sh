echo "Probablistic C runtime" > results.txt
for model in big-hmm linear-gaussian marsaglia tricky-coin simple-branching; do
  printf "$model exps starts\n" >> results.txt
  for i in `seq 1 10`;
  do
    ./probc/bin/$model -p 10000 >> results.txt
    printf ", " >> results.txt
  done
  printf "\n$model exps ends\n" >> results.txt
done
# ./probc/bin/big-hmm -p 10 >> results.txt
