#include <stdio.h>

int result[167];

int main() {
    int n;
    scanf("%d", &n);

    result[0] = 1;

    int width = 0;

    for (int i = 2; i <= n; i++) {
        int upper = 0;

        for (int j = 0; j <= width; j++) {
            int part_result = result[j] * i + upper;
            result[j] = part_result % 1000000;
            upper = part_result / 1000000;
            if (j == width && upper > 0) {
                width++;
            }
        }
    }

    printf("%d", result[width]);

    for (int i = width - 1; i >= 0; i--) {
        printf("%06d", result[i]);
    }
}
