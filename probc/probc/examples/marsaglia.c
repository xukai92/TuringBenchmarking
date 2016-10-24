#include "probabilistic.h"

#include <math.h>

#define N 500
#define mu 3
#define sigma 1

int main(int argc, char** argv) {
    double rv[N], x, y, s;

    for (int i=0; i<N; i++) {
        x = ((double) rand() / (RAND_MAX)) * 2 - 1;
        y = ((double) rand() / (RAND_MAX)) * 2 - 1;
        s = x * x + y * y;
        while (s >= 1 || s == 0) {
            x = ((double) rand() / (RAND_MAX)) * 2 - 1;
            y = ((double) rand() / (RAND_MAX)) * 2 - 1;
            s = x * x + y * y;
        }

        s = sqrt(-2.0 * log(s) / s);
        double spare = y * s;
        rv[i] = mu + sigma * x * s;
    }

    return 0;
}
