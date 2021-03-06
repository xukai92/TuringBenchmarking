#include "probabilistic.h"

#define N 500

int main(int argc, char** argv) {

    /*
     * "tricky coin" example from Venture documentation
     * http://probcomp.csail.mit.edu/venture/console-examples.html
     *
     */

    // p(is_tricky) = 0.1
    int is_tricky;

    // theta | is_tricky ~ beta(1,1)
    // theta | !is_tricky = 0.5
    double theta;
    int obs[N];
    for (int i=0; i<N; i++) obs[i] = 1;

    is_tricky = flip_rng(0.1);
    theta = is_tricky ? beta_rng(1, 1) : 0.5;

    // observe 500 coin flips, all coming up heads
    for (int i=0; i<N; i++) {
      observe(flip_lnp(obs[i], theta));
    }

    // is the coin tricky?
    // predict("is_tricky,%d\n", is_tricky);

    // what percent of the time does the coin come up heads?
    // predict("theta,%0.4f\n", theta);

    return 0;
}
