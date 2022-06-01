%% DynamometerSimulation by Sina Atalay
% Spring 2022
% Simulation of an electric dynamometer with a PID controller.
clc
%%
clear CalculateR_l
close all
%% Specifications of the system
% Check README.md

% The test motor:
V_t = 12; % [V]
K_T_t = 2 / 44; % [N*m/A]
K_emf_t = 2 / 44 / 0.993287399771488; % [V*s]
R_t = V_t * K_T_t / 2.3; % [ohm]
L_t = 1.5 * 10^-3; % [H]
TestMotor = [V_t, K_T_t, K_emf_t, R_t, L_t];

% Connection:
n = 50;
I = 0.025; % [kg*m^2]
c = 0.001; % [N*s]
Connection = [n, I, c];

% The load motor:
K_emf_l = 0.02; % [V*s]
K_T_l = 0.02; % [N*m/A]
R_l_minimum = 5; % [ohm]
L_l = L_t; % [H]

LoadMotor = [K_emf_l, K_T_l, R_l_minimum, L_l];

%% PID Control
DesiredLoad = 1.6; % [Nm]
StartToControl = 10; % [s]

% Tuning:
Kp = 1000;
Kd = 0;
Ki = 1000;
PIDTune = [Kp, Kd, Ki];

% Simulation:
Dots = @(t, x) xDot(t, x, DesiredLoad, StartToControl, PIDTune, TestMotor, Connection, LoadMotor);
[t, x] = ode15s(Dots, [0, 30], [0, 0, 0]);
C = [0, 0, n * K_T_l; ...
    0, 60 / (2 * pi), 0];
y = C * x';

% Plot the results:
yyaxis left
plot(t, y(1, :));
hold on;
ylabel("Measured Torque (Nm)");
xlabel("Time (seconds)");
yline(DesiredLoad, "--");
yyaxis right
plot(t, y(2, :));
hold off;
ylabel("Measured Speed (RPM)");