# Dependencies

This guide explains how to set up and execute the **VGA_Display** project using the **Tang Nano 9K FPGA**. We will display output on an LCD via VGA, using Verilog/SystemVerilog coding. The steps include installing necessary software, configuring the project in **Gowin IDE**, and finally uploading the design to the FPGA via **VSCode** using **Lushay Labs** extensions.

## Prerequisites

### 1. Verilator

Verilator is used for Verilog simulation. Install it using the following commands:

```bash
sudo apt-get update
sudo apt-get install verilator
verilator --version
```

### 2. SDL2 Library

Install the **SDL2** library to enable graphics in your simulation environment:

```bash
sudo apt-get update
sudo apt-get install libsdl2-dev
dpkg-query -W -f='${Version}\n' libsdl2-dev
```

### 3. Gowin IDE

We will use **Gowin IDE** for FPGA design and bitstream generation. Follow these steps to download and install Gowin IDE:

#### Step 1: Download the Gowin EDA Software
1. Visit the [Gowin Semiconductor website](https://www.gowinsemi.com).
2. Navigate to the **Downloads** section.
3. Find and download the **Gowin EDA** package for Linux (`Gowin_V1.9.9.03_Education_linux.tar.gz`).
4. Make Sure you have an account or [Create](https://www.gowinsemi.com/en/member/) a new one.

#### Step 2: Install Gowin IDE
1. Open a terminal and navigate to the download directory:
   ```bash
   cd ~/Downloads
   ```
2. Extract the downloaded package:
   ```bash
   tar -xzf Gowin_V1.9.9.03_Education_linux.tar.gz
   ```
3. Navigate to the extracted folder and run the installer:
   ```bash
   cd gowin_eda
   chmod +x install.sh
   sudo ./install.sh
   ```
4. Check and verify the installation
   ```bash
   gowin --version
   ```

### 4. **Set Up Environment for Gowin IDE**

1. **Open the `.bashrc` File:**
   ```bash
   nano ~/.bashrc
   ```

2. **Add Gowin IDE Directory to the PATH:**
   ```bash
   # Add Gowin IDE directory to the PATH
   export GOWIN_PATH="/path/to/Gowin/IDE/bin"
   export PATH="$GOWIN_PATH:$PATH"

   # Alias to open Gowin IDE
   alias gowin="$GOWIN_PATH/gw_ide &"
   ```

   Replace `/path/to/Gowin/IDE/bin` with the actual path where Gowin IDE is installed.

3. **Apply the Changes:**
   ```bash
   source ~/.bashrc
   ```

4. **Verify PATH Update:**
   ```bash
   echo $PATH
   ```

5. **Open Gowin IDE:**
   ```bash
   gowin
   ```
   