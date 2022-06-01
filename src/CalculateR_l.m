function R_l = CalculateR_l(t, x, DesiredLoad, PIDTune, K_T_l, n, R_l_min)
    %Returns the R_l value, calculated with PID.
    persistent t_prev i_l_prev Integral
    if (isempty(t_prev))
        Integral = 0;
        t_prev = t;
        i_l_prev = x(3);
    end

    Kp = PIDTune(1);
    Kd = PIDTune(2);
    Ki = PIDTune(3);

    % PROPORTIONAL:
    P = -(DesiredLoad - n * x(3) * K_T_l);
    R_l = Kp * P;

    % INTEGRAL:
    Integral = Integral - (DesiredLoad - n * x(3) * K_T_l) * (t - t_prev);
    R_l = R_l + Ki * Integral;

    % DERIVATIVE:
    if (t ~= t_prev)
        D = (n * x(3) * K_T_l - n * i_l_prev * K_T_l) / (t - t_prev);
        R_l = R_l + Kd * D;
    end
    i_l_prev = x(3);
    t_prev = t;

    R_l = max([R_l_min, R_l]);
end