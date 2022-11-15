#include <iostream>
#include <fstream>
#include <unordered_map>
#include <algorithm>

extern std::unordered_map<std::string, char*> sym_table;
extern void error(const char* msg);

char* resolve (char* identifier) {
    std::string id = std::string(identifier);
    std::transform(id.begin(), id.end(), id.begin(), ::toupper);

    if (sym_table.find(id) != sym_table.end()) {
   	return sym_table[id];
    } else {
	std::string msg = "resolve Unresolved identifier: ";
	msg.append(identifier);
	error(msg.c_str());
    }
}
  
