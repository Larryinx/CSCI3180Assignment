#include <iostream>

int main() {
    int thing = 10;

    int *ptr = &thing;
    std::cout << *ptr << std::endl;
    std::cout << ptr << std::endl;

    int &ref = thing;
    std::cout << ref << std::endl;

    ref = 20;
    std::cout << thing << std::endl;

    int another = *ptr;
    std::cout << another << std::endl;

    for (int i = 0; i < 10; i++) {
        std::cout << ptr[i] << std::endl;
    }

    return 0;
}