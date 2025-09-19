# IDM-traffic-flow-simulation-and-control
Simulating traffic using the Intelligent Driver Model (IDM) equations and implementing control.

## Overview 
- Implemented the Intelligent Driver Model (IDM) to simulate traffic flow.
- Simulations used 50 vehicles on a circular 1000$m$ road.
- Studied traffic stability and formation of jams.
- Implemeted simple control on the first two vehicles to see if it manages to control the entire platoon.

## Equations
The system is given by:

$$
\dot{x}_i = v_i
$$

$$
\dot{v}_i = a \left(1 - \left(\frac{v_i}{v_0}\right)^\delta - \left(\frac{s^*(v_i, \Delta v_i)}{s_i}\right)^2 \right)
$$

where

$$
s^*(v_i, \Delta v_i) = s_0 + v_i T + \frac{v_i \Delta v_i}{2\sqrt{ab}}
$$

- $x_i$: position of vehicle *i*  
- $v_i$: velocity of vehicle *i*  
- $s_i = x_{i-1} - x_i$: net distance gap  
- $\Delta v_i = v_i - v_{i-1}$: relative velocity
  
## Model Parameters

| Symbol      | Description                                  | Value        |
|:------------|:---------------------------------------------|:-------------|
| $N$       | Number of vehicles on the ring               | 50           |
| $L$       | Ring circumference [m]                       | 1000         |
| $\ell$    | Vehicle length [m]                           | 5            |
| $v_{0}$   | Desired (free‐flow) speed [m/s]              | 30           |
| $a$       | Maximum acceleration [m/s²]                  | 1.5          |
| $b$       | Comfortable deceleration [m/s²]              | 1.67         |
| $s_{0}$   | Minimum bumper‐to‐bumper gap [m]             | 2            |
| $T$       | Desired time gap [s]                         | 1.5          |
| $\delta$  | Acceleration exponent (unitless)             | 4            |

## Control Strategy
Control of $u = -0.7*(v_i - v_m)$ where $v_m$ is the mean of all the velocities is applied. This essentially acts as a damper, ensuring all the vehicles start operating at the mean velocity, effectively damping out any stop-and-go waves. This control is only applied to the first and second cars, and the effective equations only for the first two cars become - 

$$
\dot{x}_i = v_i
$$

$$
\dot{v}_i = a \left(1 - \left(\frac{v_i}{v_0}\right)^\delta - \left(\frac{s^*(v_i, \Delta v_i)}{s_i}\right)^2 \right) + u
$$

## Results

### Before control : stop and go waves observed 

 <img width="675" height="542" alt="image" src="https://github.com/user-attachments/assets/6081cd93-b2c1-4ed6-970c-515243a3828b" />
 <img width="667" height="541" alt="image" src="https://github.com/user-attachments/assets/33374792-bfe4-44ad-aa16-197a47468e2e" />


 
### After control : stop-and-go waves are suppressed and the whole fleet quickly converges to a smooth, uniform cruise at the mean speed.
 <img width="683" height="552" alt="image" src="https://github.com/user-attachments/assets/821f38de-847e-439a-83f6-8a9de7af986f" />
 <img width="662" height="542" alt="image" src="https://github.com/user-attachments/assets/509d4dee-0c42-460e-821d-9b9ea2c1fc78" />





