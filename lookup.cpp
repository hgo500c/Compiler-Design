#include <iostream>
#include <fstream>
#include <unordered_map>
#include <algorithm>

extern std::ofstream outFile;
extern std::unordered_map<std::string, char*> mem_table;
extern void error(const char* msg);

char* lookup (char* identifier) {
    std::string id = std::string(identifier);
    std::transform(id.begin(), id.end(), id.begin(), ::toupper);
    
    if (mem_table.find(id) != mem_table.end()) {
   	return mem_table[id];
    } else {
	std::string msg = "Unresolved identifier: ";
	msg.append(identifier);
	error(msg.c_str());
    }
}
  
