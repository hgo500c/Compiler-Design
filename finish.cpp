#include <iostream>
#include <fstream>
extern std::ofstream outFile;

void finish() {
    std::cout << "Finished compiling successfully" << std::endl;
    outFile << "halt" << std::endl;
}
