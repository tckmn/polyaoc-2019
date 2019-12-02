#include <stdio.h>
#include <string.h>

#define ARR_SIZE 150
#define OP4(blk) do { \
    int a = arr[i+1], b = arr[i+2], c = arr[i+3]; \
    if (i + 3 >= ARR_SIZE || a >= ARR_SIZE || b >= ARR_SIZE || c >= ARR_SIZE) return -1; \
    blk; \
    i += 4; \
} while (0)

int run(int *orig, int x, int y) {
    int arr[ARR_SIZE];
    memcpy(arr, orig, sizeof arr);
    arr[1] = x;
    arr[2] = y;

    for (int i = 0;;) {
        switch (arr[i]) {
            case 1: OP4({arr[c] = arr[a] + arr[b];}); break;
            case 2: OP4({arr[c] = arr[a] * arr[b];}); break;
            case 99: return arr[0];
            default: return -1;
        }
    }
}

int main() {
    FILE *fp = fopen("input", "r");
    int arr[ARR_SIZE], i = 0, val;
    while (fscanf(fp, "%d,", &val) > 0) arr[i++] = val;

    // part 1
    printf("%d\n", run(arr, 12, 2));

    // part 2
    for (int x = 1; x < 100; ++x) {
        for (int y = 1; y < 100; ++y) {
            if (run(arr, x, y) == 19690720) return printf("%d\n", 100*x+y), 0;
        }
    }
}
