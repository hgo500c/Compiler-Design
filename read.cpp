#include <stdio.h>
#include <iostream>
#include <fstream>
extern std::ofstream outFile;

void read_id (const char* identifier, const char* type) {
     outFile << "read " << identifier << ", " << type << std::endl;
}
