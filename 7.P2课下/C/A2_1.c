#include <stdio.h>

#define MAXN 1000

int result[MAXN];

int main() {
    int n;
    scanf("%d", &n);

    result[0] = 1;

    for (int i = 2; i <= n; i++) {
        int upper = 0;

        for (int j = 0; j < MAXN; j++) {
            int part_result = result[j] * i + upper;
            result[j] = part_result % 10;
            upper = part_result / 10;
        }
    }

    int upper_number = 0;

    for (int i = MAXN - 1; i >= 0; i--) {
        if (result[i] != 0) {
            upper_number = i;
            break;
        }
    }

    for (int i = upper_number; i >= 0; i--) {
        printf("%d", result[i]);
    }
}
