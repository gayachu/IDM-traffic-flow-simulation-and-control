clear; clc;

% 1) Model parameters
params.N      = 50;      % number of cars
params.L      = 1000;    % ring length [m]
params.ell    = 5;       % car length [m]
params.v0     = 30;      % desired speed [m/s]
params.a      = 0.73;       % max accel [m/s^2]
params.b      = 1.67;       % comfortable decel [m/s^2]
params.s0     = 2;       % min gap [m]
params.Tgap   = 1.5;     % headway [s]
params.delta  = 4;       % exponent
  
% 2) Initial conditions: 

total_spacing = params.ell + 5;  % only 10 m spacing
x0 = (0:params.N-1)' * total_spacing;

sigma = 1;                 % standard deviation of 1 m
shift = sigma * rand(params.N,1);  
x0   = x0 + shift;
% now add a very small perturbation to car 1's position:
  % N×1 vector
rng(2);
v_init = params.v0 * rand(params.N,1);   % fully random between 0 and 30

z0 = [x0; v_init];
                           % 2N×1 initial state

% 3) Integrate with ode45
tspan = [0, 300];  % simulate 60 seconds
opts  = odeset('RelTol',1e-6, 'AbsTol',1e-8);
[t, z] = ode45(@(t,z) ncarIDM_ring(t, z, params), tspan, z0, opts);

% 4) Extract unwrapped positions and velocities
x = z(:, 1:params.N);
v = z(:, params.N+1 : 2*params.N);


figure; hold on; grid on;
offsets = (0:params.N-1)' * 50;  % adjust spacing for clarity
for i = 1:params.N
  plot(t, x(:,i) + offsets(i), 'k-');
end
xlabel('Time [s]');
ylabel('Cumulative distance');
title('50-Car IDM on Ring: Trajectories');

%%
v = z(:, params.N+1 : 2*params.N);
figure; hold on; grid on;
for i=1:params.N
    plot(t, v(:,i));
end
xlabel('Time [s]');
ylabel('Speed [m/s]');
title('All Cars: Velocity vs Time');