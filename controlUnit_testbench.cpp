#include <iostream>
#include <bitset>
#include <verilated.h>
#include "VcontrolUnit.h"
using namespace std;
int time_counter = 0;
int main(int argc, char **argv){
    Verilated::commandArgs(argc, argv);
    VcontrolUnit *dut = new VcontrolUnit();
    // Reset Time
    while (time_counter < 100) {
        dut->eval();
        time_counter++;
    }
    while (time_counter < 500) {
        dut->instruction = 0b11011011011011011010000100110111;
        dut->eval();time_counter++;
    }
    cout << "memToReg = "s << (dut->memToReg ? "True"s : "False"s) << "\n"s;
    cout << "memWrite = "s << (dut->memWrite ? "True"s : "False"s) << "\n"s;
    cout << "regDst = "s << (dut->regDst ? "True"s : "False"s) << "\n"s;
    cout << "branch = "s << (dut->memToReg ? "True"s : "False"s) << "\n"s;
    cout << "isImm = "s << (dut->isImm ? "True"s : "False"s) << "\n"s;
    cout << "we_reg = "s << (dut->we_reg ? "True"s : "False"s) << "\n"s;
    cout << "ALUop = "s << (bitset<4>(dut->ALUop)) << endl;
}   
