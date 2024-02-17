#include <iostream>

int main() {
	bool know_cxx = false;
	if (know_cxx) {
		std::cout << "excellent\n";
	} else {
		std::cout << "let's learn together\n";
	}
	switch (2) {
		default:
			std::cout << 3;
		case 2: {
            std::cout << 2;
            break;
        }
			
		case 1:
			std::cout << 1;
	}
	return 0;
}