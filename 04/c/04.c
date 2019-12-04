#include <stdio.h>

int main() {
    FILE *fp = fopen("input", "r");
    int i, stop;
    fscanf(fp, "%d-%d", &i, &stop);
    fclose(fp);

    int part1 = 0, part2 = 0;
    for (; i <= stop; ++i) {
        int prev = 10, n, d, p1 = 0, p2 = 0;
        for (int j = i; j; j /= 10) {
            d = j % 10;
            if (d > prev) goto bad;
            if (d == prev) p1 |= ++n == 2;
            else p2 |= n == 2, prev = d, n = 1;
        }
        part1 += p1;
        part2 += p2 | (n == 2);
        bad:{}
    }

    printf("%d %d\n", part1, part2);
}
