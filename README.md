# Dynamometer Simulation [![License](https://img.shields.io/github/license/sinaatalay/DynamometerSimulation.svg)](https://github.com/sinaatalay/DynamometerSimulation/blob/main/LICENSE)
This program simulates an electric dynamometer with a PID controller.

An **absorption dynamometer**, also known as a" **dyno**", is a device that measures the instantaneous rotational speed and torque of an engine, motor, or any rotating prime mover while acting as a load. This is accomplished by using various methods to brake the tested motor. Electric dynamometers use another DC motor (a **load motor**) as a generator and couple it with the **test motor** to produce an opposing torque that resists the motion. The graphical representation of the dynamometer is illustrated below.

<p align="center">
  <img src="https://github.com/sinaatalay/DynamometerSimulation/blob/main/figures/Schematic.png?raw=true" alt="Schematic"/>
</p>

We want to control the torque of the test motor by adjusting R<sub>l</sub>. The system is modeled using the fundamental principles, and the state-space representation of the system model is shown below.

<p align="center">
  <img src="https://latex.codecogs.com/svg.image?%5Cinline%20%5Chuge%20%5Cleft%5Clbrack%20%5Cbegin%7Bmatrix%7D%20%5Cdot%7Bi_t%20%7D%20%5C%5C%20%5Cdot%7B%5Comega%7D%20%5C%5C%20%5Cdot%7Bi_l%20%7D%20%20%5Cend%7Bmatrix%7D%5Cright%5Crbrack%20=%5Cleft%5Clbrack%20%5Cbegin%7Bmatrix%7D%20%5Cfrac%7B%7B-R%7D_t%20%7D%7BL_t%20%7D%20&%20%5Cfrac%7B%7B-K%7D_%7B%5Ctext%7Bemf%7D,t%7D%20%7D%7BL_t%20%7D%20&%200%5C%5C%20%5Cfrac%7BK_%7BT,t%7D%20%7D%7BI%7D%20&%20%5Cfrac%7B-c%7D%7BI%7D%20&%20%5Cfrac%7B-%7BnK%7D_%7BT,l%7D%20%7D%7BI%7D%5C%5C%200%20&%20%5Cfrac%7B%7BnK%7D_%7B%5Ctext%7Bemf%7D,l%7D%20%7D%7BL_l%20%7D%20&%20%5Cfrac%7B%7B-R%7D_l(t)%20%7D%7BL_l%20%7D%20%5Cend%7Bmatrix%7D%5Cright%5Crbrack%20%5Cleft%5Clbrack%20%5Cbegin%7Bmatrix%7D%20i_t%20%5C%5C%20%5Comega%20%5C%5C%20i_l%20%20%5Cend%7Bmatrix%7D%5Cright%5Crbrack%20&plus;%5Cleft%5Clbrack%20%5Cbegin%7Bmatrix%7D%20%5Cfrac%7B1%7D%7BL_t%20%7D%5C%5C%200%5C%5C%200%20%5Cend%7Bmatrix%7D%5Cright%5Crbrack%20%5Cleft%5Clbrack%20%5Cbegin%7Bmatrix%7D%20V_%7B%5Ctext%7Bin%7D%7D%20%20%5Cend%7Bmatrix%7D%5Cright%5Crbrack" alt="StateSpaceModel"/>
</p>

The objective is to simulate the system's closed-loop response to investigate the behavior. The tricky part is that R<sub>l</sub> is not a standard input like a voltage or current source but rather a property of the system. This makes the system a time-variant system and hard to analyze with the [Control System Toolbox](https://www.mathworks.com/products/control.html) of [MATLAB](https://www.mathworks.com/products/matlab.html). Fortunately, the system is linear, and the closed-loop response is simulated with the [ode15s](https://www.mathworks.com/help/matlab/ref/ode15s.html) function. The block diagram of the system can be seen below.

<p align="center">
  <img src="https://github.com/sinaatalay/DynamometerSimulation/blob/main/figures/BlockDiagram.png?raw=true" alt="BlockDiagram"/>
</p>
