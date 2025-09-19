function dzdt = ncarIDM_ring(t, z, params)
  % Unpack parameters
  N     = params.N;         % now arbitrary
  ell   = params.ell;
  v0    = params.v0;        % scalar desired speed
  a     = params.a;
  b     = params.b;
  s0    = params.s0;
  Tgap  = params.Tgap;
  delta = params.delta;
  L     = params.L;         % ring length

  % Split state
  x = z(1:N);
  v = z(N+1:2*N);

  dxdt = zeros(N,1);
  dvdt = zeros(N,1);

  for i = 1:N
    % Index of car in front (wrap-around)
    ip = mod(i, N) + 1;

    % Wrap positions into [0,L)
    xi  = mod(x(i),  L);
    xip = mod(x(ip), L);

    % Compute forward gap along ring
    s_i = xip - xi - ell;
    if s_i < 0
      s_i = s_i + L;
    end

    % Relative speed
    dv_rel = v(i) - v(ip);

    % Desired (safe) gap
    s_star = s0 + v(i)*Tgap + v(i)*dv_rel/(2*sqrt(a*b));
    v_mean = mean(v);
    u = -0.7*(v(i)-v_mean);
    
    % Kinematics
    dxdt(i)    = v(i);
    if i == 1 || i == 2
    dvdt(i)    = a*(1 - (v(i)/v0)^delta - (s_star/s_i)^2) + u;
    else
        dvdt(i)    = a*(1 - (v(i)/v0)^delta - (s_star/s_i)^2);
    end


  end

  dzdt = [dxdt; dvdt];
end