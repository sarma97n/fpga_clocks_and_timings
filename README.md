Hi this repo contains some personal projects that I have developed to teach my self how time and clocks work in Verilog. Below is a complete document for the projects that are in this repo.  

FPGA Clock and Timing Mastery Projects for Basys 3
Author: Aditya Sarma Nuthalapati
Board: Digilent Basys 3 (Artix-7 FPGA)
Software: Xilinx Vivado Design Suite
________________________________________
Context and Intent
These projects are structured to develop practical mastery over clocking, timing, and synchronization on the Basys 3 board. Each stage progresses naturally in complexity and is built to simulate a professional design workflow. The tone, rigor, and documentation format are deliberate—this is how one would execute assignments in a company setting, where clarity, reproducibility, and technical accuracy matter more than flash.
________________________________________
Primary Project — Clock Divider and Frequency Display
Objective
Design a parameterized clock divider using the onboard 100 MHz clock. The divided frequencies should be visualized using LEDs and the seven-segment display.
Background
This project establishes a working understanding of frequency scaling and timing precision on FPGA hardware. It reinforces the concept that real hardware timing differs from simulation timing and introduces clean design practices for slow logic handling through clock enables rather than raw clock division.
Tasks
1.	Design the Divider Logic: Build a parameterized Verilog module that divides the 100 MHz input clock by selectable ratios (e.g., /2, /4, /10, /100, /1000). Implement division through counters and parameterized toggling.
2.	Interactive Control: Use board switches to change division ratios dynamically. Drive LEDs with the resulting divided clock outputs. Display the active ratio on the seven-segment display.
3.	System Control and Reset: Integrate a reset using the centre button (BTNC). Ensure the divider and display reset synchronously.
4.	Verification:
Run simulations to validate toggle behaviour and frequency scaling. Confirm actual output rates using LEDs and a logic analyser on hardware.
Deliverables
•	Verilog source for the divider, seven-segment driver, and top-level integration.
•	Simulation results and measured frequency data.
•	Vivado synthesis and implementation report.
Learning Outcomes
•	Core understanding of clock division and precision.
•	Difference between simulation and hardware-level timing.
•	Proper handling of slow logic through clock enables signals.
________________________________________
Medium Project — Multi-Domain Synchronization System
Objective
Design a dual-clock data transfer system that moves data between asynchronous clock domains safely, addressing metastability through synchronizers and FIFO buffering.
Background
This project introduces clock domain crossing (CDC), one of the most important concepts in professional RTL work. You’ll design a small system that uses independent clock sources and ensures clean communication between them without data corruption.
Tasks
1.	Clock Generation: Use the Vivado Clocking Wizard to derive two blocks from the 100 MHz source: one at 50 MHz and another at 3.125 MHz.
2.	FIFO Design: Create a dual-clock FIFO that allows data writes in one domain and reads in another. Implement full, empty, and error flags.
3.	Data Path and Indicators: Input 8-bit data through switches and observe received values on LEDs. Add a visual indicator for FIFO errors or metastability warnings.
4.	Verification and Analysis: Simulate the design using phase-shifted clocks. Check that all domain crossings use synchronizers or the FIFO interface. Analyse Vivado’s timing summary to confirm no unsafe paths remain.
Deliverables
•	Verilog source files for FIFO, synchronizers, and top-level integration.
•	Clocking Wizard configuration files.
•	Timing constraints (.xdc) and analysis report.
Learning Outcomes
•	Understanding multi-clock domain design.
•	Safe synchronization and metastability mitigation.
•	Reading and interpreting timing summaries and CDC reports.
________________________________________
Advanced Project — Pipelined ALU with Clock Gating and Timing Analysis
Objective
Implement a four-stage pipelined ALU optimized for timing closure and efficient clock usage. Apply clock enable logic, analyse timing paths, and optimize the design for higher clock frequencies.
Background
This project focuses on timing closure—the point where functional design meets performance constraints. You’ll use pipelining and clock gating techniques to push performance boundaries while maintaining timing safety.
Tasks
1.	ALU Design: Build a 16-bit ALU supporting ADD, SUB, AND, OR, XOR, and shift operations. Control signals determine the active operation.
2.	Pipeline Stages: Structure the ALU into four pipeline stages: Operand Fetch, Decode, Execute, and Writeback. Register outputs at each stage boundary.
3.	Clock Enable and Gating: Use clock enables signals to activate the ALU only when valid data is available. Avoid manual clock gating.
4.	Timing Constraints and Analysis: Define a primary clock constraint (10 ns for 100 MHz or more aggressive for testing). Generate and analyse timing reports for critical path and slack.
5.	Performance Verification:  Validate functionally through simulation, then confirm post-implementation timing. Incrementally optimize logic until the design meets or exceeds target Fmax.
Deliverables
•	Verilog source for pipelined ALU and control logic.
•	Vivado timing summary and critical path report.
•	Comparison of pre- and post-optimization Fmax.
Learning Outcomes
•	Static timing analysis (STA) fundamentals.
•	Pipeline and clock enable design.
•	Timing optimization and closure methods.
________________________________________
Workflow and Standards
Each project should follow a clean, repeatable process—much like an in-house engineering task:
1.	Read and interpret the design requirement. Write your own internal spec before coding.
2.	Sketch architecture and identify critical timing paths early.
3.	Code cleanly with meaningful names and consistent style.
4.	Simulate thoroughly before synthesis.
5.	Synthesize and implement in Vivado. Inspect resource use and timing violations.
6.	Test on hardware and log results with explanations.
7.	Document everything clearly—waveforms, measurements, timing screenshots.
________________________________________
Closing Note
These projects are intended to move you from writing functional RTL to designing for performance and hardware predictability. Once completed, you’ll have practical grounding in how real FPGA clock networks, timing paths, and synchronizers behave under load.
The goal isn’t just to code—it’s to think and execute like a timing-aware RTL designer.

These projects can be directly run with the help of the tcl file. Just download the repo to your local system and open the Xilinx Vivado 2025.1.1 and you should be able see the complete built.

Happy Learning,
Regards,
Aditya Sarma Nuthalapati
________________________________________

 

