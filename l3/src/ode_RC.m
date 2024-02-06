function dydt = ode_RC(t,y,t_g,g)
 %note that t is scalar the ode45 provides
 %note that y is value of the solution at the previous time step
 %note that t_g is time vector for the forcing function
 %note that g is the vector of data representing the forcing function
 
 R = 5.1e3;
 C = 3.3e-6;
 k = 1/(R*C);
 
 g_at_t = interp1(t_g,g,t); % Interpolate the data set (gt,g) at time t
 dydt = -k*y + k*g_at_t; % Evalute ODE at time t






 end
