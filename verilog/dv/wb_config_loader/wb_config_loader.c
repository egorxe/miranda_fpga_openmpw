/*
 * SPDX-FileCopyrightText: 2021 Moscow State University
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * SPDX-License-Identifier: Apache-2.0
 */

// This include is relative to $CARAVEL_PATH (see Makefile)
#include <defs.h>
#include <stub.c>

/*
	FPGA config loader via WB
*/

// Address defines
#define OFF_CONFIG_LBLOCK       0x10000
#define OFF_CONFIG_VRNODE       0x11000
#define OFF_CONFIG_HRNODE       0x12000
#define OFF_CONFIG_RSTCFG       0x1A000
#define OFF_CONFIG_TAPCLK       0x1E000

// Test defines
#define WB_CNT                  101
#define WB_TEA                  102

#define FPGA_TEST               WB_TEA

// Define test offsets & include bitstream data
#if   FPGA_TEST == WB_CNT
#define OFF_CNT_ADDR            0x200F0

#include "wb_cnt.txt_lb_bit.h"
#include "wb_cnt.txt_vn_bit.h"
#include "wb_cnt.txt_hn_bit.h"

#elif FPGA_TEST == WB_TEA
#define OFF_K0_ADDR             0x20000
#define OFF_K1_ADDR             0x20004
#define OFF_DATA_ADDR           0x20008

#include "wb_tea.txt_lb_bit.h"
#include "wb_tea.txt_vn_bit.h"
#include "wb_tea.txt_hn_bit.h"

#else
#error "No FPGA test defined!"
#endif

#define write_user_reg(off, val) {(*(volatile uint32_t*)(0x30000000 + (off))) = (val);}
#define read_user_reg(off) (*(volatile uint32_t*)(0x30000000 + (off)))


// Cheat a bit to speedup loading - put this function into data section
// for it to be copied into SRAM
__attribute__ ((section (".data"))) 
void load_scanchain(int words, const uint16_t* config_data, uint32_t config_off, uint32_t tap)
{
    for (int i = 0; i < words/2; i++)
    {
        // logic blocks
        uint32_t data = ((uint32_t*)config_data)[i];
        write_user_reg(config_off, ((uint16_t*)&data)[0]);
        write_user_reg(OFF_CONFIG_TAPCLK, tap);
        write_user_reg(OFF_CONFIG_TAPCLK, 0);
        write_user_reg(config_off, ((uint16_t*)&data)[1]);
        write_user_reg(OFF_CONFIG_TAPCLK, tap);
        write_user_reg(OFF_CONFIG_TAPCLK, 0);
    }
}

void main()
{
	// Caravel setup stuff

	reg_spi_enable = 1;
    reg_wb_enable = 1;
    
    #if FPGA_TEST == WB_TEA
    const uint32_t mode = GPIO_MODE_USER_STD_OUTPUT;
    #else
    const uint32_t mode = GPIO_MODE_USER_STD_BIDIRECTIONAL;
    #endif

    reg_mprj_io_37 = mode;
    reg_mprj_io_36 = mode;
    reg_mprj_io_35 = mode;
    reg_mprj_io_34 = mode;
    reg_mprj_io_33 = mode;
    reg_mprj_io_32 = mode;
    reg_mprj_io_31 = mode;
    reg_mprj_io_30 = mode;
    reg_mprj_io_29 = mode;
    reg_mprj_io_28 = mode;
    reg_mprj_io_27 = mode;
    reg_mprj_io_26 = mode;
    reg_mprj_io_25 = mode;
    reg_mprj_io_24 = mode;
    reg_mprj_io_23 = mode;
    reg_mprj_io_22 = mode;
    reg_mprj_io_21 = mode;
    reg_mprj_io_20 = mode;
    reg_mprj_io_19 = mode;
    reg_mprj_io_18 = mode;
    reg_mprj_io_17 = mode;
    reg_mprj_io_16 = mode;
    reg_mprj_io_15 = mode;
    reg_mprj_io_14 = mode;
    reg_mprj_io_13 = mode;
    reg_mprj_io_12 = mode;
    reg_mprj_io_11 = mode;
    reg_mprj_io_10 = mode;
    reg_mprj_io_9  = mode;
    reg_mprj_io_8  = mode;
    reg_mprj_io_7  = mode;
    reg_mprj_io_6  = mode;
    reg_mprj_io_5  = mode;
    reg_mprj_io_4  = mode;
    //reg_mprj_io_3  = mode;
    reg_mprj_io_2  = mode;
    reg_mprj_io_1  = mode;
    reg_mprj_io_0  = mode;

    // Apply configuration
    reg_mprj_xfer = 1;
    while (reg_mprj_xfer == 1);
	reg_la2_oenb = reg_la2_iena = 0xFFFFFFFF;    // [95:64]

    // Reset FPGA & terminate pads
    write_user_reg(OFF_CONFIG_RSTCFG, 3);
    
    // Load config
    load_scanchain(lblock_config_words, lblock_config_data, OFF_CONFIG_LBLOCK, 1); // logic blocks
    load_scanchain(vnode_config_words, vnode_config_data, OFF_CONFIG_VRNODE, 2);   // vertical routing nodes
    load_scanchain(hnode_config_words, hnode_config_data, OFF_CONFIG_HRNODE, 4);   // horizontal routing nodes

    // Release pads & FPGA reset
    write_user_reg(OFF_CONFIG_RSTCFG, 1);
    write_user_reg(OFF_CONFIG_RSTCFG, 0);
    
    // Reset WB logic in FPGA fabric
    write_user_reg(OFF_CONFIG_RSTCFG, 8);
    write_user_reg(OFF_CONFIG_RSTCFG, 0);
    
    #if   FPGA_TEST == WB_CNT
    // Increment counter for test
    write_user_reg(OFF_CNT_ADDR, 0);
    write_user_reg(OFF_CNT_ADDR, 0);
    write_user_reg(OFF_CNT_ADDR, 0);
    read_user_reg(OFF_CNT_ADDR);
    #elif FPGA_TEST == WB_TEA
    write_user_reg(OFF_K0_ADDR, 0x01234567);
    write_user_reg(OFF_K1_ADDR, 0x89ABCDEF);
    write_user_reg(OFF_DATA_ADDR, 0xDEADBEEF);
    #endif
}
