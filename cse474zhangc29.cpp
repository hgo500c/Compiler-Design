/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   main.cpp
 * Author: 14716
 *
 * Created on September 17, 2019, 6:48 PM
 */

#include <cstdlib>
#include <fstream>
#include <string>
#include <sstream>
#include <iostream>
using namespace std;

/*
 * 
 */
bool checkthenumber(char a);

int main( int, char**)
{
char next;
std::ifstream file("C:/Users/14716/Desktop/input.TXT");
file >> next;
 char ex = next;
if(ex != '$') {
    cout<< " it is not a legal hexadecimal number, because it do not include"<<
            "$ at first"<< endl;
    return 0;
}
else{
while( file >> next ) {
// do whatever with the next character read from file
    char ex2 = next;
    cout << next <<endl;
   if (!checkthenumber(ex2)){
       cout<< " it is not a legal hexadecimal number,because it do not "
               "include correct number and char "<< endl;
       return 0; 
   }
}
file.close();
    cout<< " it is a legal hexadecimal number "<< endl;
return 0;
}
}

bool checkthenumber(char a){
    if( ( (int)a < 48 || (int)a > 57 ) && ( (int)a < 65 || (int)a > 70 )){
        return false;
    }
     return true;
            
}
