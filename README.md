# Dynamometer Simulation [![License](https://img.shields.io/github/license/sinaatalay/DynamometerSimulation.svg)](https://github.com/sinaatalay/DynamometerSimulation/blob/main/LICENSE)
This program simulates an electric dynamometer with a PID controller.

An **absorption dynamometer**, also known as a" **dyno**", is a device that measures the instantaneous rotational speed and torque of an engine, motor, or any rotating prime mover while acting as a load. This is accomplished by using various methods to brake the tested motor. Electric dynamometers use another DC motor (a **load motor**) as a generator and couple it with the **test motor** to produce an opposing torque that resists the motion. The graphical representation of the dynamometer is illustrated below.

<p align="center">
	<picture>
	  <source media="(prefers-color-scheme: dark)" srcset="https://github.com/sinaatalay/DynamometerSimulation/blob/main/figures/SchematicDarkMode.png?raw=true">
	  <source media="(prefers-color-scheme: light)" srcset="https://github.com/sinaatalay/DynamometerSimulation/blob/main/figures/Schematic.png?raw=true">
	  <img alt="Schematic" src="https://github.com/sinaatalay/DynamometerSimulation/blob/main/figures/Schematic.png?raw=true">
	</picture>
</p>

We want to control the torque of the test motor by adjusting R<sub>l</sub>. The system is modeled using the fundamental principles, and the state-space representation of the system model is shown below.

$$
\\left\\lbrack \\begin{matrix} \\dot{i_t } \\\\ \\dot{\\omega} \\\\ \\dot{i_l }  \\end{matrix}\\right\\rbrack =\\left\\lbrack \\begin{matrix} {-R}\_t/L_t & {-K}\_{\\text{emf},t}/L_t & 0\\\\ K\_{T,t} /I & -c/I & -{nK}\_{T,l} /I\\\\ 0 & {nK}\_{\\text{emf},l} /L_l & {-R}\_l(t) /L_l \\end{matrix}\\right\\rbrack \\left\\lbrack \\begin{matrix} i_t \\\\ \\omega \\\\ i_l  \\end{matrix}\\right\\rbrack +\\left\\lbrack \\begin{matrix} 1/L_t \\\\ 0\\\\ 0 \\end{matrix}\\right\\rbrack \\left\\lbrack \\begin{matrix} V\_{\\text{in}}  \\end{matrix}\\right\\rbrack
$$

The objective is to simulate the system's closed-loop response to investigate the behavior. The tricky part is that $R_l(t)$ is not a standard input like a voltage or current source but rather a property of the system. This makes the system a time-variant system and hard to analyze with the [Control System Toolbox](https://www.mathworks.com/products/control.html) of [MATLAB](https://www.mathworks.com/products/matlab.html). Fortunately, the system is linear, and the closed-loop response is simulated with the [ode15s](https://www.mathworks.com/help/matlab/ref/ode15s.html) function. The block diagram of the system can be seen below.

<p align="center">
	<picture>
	  <source media="(prefers-color-scheme: dark)" srcset="https://github.com/sinaatalay/DynamometerSimulation/blob/main/figures/BlockDiagramDarkMode.png?raw=true">
	  <source media="(prefers-color-scheme: light)" srcset="https://github.com/sinaatalay/DynamometerSimulation/blob/main/figures/BlockDiagram.png?raw=true">
	  <img alt="Block Diagram" src="https://github.com/sinaatalay/DynamometerSimulation/blob/main/figures/BlockDiagram.png?raw=true">
	</picture>
</p>
