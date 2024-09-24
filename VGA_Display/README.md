# Gowin IDE Setup for VGA Display Project

This document provides step-by-step instructions for setting up and configuring the **VGA_Display** project in Gowin IDE for the Tang Nano 9K FPGA.

## 1. **Create a New Project**

- Open Gowin IDE.
- Create a new project and name it `VGA_Display`.

 ![Alt text](img/create_new_project.png "Create new project")
 ![Alt text](img/create_new_project_1.png "fpga project")

## 2. **Set Configuration**

- Configure the project with the necessary settings.

 ![Alt text](img/set_config.png "Set the configuration of fpga")
 ![Alt text](img/set_config_1.png "Select the right device")
 ![Alt text](img/set_config_2.png "Summary description")

- Use built-in IPs for the clock divider since the Tang Nano 9K FPGA operates at 27 MHz, but the LCD requires a 25 MHz clock. The IP will help adjust the clock frequency accordingly.
 
 ![Alt text](img/ip_block_generation.png "Use In-built Ip blocks")
 ![Alt text](img/clk_divider_block.png "Clock divider Block")
 ![Alt text](img/PLL_block.png "PLL block")

## 3. **Create Verilog Files and .cst File**

- Ensure that the names of your Verilog files and `.cst` file match exactly.

 ![Alt text](img/create_verilog_file.png "Create a verilog file of same name and module")
 ![Alt text](img/create_cst_file.png "Create .cst file")

- Copy and paste the content from the existing files into the files you just created.
  
  **Note:** If you generate the bitstream without a `.cst` file, the configuration will not work correctly.

## 4. **Alternative Method**

- Instead of manually creating the project, you can copy the folder `VGA_Display/gowin/VGA_Display` and paste it into your Gowin IDE installation path:
  ```bash
  /path/to/Gowin/IDE/bin
  ```
- Open the project from within Gowin IDE after copying.

## 5. **Compile and Generate Bitstream**

- Once your project is set up in Gowin IDE, compile and generate the bitstream.
- This may take a few seconds. Ensure there are no errors in the compilation.
 ![Alt text](img/run_all.png "Run the Project")
 ![Alt text](img/console.png "Console output")

## 6. **Locate the Bitstream File**

- After successfully generating the bitstream, navigate to the folder where it is stored:
  ```bash
  /path/to/Gowin/IDE/bin/VGA_Display/impl/pnr
  ```
- The `.fs` file should be located here.

- **Note:** Create a new folder with the **same name** as the `.fs` file. Copy the both `.fs` and `.cst` file into this folder and open it using VSCode for further operations.

## 7. **Connect FPGA and LCD**

- Make sure the Tang Nano 9K FPGA is properly connected.
- Attach the VGA cable to the LCD and FPGA according to the pin assignments specified in the `.cst` file.

 ![Alt text](img/pin_configuration.png "Pin configuration")
 ![Alt text](img/pin_mapping.png "Pin mapping")
 ![Alt text](img/vga_fpga_connections.png "Connections")![Alt text](img/vga_fpga_connections_1.png "fpga and vga connections")

## 8. **Run the Program**

- Open VSCode, and at the bottom right corner of the screen, look for the **FPGA Toolchain**.

 ![Alt text](img/lushay_code_for_vscode.png "FPGA Toolchain")

- Select the **"Run Program Only"** option to load the bitstream onto the FPGA.

 ![Alt text](img/lcd_output.png "Pin mapping")

 ![Alt text](img/moving_block.gif "Pin mapping")