#include <iostream>
#include <verilated.h>
#include "Vdecoder.h"
int time_counter = 0;
int main(int argc, char **argv){
    Verilated::commandArgs(argc, argv);
    Vdecoder *dut = new Vdecoder();
    dut->instruction = 0;
    // Reset Time
    while (time_counter < 100) {
        dut->eval();
        time_counter++;
    }
    while (time_counter < 500) {
        dut->instruction = 0b11111111111100111000001110010011;
        dut->eval();time_counter++;
    }
    printf("rs1 = %d\n", dut->rs1);
    printf("rs2 = %d\n", dut->rs2);
    printf("rd = %d\n", dut->rd);
    printf("signImm = %d\n", dut->signImm);

    dut->final();
}