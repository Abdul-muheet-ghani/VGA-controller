# VGA_Display Project Setup

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
4. Make sure you have an account or [create](https://www.gowinsemi.com/en/member/) a new one.

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
4. Check and verify the installation:
   ```bash
   gowin --version
   ```

### 4. Set Up Environment for Gowin IDE

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
      - In `nano`, save your changes by pressing `Ctrl + O`, then press `Enter`, and exit by pressing `Ctrl + X`.

4. **Apply the Changes:**
   ```bash
   source ~/.bashrc
   ```

5. **Verify PATH Update:**
   ```bash
   echo $PATH
   ```

6. **Open Gowin IDE:**
   ```bash
   gowin
   ```

### 5. Installing Lushay Code v0.0.21 in VSCode

Follow these steps to install the **Lushay Code** extension in Visual Studio Code:

1. **Open Visual Studio Code:**
   Ensure you have Visual Studio Code installed. If not, download and install it from [here](https://code.visualstudio.com/).

2. **Open the Extensions View:**
   Open VSCode and click on the Extensions icon on the left sidebar, or press `Ctrl+Shift+X` to open the Extensions pane.

3. **Search for the Lushay Code Extension:**
   In the Extensions search bar, type `Lushay Code v0.0.21` and hit enter.

4. **Install the Extension:**
   From the results, find **Lushay Code v0.0.21** by **Lushay Labs**. Click on **Install**.

5. **Verify Installation:**
   After installation, the extension will appear in your list of installed extensions. You’re now ready to use Lushay Code in your FPGA projects.
