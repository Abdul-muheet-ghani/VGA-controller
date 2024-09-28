 This This document provides step-by-step instructions for setting up and configuring the **HDMI_Display** project in Gowin IDE for the Tang Nano 9K FPGA.

 You can follow the steps 1 and 2 from here [README file](https://github.com/Fayz2110/VGA-controller/blob/main/VGA_Display/README.md)

##  **IP's for HDMI**
![Alt text](img/pll_serial.png )
- As you can see there are two clocks in DVI IP.The 125Mhz clock required for serialization of RGB,where as 25Mhz required for Tmds encoder for RGB
- ![Alt text](img/DVI.png )
- Follow step 3 to 6 from here [README file](https://github.com/Fayz2110/VGA-controller/blob/main/VGA_Display/README.md)
##  **CONNECT FPGA**
- Connect FPGA with laptop,an led will be on FPGA.
- make the constraint file
 - ![Alt text](img/HDMI_cnst.png )
 -   ![Alt text](img/HDMI_PINS.png )
 -   Program the FPGA.
 -   Connect the HDMI cable with FPGA and screen.
  ##  **OUTPUTS**
   - ![Alt text](img/hdmi_connections.jpeg)
    - ![Alt text](img/HDMI_Output.jpeg)
