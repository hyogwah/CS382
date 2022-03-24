#include <stdio.h>

int main() {
    int a = 4;
    printf("%p\n", &a);
    return 0;
}

/* What are pointers?
*  A variable that holds an address
*/

int main() {
    int a = 4;
    int* ptr = &a;
    printf("%p\n", ptr, &ptr); // printf("%p\n", &ptr) &ptr will print the address of ptr
    return 0;
}

// Dereferencing pointers:

int main() {
    int a = 4;
    // int arr[4];
    // printf("%p\n%p\n", arr, arr+3);

    int* ptr = &a; // reference
    *ptr = *ptr + 1; // takes the dereference, adds 1
    printf("%d\n", a);
    return 0;
}

// Test Program

int doubleit(int* p) {
    *p = 2 * (*p);
    return *p;
}

int main () {
    int a = 3;
    int b = doubleit(&a);
    printf("%d\n", a*b);

    return 0;
}