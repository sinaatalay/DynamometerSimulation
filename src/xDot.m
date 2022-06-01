function result = xDot(t, x, DesiredLoad, StartControl, PIDTune, TestMotor, Connection, LoadMotor)
    % Returns the derivaties of the states.
    V_t = TestMotor(1);
    K_T_t = TestMotor(2);
    K_emf_t = TestMotor(3);
    R_t = TestMotor(4);
    L_t = TestMotor(5);

    n = Connection(1);
    I = Connection(2);
    c = Connection(3);

    K_emf_l = LoadMotor(1);
    K_T_l = LoadMotor(2);
    R_l_min = LoadMotor(3);
    L_l = LoadMotor(4);

    if (t > StartControl)
        R_l = CalculateR_l(t, x, DesiredLoad, PIDTune, K_T_l, n, R_l_min);
    else
        R_l = 99999; % Practically zero load.
    end

    A = [-R_t / L_t, -K_emf_t / L_t, 0; ...
        K_T_t / I, -c / I, -n * K_T_l / I; ...
        0, n * K_emf_l / L_l, -R_l / L_l];
    B = [V_t / L_t; 0; 0];

    result = A * x + B;
end