# TI-RSLK Line Follower

A line-following robot project built for the TI-RSLK platform using the MSP432P401R microcontroller. This project demonstrates embedded C and assembly programming in a real-world robotics application.

[![YouTube Showcase](https://img.shields.io/badge/Watch-YouTube%20Demo-red?logo=youtube)](https://youtube.com/shorts/xv6LlqUDr_8)

---

## 🚀 Features

- Line detection using reflectance sensors  
- Bumper collision detection  
- PWM-based motor control  
- Button input for user interaction  

---

## 📁 Project Structure

- `main.c` — Main entry point  
- `code/` — Core C and assembly source files (sensors, control, peripherals)  
- `inc/` — Additional source/header files  
- `Debug/` — Build output (auto-generated)  
- `targetConfigs/` — Target configuration files  

---

## 🛠 Getting Started

### Prerequisites

- [Code Composer Studio (CCS)](https://www.ti.com/tool/CCSTUDIO) (Version 12)
- TI MSP432P401R LaunchPad
- TI-RSLK hardware kit

### Build & Flash

1. Import the project into Code Composer Studio.  
2. Build the project.  
3. Connect the MSP432 LaunchPad via USB.  
4. Flash or debug the project using CCS.

---

## ▶️ Usage

- Press **Button S2** (Button 2) on the LaunchPad to start the robot.  
- The robot will follow the line and respond to bumper collisions automatically.

---

## 📝 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.