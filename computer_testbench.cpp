#include <iostream>
#include <verilated.h>
#include "Vcomputer.h"
#include <verilated_vcd_c.h>
int time_counter = 0;
int main(int argc, char **argv) {
     Verilated::commandArgs(argc, argv);

    // Instantiate DUT
    Vcomputer *dut = new Vcomputer();
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    dut->trace(tfp, 99);  //これ
    tfp->open("wave.vcd"); //これ
    // Format
    dut->CLK = 0;

    // Reset Time
    while (time_counter < 100) {
        dut->eval();
        tfp->dump(time_counter);  // 波形ダンプ用の記述を追加
        time_counter++;
    }

    int cycle = 0;
    while (time_counter < 50000) {
        if ((time_counter % 5) == 0) {
            dut->CLK = !dut->CLK; // Toggle clock
        }
        if ((time_counter % 10) == 0) {
            // Cycle Count
            cycle ++;
        }


        // Evaluate DUT
        dut->eval();
        tfp->dump(time_counter);  // 波形ダンプ用の記述を追加
        time_counter++;
    }

    printf("FinalHEX0 = %x\n", dut->HEX0);
    printf("FinalHEX1 = %x\n", dut->HEX1);
    printf("FinalHEX2 = %x\n", dut->HEX2);
    printf("FinalHEX3 = %x\n", dut->HEX3);
    printf("FinalHEX4 = %x\n", dut->HEX4);
    tfp->close(); //これ
    dut->final();
}