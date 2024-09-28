# VGA-controller

This project demonstrates how to use the **Tang Nano 9K FPGA** to display output on an LCD via VGA using Verilog and SystemVerilog. The project contains two key folders: one for simulations and another for hardware implementation.

## Project Structure

- **VGA_Sim**: Contains SystemVerilog files for simulation purposes. This folder is used for testing and verifying the design without the involvement of hardware (FPGA).
- **VGA_Display**: Contains all necessary files to implement the design on hardware. This allows you to interface the FPGA with an LCD via VGA cable and observe the output.

## Clone the Project

To get started, clone the repository using the following command:

```bash
git clone https://github.com/Abdul-muheet-ghani/VGA-controller
```

## Folders Description

### 1. **VGA_Sim**:
This folder contains all the simulation files written in SystemVerilog. The simulations are meant to test the behavior of the design without the need for the FPGA. You can use a simulation tool such as ModelSim or Vivado for this purpose. These files help you verify the VGA signal timings and display patterns before deploying to hardware.

### 2. **VGA_Display**:
This folder includes all the necessary files to implement the design on the **Tang Nano 9K FPGA**. By using the provided Verilog/SystemVerilog code, the VGA signals will be routed to the LCD via a VGA cable, allowing you to display the desired patterns.

## How to Proceed

To learn about the detailed procedure for running simulations or deploying the design to hardware, navigate to the respective folder's README file:

- For **VGA_Sim**, check the [README file](https://github.com/Ali-975/VGA-controller/blob/duplicate/VGA_Sim/README.md) in the simulation folder for instructions.
- For **VGA_Display**, check the [README file](https://github.com/Ali-975/VGA-controller/blob/duplicate/VGA_Display/README.md) in the display folder for FPGA setup and hardware deployment instructions.
-  For **HDMI_Display**, check the [folder](https://github.com/Fayz2110/VGA-controller/tree/main/VGA_Display/gowin/HDMI_Display) , you can also refer to its [README file](https://github.com/Fayz2110/VGA-controller/blob/main/VGA_Display/gowin/HDMI_Display/HDMI.md)

Each folder's README provides step-by-step instructions for running simulations or implementing the design on the FPGA. However, ensure you have the necessary [dependencies](https://github.com/Ali-975/VGA-controller/blob/duplicate/Dependencies.md) installed beforehand.
