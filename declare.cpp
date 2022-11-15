#include <iostream>
#include <fstream>
#include <unordered_map>
#include <algorithm>

extern std::ofstream outFile;
extern std::unordered_map<std::string, char*> sym_table;
extern std::unordered_map<std::string, char*> mem_table;
extern void error(const char* msg);

void decl_id (char* identifier, char* type) {
    std::string id = std::string(identifier);
    std::transform(id.begin(), id.end(), id.begin(), ::toupper);
    
    if (sym_table.find(id) == sym_table.end()) {
   	sym_table[id] = type;
	char temp[] = "null";
	mem_table[id] = temp;
    	outFile << "declare " << identifier << ", " << type << std::endl;
    } else {
	std::string msg = "Redeclaration of identifier: ";
	msg.append(identifier);
	error(msg.c_str());
    }
}
  
