#include <iostream>
#include <fstream>
#include <unordered_map>
#include <algorithm>

extern std::ofstream outFile;
extern std::unordered_map<std::string, char*> mem_table;
extern void error(const char*);

void assign (char* target, char* source) {
    std::string id = std::string(target);
    std::transform(id.begin(), id.end(), id.begin(), ::toupper);
    
    if (mem_table.find(id) != mem_table.end()) {
	mem_table[id] = source;
        outFile << "store " << source << ", " << target << std::endl;
    } else {
	std::string msg = "Illegal assignment to unresolved identifier ";
	msg.append(target);
	error(msg.c_str());
    }

}

