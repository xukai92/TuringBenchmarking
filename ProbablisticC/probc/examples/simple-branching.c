#include "probabilistic.h"

#define N 500

int fib(int n) {
    return (n < 2) ? n : fib(n-1) + fib(n-2);
}

int main(int argc, char **argv) {
    int obs[N];
    for (int i=0; i<N; i++) obs[i] = rand() % 10 + 1; // = rand(1:10) (Julia)

    int r = poisson_rng(4);
    int l = (4 < r) ? 6 : fib(3*r) +  poisson_rng(4);
    for (int i=0; i<N; i++) {
        observe(poisson_lnp(obs[i], l));
    }
    // predict("r,%3d\n", r);
    return 0;
}
