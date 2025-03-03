#include <stdio.h>

typedef int (*func_ptr_t)(int, int); // create a function pointer

int safe_function(int a, int b) {
    return a + b;
}

struct Bug { // variables in struct are in consecutive memory addresses
    int buffer[2];
    func_ptr_t func;
};

int main() {
    struct Bug bug;
    bug.func = safe_function;
    
    // BUG: Overflow the 2-element buffer by writing 3 elements,
    // which overwrites the 'func' pointer.
    for (int i = 0; i < 3; i++) {
        bug.buffer[i] = i;
    }
    
    // Call the (possibly corrupted) function pointer.
    int result = bug.func(10, 20);
    return 0;
}
