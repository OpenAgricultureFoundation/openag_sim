function [e_val] = env_fun(J, QSW, theta, light, Omega, aux_paras, Flag_environment)
//      env_factor_curve          calculate the daily e accumulation according to certain environmental factor curves
//      theta   -   the temperature of current day
//      light   -   the light intensity of current day
//      Omega   -   parameter set of the environmental factor curve, [a b alpha beta]
//

K1      = Omega(1);
K2      = Omega(2);
a       = Omega(3);
b       = Omega(4);
Alpha   = Omega(5);
Beta    = Omega(6);

QSW_MIN      = aux_paras(1);
QSW_MAX      = aux_paras(2);
THETA_MIN   = aux_paras(3);
THETA_MAX   = aux_paras(4);
LIGHT_MIN   = aux_paras(5);
LIGHT_MAX   = aux_paras(6);
E0          = aux_paras(7);

//
// NOTE: for intergration of water effect, the soil water budget should be daily calculated too, 
//       as arise the puzzle because daily plant biomass production is not calculated. 
//       There is no such puzzle when we consider water supply at growth cycle level
//

e_val   = E0;
if Flag_environment(1) == 1 then
    //ew_val  = ones(size(QSW));
    y       = (QSW(J) - QSW_MIN) ./ (QSW_MAX - QSW_MIN);
    ym      = (K1-1) / (K1+K2-2);
    Normwt  = ym^(K1-1) .* (1-ym)^(K2-1);
    ew_val  = y.^(K1-1) .* (1-y).^(K2-1) /Normwt;
    e_val   = e_val * ew_val;
end

if Flag_environment(2) == 1 then
    //et_val  = ones(size(theta));
    x       = (theta(J)-THETA_MIN) ./ (THETA_MAX-THETA_MIN);
    xm      = (Alpha-1)/(Alpha+Beta-2);
    Normbeta= xm^(Alpha-1) .* (1-xm)^(Beta-1);
    et_val  = x.^(Alpha-1) .* (1-x).^(Beta-1) /Normbeta;
    e_val   = e_val * et_val;
end

if Flag_environment(3) == 1 then
    //el_val  = ones(size(light));
    el_val  = a * (1-exp(-b*light(J))); 
    e_val   = e_val * el_val;
end

// here 1000 should be E under potential conditions*
endfunction
