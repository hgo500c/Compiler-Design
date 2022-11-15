#include <stdio.h>
#include <iostream>
#include <fstream>

extern std::ofstream outFile;

void write_expr (const char* identifier, const char* type) {
   outFile << "write " << identifier << ", " << type << std::endl;
}
